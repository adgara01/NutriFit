---
name: "pwa-modo-iphone-premium"
description: "Dar a una PWA de Adri (index.html + Supabase + GitHub Pages) aspecto y tacto de app nativa de iPhone moderna y rápida: materiales con desenfoque, tipografía del sistema, hojas con muelle, toques de 44 pt, zonas seguras, vibración, transiciones entre pantallas y un presupuesto de velocidad medido. Usar al pulir una pantalla, crear una nueva o cuando algo 'no se siente de iPhone' o va lento."
---

# Modo iPhone premium

Responder en castellano, corto. Leer el `index.html` antes de tocar nada y reutilizar lo que ya exista (`showModal/hideModal`, variables CSS, `attachSwipeToCloseSheet`...).
Va junto a `pwa-diseno-estilo-adri` (iconos, textos, esquinas, acento), que manda si chocan, y a `pwa-fluidez-animaciones` (gestos, interfaz optimista, fotos), que no se repite aquí.

**Objetivo:** que cada toque responda en menos de 100 ms, que todo se mueva a 60 fps y que nada parezca una web.

## 1. Base (una vez por app)
- Viewport: `width=device-width, initial-scale=1, viewport-fit=cover`. Sin `user-scalable=no` (iOS lo ignora). El zoom al enfocar se evita con `font-size:16px` mínimo en `input/textarea/select`.
- `html{-webkit-text-size-adjust:100%; -webkit-tap-highlight-color:transparent;}` y `body{overscroll-behavior-y:none;}`. En botones e iconos, `user-select:none; -webkit-touch-callout:none`, pero nunca en textos que el usuario quiera copiar.
- Alto de pantalla: `100dvh` (nunca `100vh`). Zonas seguras con `env(safe-area-inset-*)` en la barra de arriba, la barra de pestañas, las hojas y los botones flotantes.
- `theme-color` y `apple-mobile-web-app-status-bar-style` a juego con el fondo, en claro y en oscuro.
- Tipografía: `font-family:-apple-system, BlinkMacSystemFont, "SF Pro Text", system-ui, sans-serif;` y `-webkit-font-smoothing:antialiased`. Cifras que cambian (kcal, contadores, temporizadores) con `font-variant-numeric:tabular-nums` para que no bailen.
- Escala de texto con pocos tamaños (como la de iOS): 34 título grande · 22 título · 17 cuerpo · 15 secundario · 13 nota · 11 etiqueta. Peso 600-700 para títulos; nunca más de tres pesos por pantalla.

## 2. Aspecto nativo
- **Materiales:** barras y menús flotantes translúcidos, nunca opacos encima de contenido:
  `background:rgb(var(--bg-rgb)/.72); -webkit-backdrop-filter:saturate(180%) blur(20px); backdrop-filter:saturate(180%) blur(20px);`
  con una línea de 0,5 px (`box-shadow:0 .5px 0 var(--border)`) en lugar de bordes gruesos. Hay que dar un color de respaldo opaco si `backdrop-filter` no existe (`@supports not (backdrop-filter:blur(1px))`).
- **Título grande:** en las pantallas principales, el título grande arriba encoge a la barra pequeña al hacer scroll. Hacerlo con `IntersectionObserver` sobre el título, nunca con un listener de scroll que lea el layout.
- **Listas estilo Ajustes:** grupos con fondo `--card` y esquinas de 12 px; filas de 44 pt mínimo con separador de 0,5 px que empieza donde empieza el texto (no bajo el icono), y chevron gris a la derecha.
- **Hojas:** asa de 36×5 px arriba, esquina superior de 14-20 px, fondo detrás oscurecido al 30-40 %. Las alturas son media hoja o hoja completa, nada intermedio.
- **Menús contextuales:** salen junto al botón que los abre, crecen desde esa esquina (`transform-origin`) y tienen filas de 44 pt con el icono gris. Las acciones destructivas van en rojo y al final.
- **Sombras:** pocas y suaves (`0 8px 30px rgb(0 0 0/.12)`). En oscuro, sin sombras: la profundidad la marca un fondo un tono más claro.
- **Toques:** zona mínima de 44×44 pt aunque el icono sea de 20. Si el diseño lo pide pequeño, agrandar la zona con padding o con un `::before` invisible.
- **Estados vacíos y de carga:** nada de spinners a pantalla completa. Usar esqueletos con la forma real del contenido y un brillo suave, y cuando hay caché local, pintar directamente.

