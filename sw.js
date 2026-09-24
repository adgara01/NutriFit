/* NutriFit — service worker SOLO para notificaciones push.
   A propósito no tiene "fetch" ni guarda nada en caché: la app se sigue
   cargando siempre fresca de GitHub Pages, como hasta ahora (así no se
   añaden más problemas de versiones viejas en el iPhone). */
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil(self.clients.claim()));

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

// Tocar la notificación: abre (o trae al frente) la app en el chat / Muro.
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
