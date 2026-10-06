/* NutriFit — service worker.
   1) Notificaciones push (push + notificationclick).
   2) Actualizaciones sin reinstalar: la página (index.html) se pide SIEMPRE
      nueva a GitHub, saltándose cualquier copia vieja que guarde el iPhone.
      Solo si no hay conexión se usa la última copia buena guardada aquí.
   El resto de archivos (iconos, fotos, Supabase...) no se tocan. */
const SHELL_CACHE = 'nf-shell-v1';
const SHELL_KEY = './index.html';

self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil(self.clients.claim()));

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET' || req.mode !== 'navigate') return;
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