## 3. Movimiento
Usar siempre las mismas variables:
```css
:root{
  --ease-out:cubic-bezier(.32,.72,0,1);           /* la curva de la app */
  --ease-spring:linear(0,.38 9%,.79 19%,1.02 30%,1.06 37%,1.03 46%,.99 58%,1);  /* muelle con un pelín de rebote */
  --t-tap:120ms; --t-fast:200ms; --t-sheet:380ms;
}
```
- **Duraciones:** toque 100-150 ms · aparecer o desaparecer 200 ms · hoja o pantalla 320-420 ms. Cerrar siempre más rápido que abrir (~70 %).
- **El muelle (`--ease-spring`)** solo en cosas que "aterrizan": una hoja al soltarla, un chip añadido, un contador que sube. Todo lo demás con `--ease-out`.
- **Pulsar:** `:active{transform:scale(.97)}` en botones y `scale(.98)` en tarjetas. Además, un leve oscurecido con `filter:brightness(.95)` o fondo `--card2`.
- **Entre pantallas:** usar la View Transitions API (Safari 18+) si existe, y si no, cambiar sin animar:
  ```js
  function go(fn){ document.startViewTransition && !REDUCED_MOTION ? document.startViewTransition(fn) : fn(); }
  ```
  Con `view-transition-name` en la foto de un plato, pasa de la lista a la ficha "volando". Un solo elemento con nombre por transición; quitárselo al terminar.
- **Listas:** al añadir, la fila nueva aparece con un fundido y un desplazamiento de 6 px. Al borrar, se encoge en altura y opacidad, y después se elimina del DOM.
- **Números que cambian** (kcal del día, racha): contar hasta el valor nuevo en ~400 ms con `requestAnimationFrame`, nunca con `setInterval`.
- **`prefers-reduced-motion`:** quitar los desplazamientos y el muelle, y dejar solo fundidos de ≤150 ms.
- **Prohibido:** animar `width/height/top/left/box-shadow/filter:blur` en bucle, animaciones que duren más de 500 ms y rebotes en cosas que no se sueltan con el dedo.

## 4. Vibración (háptica)
- iOS no tiene `navigator.vibrate`. El truco conocido desde iOS 18 es pulsar por código un `<input type="checkbox" switch>` oculto con su `<label>`: Safari da un toque háptico.
  ```js
  const hap = (()=>{ const l=document.createElement('label'); l.ariaHidden='true'; l.style.display='none';
    const i=document.createElement('input'); i.type='checkbox'; i.setAttribute('switch',''); l.append(i); document.body.append(l);
    return ()=>{ try{ navigator.vibrate ? navigator.vibrate(8) : l.click(); }catch(_){} }; })();
  ```
  Solo funciona dentro de un toque real del usuario, y hay que comprobarlo en el iPhone porque Apple lo puede cambiar.
- Usarla solo al completar algo (guardar, marcar hecho, llegar al final del modo cocina), al cruzar el umbral de un gesto (deslizar para borrar o cerrar) y al llegar al tope de un selector. Nunca en cada toque.

## 5. Velocidad (presupuesto)
| Qué | Límite |
|---|---|
| Respuesta visual a un toque | < 100 ms (pintar primero, guardar después) |
| Abrir una hoja o pantalla | primer fotograma < 50 ms |
| Tareas largas en el hilo principal | ninguna > 50 ms al tocar |
| Arranque con caché | contenido pintado < 1 s |
| Scroll | 60 fps sin saltos con CPU ×4 |

- **Primero pintar, luego trabajar:** abrir la hoja ya con lo que hay en memoria y completar el resto en el siguiente fotograma (`requestAnimationFrame` y después `setTimeout 0`) o en `requestIdleCallback`.
- **Nada de layout thrashing:** primero leer todas las medidas y después escribir. No leer `offsetHeight` ni `getBoundingClientRect` dentro de bucles ni de `touchmove`.
- **Listeners `{passive:true}`** en `touchstart/touchmove/wheel/scroll`, salvo el gesto que de verdad necesita `preventDefault`.
- **`will-change:transform`** solo mientras dura el gesto o la animación, y quitarlo después. Nunca dejarlo fijo en decenas de elementos.
- **Desenfoque:** `backdrop-filter` cuesta. Como máximo dos capas con desenfoque a la vez en pantalla y ninguna dentro de listas que hacen scroll.
- **Listas largas:** paginar o virtualizar a partir de unas 100 filas. Usar `contain:content` en tarjetas independientes.
- **Fuentes del sistema** (cero descargas), iconos SVG en línea y nada de librerías de animación: CSS y Web Animations API bastan.
- **Precarga al tocar:** en `pointerdown` (no en `click`) empezar a cargar los datos o la foto grande de lo que se va a abrir.

## 6. Comprobar antes de entregar
1. Playwright a 390×844 (iPhone) y 1366 px, en claro y en oscuro: capturas de la pantalla tocada y de sus estados (vacío, cargando, lleno, error).
2. Con la CPU a ×4 (`Emulation.setCPUThrottlingRate` por CDP): abrir y cerrar la hoja, hacer scroll en la lista y comprobar que no hay tareas de más de 50 ms (`PerformanceObserver` con `longtask`).
3. Con `prefers-reduced-motion: reduce` emulado, que todo siga funcionando sin desplazamientos.
4. Revisar que todos los toques miden al menos 44 pt, que nada queda bajo la isla dinámica ni la barra de inicio, y que no hay zoom al enfocar campos.
5. Subir `APP_VERSION`, hacer commit y push a `main` (Adri lo ha pedido así) y avisar de lo que hay que mirar en el iPhone real: la vibración, el desenfoque y los gestos.
