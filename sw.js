/* NutriFit — service worker.
   1) Notificaciones push (push + notificationclick).
   2) Actualizaciones sin reinstalar: la página (index.html) se pide SIEMPRE
      nueva a GitHub, saltándose cualquier copia vieja que guarde el iPhone.
      Solo si no hay conexión se usa la última copia buena guardada aquí.
   3) Fotos al instante: las fotos de platos y de perfil (Supabase Storage)
      nunca cambian una vez subidas (cada foto nueva va a una ruta nueva), así
      que la primera vez se descargan y se guardan aquí; las siguientes salen
      directamente del móvil, sin red. Se guardan las ~600 más recientes. */
const SHELL_CACHE = 'nf-shell-v1';
const SHELL_KEY = './index.html';
const IMG_CACHE = 'nf-img-v1';
const IMG_MAX = 600;
const IMG_RE = /\/storage\/v1\/object\/public\/(dish-photos|profile-photos)\//;

self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil((async () => {
  const keep = [SHELL_CACHE, IMG_CACHE];
  for (const k of await caches.keys()) if (!keep.includes(k)) await caches.delete(k);
  await self.clients.claim();
})()));

let trimTimer = null;
function trimImages() {
  clearTimeout(trimTimer);
  trimTimer = setTimeout(async () => {
    try {
      const c = await caches.open(IMG_CACHE);
      const keys = await c.keys();
      // Las más antiguas primero (orden de entrada): se quitan las que sobran.
      for (let i = 0; i < keys.length - IMG_MAX; i++) await c.delete(keys[i]);
    } catch (err) {}
  }, 4000);
}

async function imageResponse(req) {
  const url = req.url.split('#')[0];
  // Las fotos antiguas que se cambiaban en la misma ruta llevan ?v=: esas
  // también se pueden guardar (cada ?v= distinto es una entrada distinta).
  const cache = await caches.open(IMG_CACHE);
  const hit = await cache.match(url);
  if (hit) return hit;
  let resp;
  try {
    // En modo CORS (Supabase lo permite) para poder guardarla sin "relleno" opaco.
    resp = await fetch(url, { mode: 'cors', credentials: 'omit' });
  } catch (err) {
    return fetch(req); // sin CORS: que la pida el navegador tal cual
  }
  if (resp && resp.ok && resp.status === 200) {
    const copy = resp.clone();
    cache.put(url, copy).then(trimImages).catch(() => {});
  }
  return resp;
}

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  if (req.destination === 'image' && IMG_RE.test(req.url) && !req.url.includes('/render/image/')) {
    e.respondWith(imageResponse(req));
    return;
  }
  if (req.mode !== 'navigate') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;
  e.respondWith((async () => {
    try {
      const fresh = await fetch(req.url, { cache: 'no-store', credentials: 'same-origin' });
      if (fresh.ok) {
        const copy = fresh.clone();
        caches.open(SHELL_CACHE).then((c) => c.put(SHELL_KEY, copy)).catch(() => {});
      }
      // Una respuesta "redirigida" no se puede devolver tal cual a una navegación.
      if (fresh.redirected) {
        return new Response(await fresh.blob(), { status: fresh.status, statusText: fresh.statusText, headers: fresh.headers });
      }
      return fresh;
    } catch (err) {
      const hit = await caches.match(SHELL_KEY, { cacheName: SHELL_CACHE });
      if (hit) return hit;
      throw err;
    }
  })());
});

self.addEventListener('push', (e) => {
  let d = {};
  try { d = e.data ? e.data.json() : {}; }
  catch (err) { d = { body: e.data ? e.data.text() : '' }; }
  const title = d.title || 'NutriFit';
  e.waitUntil(self.registration.showNotification(title, {
    body: d.body || '',
    icon: 'icon-192.png',
    badge: 'icon-192.png',
    tag: d.tag || undefined,
    renotify: !!d.tag,
    data: { url: d.url || './' }
  }));
});

// Tocar la notificación: abre (o trae al frente) la app en lo que toque.
self.addEventListener('notificationclick', (e) => {
  e.notification.close();
  const url = new URL((e.notification.data && e.notification.data.url) || './', self.registration.scope).href;
  e.waitUntil((async () => {
    const wins = await self.clients.matchAll({ type: 'window', includeUncontrolled: true });
    for (const w of wins) {
      if ('focus' in w) {
        w.postMessage({ type: 'open-url', url });
        return w.focus();
      }
    }
    return self.clients.openWindow(url);
  })());
});
