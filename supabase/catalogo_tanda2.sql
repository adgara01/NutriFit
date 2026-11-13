-- ============================================================
-- NUTRIFIT — Catálogo de recetas (28 recetas, tanda2.json)
-- Recetas escritas para NutriFit. Fotos con licencia libre (CC BY / CC BY-SA)
-- y su autor en photo_credit; enlace a la foto original en photo_source.
-- ANTES: crea desde la app la cuenta de usuario «nutrifit» (perfil público).
-- Pégalo entero en Supabase → SQL Editor → Run. Se puede repetir sin problema.
-- ============================================================
alter table public.dishes add column if not exists photo_credit text;
alter table public.dishes add column if not exists photo_source text;

do $$
declare
  uid uuid;
  r jsonb;
  d public.dishes;
begin
  select id into uid from public.profiles where lower(username) = 'nutrifit' limit 1;
  if uid is null then
    raise exception 'Primero crea desde la app la cuenta con el usuario nutrifit';
  end if;

  for r in select * from jsonb_array_elements($json$[
 {
  "name": "Patatas bravas",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 4,
  "duration_min": 35,
  "ingredients": [
   {
    "name": "patata",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 200,
    "unit": "ml"
   },
   {
    "name": "salsa brava",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "alioli",
    "quantity": 60,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pela las patatas y córtalas en dados irregulares de unos 3 cm. Lávalas y sécalas bien."
   },
   {
    "key": "s2",
    "text": "Cuécelas 5 minutos en agua con sal y escúrrelas."
   },
   {
    "key": "s3",
    "text": "Fríelas en abundante aceite caliente hasta que estén doradas y crujientes, unos 10 minutos."
   },
   {
    "key": "s4",
    "text": "Escúrrelas en papel, sálalas y sírvelas con la salsa brava y el alioli por encima."
   }
  ],
  "description": "1. Pela las patatas y córtalas en dados irregulares de unos 3 cm. Lávalas y sécalas bien.\n\n2. Cuécelas 5 minutos en agua con sal y escúrrelas.\n\n3. Fríelas en abundante aceite caliente hasta que estén doradas y crujientes, unos 10 minutos.\n\n4. Escúrrelas en papel, sálalas y sírvelas con la salsa brava y el alioli por encima.",
  "image_url": "https://live.staticflickr.com/2793/4168435730_fb7e5c7964_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2793/4168435730_fb7e5c7964_b.jpg"
  ],
  "photo_credit": "Burger Baroness · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/66787975@N00/4168435730"
 },
 {
  "name": "Croquetas de jamón",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 4,
  "duration_min": 90,
  "ingredients": [
   {
    "name": "jamón serrano",
    "quantity": 120,
    "unit": "g"
   },
   {
    "name": "mantequilla",
    "quantity": 60,
    "unit": "g"
   },
   {
    "name": "harina",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "leche",
    "quantity": 700,
    "unit": "ml"
   },
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "pan rallado",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "aceite de girasol",
    "quantity": 300,
    "unit": "ml"
   },
   {
    "name": "nuez moscada",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Derrite la mantequilla, añade el jamón picado muy fino y rehógalo un minuto."
   },
   {
    "key": "s2",
    "text": "Incorpora la harina y cocínala 2 minutos sin dejar de remover."
   },
   {
    "key": "s3",
    "text": "Vierte la leche caliente poco a poco, sin parar de mover, hasta tener una bechamel espesa. Añade una pizca de nuez moscada."
   },
   {
    "key": "s4",
    "text": "Cocina 10 minutos más a fuego suave, pásala a una fuente, tápala con film a piel y deja que enfríe en la nevera al menos 2 horas."
   },
   {
    "key": "s5",
    "text": "Forma las croquetas, pásalas por huevo batido y pan rallado."
   },
   {
    "key": "s6",
    "text": "Fríelas en aceite bien caliente por tandas hasta que estén doradas y escúrrelas en papel."
   }
  ],
  "description": "1. Derrite la mantequilla, añade el jamón picado muy fino y rehógalo un minuto.\n\n2. Incorpora la harina y cocínala 2 minutos sin dejar de remover.\n\n3. Vierte la leche caliente poco a poco, sin parar de mover, hasta tener una bechamel espesa. Añade una pizca de nuez moscada.\n\n4. Cocina 10 minutos más a fuego suave, pásala a una fuente, tápala con film a piel y deja que enfríe en la nevera al menos 2 horas.\n\n5. Forma las croquetas, pásalas por huevo batido y pan rallado.\n\n6. Fríelas en aceite bien caliente por tandas hasta que estén doradas y escúrrelas en papel.",
  "image_url": "https://live.staticflickr.com/7207/7068664101_5053d961e4_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/7207/7068664101_5053d961e4_b.jpg"
  ],
  "photo_credit": "PincasPhoto · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/43243154@N07/7068664101"
 },
 {
  "name": "Gambas al ajillo",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "gamba",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 4,
    "unit": "diente"
   },
   {
    "name": "guindilla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 80,
    "unit": "ml"
   },
   {
    "name": "perejil fresco",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pela las gambas dejando la cola y sálalas."
   },
   {
    "key": "s2",
    "text": "Calienta el aceite en una cazuela de barro con los ajos laminados y la guindilla a fuego suave."
   },
   {
    "key": "s3",
    "text": "Cuando los ajos empiecen a dorarse, sube el fuego y echa las gambas."
   },
   {
    "key": "s4",
    "text": "Cocínalas un minuto por cada lado, espolvorea perejil picado y sirve en la misma cazuela, con pan para mojar."
   }
  ],
  "description": "1. Pela las gambas dejando la cola y sálalas.\n\n2. Calienta el aceite en una cazuela de barro con los ajos laminados y la guindilla a fuego suave.\n\n3. Cuando los ajos empiecen a dorarse, sube el fuego y echa las gambas.\n\n4. Cocínalas un minuto por cada lado, espolvorea perejil picado y sirve en la misma cazuela, con pan para mojar.",
  "image_url": "https://live.staticflickr.com/3535/3469398985_44333d1959_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3535/3469398985_44333d1959_b.jpg"
  ],
  "photo_credit": "goodiesfirst · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/49215102@N00/3469398985"
 },
 {
  "name": "Pimientos de Padrón",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 2,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "pimiento de padrón",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "sal gruesa",
    "quantity": 5,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Lava los pimientos y sécalos muy bien."
   },
   {
    "key": "s2",
    "text": "Fríelos en una sartén con el aceite caliente, moviéndolos, hasta que la piel se ampolle y se doren, unos 4 minutos."
   },
   {
    "key": "s3",
    "text": "Escúrrelos y sírvelos al momento con sal gruesa por encima."
   }
  ],
  "description": "1. Lava los pimientos y sécalos muy bien.\n\n2. Fríelos en una sartén con el aceite caliente, moviéndolos, hasta que la piel se ampolle y se doren, unos 4 minutos.\n\n3. Escúrrelos y sírvelos al momento con sal gruesa por encima.",
  "image_url": "https://live.staticflickr.com/8460/8053208567_6c89f221b1_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8460/8053208567_6c89f221b1_b.jpg"
  ],
  "photo_credit": "WordRidden · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/97844767@N00/8053208567"
 },
 {
  "name": "Champiñones al ajillo",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "champiñones",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 3,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
    "unit": "ml"
   },
   {
    "name": "vino blanco",
    "quantity": 40,
    "unit": "ml"
   },
   {
    "name": "perejil fresco",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Limpia los champiñones con un paño y córtalos en cuartos."
   },
   {
    "key": "s2",
    "text": "Dora el ajo laminado en el aceite a fuego medio."
   },
   {
    "key": "s3",
    "text": "Añade los champiñones, sube el fuego y saltéalos 5 minutos hasta que suelten el agua y se doren."
   },
   {
    "key": "s4",
    "text": "Echa el vino, deja que se evapore, sala y termina con perejil picado."
   }
  ],
  "description": "1. Limpia los champiñones con un paño y córtalos en cuartos.\n\n2. Dora el ajo laminado en el aceite a fuego medio.\n\n3. Añade los champiñones, sube el fuego y saltéalos 5 minutos hasta que suelten el agua y se doren.\n\n4. Echa el vino, deja que se evapore, sala y termina con perejil picado.",
  "image_url": "https://live.staticflickr.com/2522/4093374647_d1925f265f_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2522/4093374647_d1925f265f_b.jpg"
  ],
  "photo_credit": "Ewan-M · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/55935853@N00/4093374647"
 },
 {
  "name": "Hummus con crudités",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 4,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "garbanzos cocidos",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "tahini",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 40,
    "unit": "ml"
   },
   {
    "name": "comino",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "zanahoria",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "pepino",
    "quantity": 1,
    "unit": "ud"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Escurre los garbanzos y guarda un poco del líquido."
   },
   {
    "key": "s2",
    "text": "Tritúralos con el tahini, el zumo del limón, el ajo, la mitad del aceite, una pizca de comino y sal hasta que quede muy fino; si está espeso, añade un poco del líquido."
   },
   {
    "key": "s3",
    "text": "Sírvelo en un plato con un hilo de aceite y pimentón por encima."
   },
   {
    "key": "s4",
    "text": "Acompáñalo con la zanahoria y el pepino cortados en bastones."
   }
  ],
  "description": "1. Escurre los garbanzos y guarda un poco del líquido.\n\n2. Tritúralos con el tahini, el zumo del limón, el ajo, la mitad del aceite, una pizca de comino y sal hasta que quede muy fino; si está espeso, añade un poco del líquido.\n\n3. Sírvelo en un plato con un hilo de aceite y pimentón por encima.\n\n4. Acompáñalo con la zanahoria y el pepino cortados en bastones.",
  "image_url": "https://live.staticflickr.com/7222/7239466188_f8950c73b1_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/7222/7239466188_f8950c73b1_b.jpg"
  ],
  "photo_credit": "Phil Denton · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/37475039@N04/7239466188"
 },
 {
  "name": "Tosta de salmón ahumado y queso fresco",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 2,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "pan de centeno",
    "quantity": 120,
    "unit": "g"
   },
   {
    "name": "queso crema",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "salmón ahumado",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "eneldo fresco",
    "quantity": 3,
    "unit": "g"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Tuesta las rebanadas de pan."
   },
   {
    "key": "s2",
    "text": "Úntalas con el queso crema."
   },
   {
    "key": "s3",
    "text": "Coloca encima el salmón ahumado, unas gotas de limón y eneldo picado."
   }
  ],
  "description": "1. Tuesta las rebanadas de pan.\n\n2. Úntalas con el queso crema.\n\n3. Coloca encima el salmón ahumado, unas gotas de limón y eneldo picado.",
  "image_url": "https://live.staticflickr.com/211/489758881_8b09a801f2.jpg",
  "image_urls": [
   "https://live.staticflickr.com/211/489758881_8b09a801f2.jpg"
  ],
  "photo_credit": "avlxyz · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/10559879@N00/489758881"
 },
 {
  "name": "Ensaladilla rusa",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 4,
  "duration_min": 40,
  "ingredients": [
   {
    "name": "patata",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "huevo",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "atún en lata",
    "quantity": 160,
    "unit": "g"
   },
   {
    "name": "guisantes",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "aceitunas verdes",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "mayonesa",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Cuece las patatas y las zanahorias con piel en agua con sal hasta que estén tiernas, unos 25 minutos; añade los guisantes los últimos 5."
   },
   {
    "key": "s2",
    "text": "Cuece los huevos 10 minutos y enfríalos."
   },
   {
    "key": "s3",
    "text": "Pela patatas, zanahorias y huevos y córtalos en dados pequeños."
   },
   {
    "key": "s4",
    "text": "Mézclalo todo con el atún escurrido y la mayonesa, y decora con las aceitunas."
   },
   {
    "key": "s5",
    "text": "Déjala en la nevera al menos una hora antes de servir."
   }
  ],
  "description": "1. Cuece las patatas y las zanahorias con piel en agua con sal hasta que estén tiernas, unos 25 minutos; añade los guisantes los últimos 5.\n\n2. Cuece los huevos 10 minutos y enfríalos.\n\n3. Pela patatas, zanahorias y huevos y córtalos en dados pequeños.\n\n4. Mézclalo todo con el atún escurrido y la mayonesa, y decora con las aceitunas.\n\n5. Déjala en la nevera al menos una hora antes de servir.",
  "image_url": "https://live.staticflickr.com/8454/8071915181_edb7bd9b56.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8454/8071915181_edb7bd9b56.jpg"
  ],
  "photo_credit": "onnoth · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/50403002@N00/8071915181"
 },
 {
  "name": "Mejillones al vapor con limón",
  "tags": [
   "Cena",
   "Tapas"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "mejillón",
    "quantity": 1000,
    "unit": "g"
   },
   {
    "name": "vino blanco",
    "quantity": 80,
    "unit": "ml"
   },
   {
    "name": "laurel",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Limpia los mejillones quitándoles las barbas y desecha los que estén abiertos."
   },
   {
    "key": "s2",
    "text": "Ponlos en una olla con el vino y el laurel, tapa y cocina a fuego fuerte."
   },
   {
    "key": "s3",
    "text": "En 4 o 5 minutos se abrirán; retira los que sigan cerrados."
   },
   {
    "key": "s4",
    "text": "Sírvelos con gajos de limón."
   }
  ],
  "description": "1. Limpia los mejillones quitándoles las barbas y desecha los que estén abiertos.\n\n2. Ponlos en una olla con el vino y el laurel, tapa y cocina a fuego fuerte.\n\n3. En 4 o 5 minutos se abrirán; retira los que sigan cerrados.\n\n4. Sírvelos con gajos de limón.",
  "image_url": "https://live.staticflickr.com/3279/2720206237_c41976888d_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3279/2720206237_c41976888d_b.jpg"
  ],
  "photo_credit": "jlastras · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/22662305@N04/2720206237"
 },
 {
  "name": "Tortilla de espinacas",
  "tags": [
   "Cena",
   "Vegetariano"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "huevo",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "espinacas",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva",
    "quantity": 20,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Saltea las espinacas con el ajo picado y la mitad del aceite hasta que se reduzcan; escúrrelas."
   },
   {
    "key": "s2",
    "text": "Bate los huevos con sal y mézclalos con las espinacas."
   },
   {
    "key": "s3",
    "text": "Cuaja la tortilla en una sartén pequeña con el resto del aceite, dándole la vuelta con un plato."
   }
  ],
  "description": "1. Saltea las espinacas con el ajo picado y la mitad del aceite hasta que se reduzcan; escúrrelas.\n\n2. Bate los huevos con sal y mézclalos con las espinacas.\n\n3. Cuaja la tortilla en una sartén pequeña con el resto del aceite, dándole la vuelta con un plato.",
  "image_url": "https://live.staticflickr.com/3494/3278835124_a94aef3b98_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3494/3278835124_a94aef3b98_b.jpg"
  ],
  "photo_credit": "mdid · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/58246614@N00/3278835124"
 },
 {
  "name": "Gazpacho andaluz",
  "tags": [
   "Comida",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "tomate pera",
    "quantity": 8,
    "unit": "ud"
   },
   {
    "name": "pimiento verde",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pepino",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "pan",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 60,
    "unit": "ml"
   },
   {
    "name": "vinagre de jerez",
    "quantity": 20,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Trocea los tomates, el pimiento, el pepino pelado y el ajo."
   },
   {
    "key": "s2",
    "text": "Tritúralo todo con el pan, el vinagre y sal hasta que quede muy fino."
   },
   {
    "key": "s3",
    "text": "Añade el aceite poco a poco sin dejar de triturar para que emulsione."
   },
   {
    "key": "s4",
    "text": "Pásalo por un colador si lo quieres más fino y déjalo en la nevera hasta que esté bien frío."
   }
  ],
  "description": "1. Trocea los tomates, el pimiento, el pepino pelado y el ajo.\n\n2. Tritúralo todo con el pan, el vinagre y sal hasta que quede muy fino.\n\n3. Añade el aceite poco a poco sin dejar de triturar para que emulsione.\n\n4. Pásalo por un colador si lo quieres más fino y déjalo en la nevera hasta que esté bien frío.",
  "image_url": "https://live.staticflickr.com/4118/4812761687_7f7268fd76_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4118/4812761687_7f7268fd76_b.jpg"
  ],
  "photo_credit": "tomatoes and friends · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/49845772@N03/4812761687"
 },
 {
  "name": "Salmorejo cordobés",
  "tags": [
   "Comida",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "tomate pera",
    "quantity": 8,
    "unit": "ud"
   },
   {
    "name": "pan",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 100,
    "unit": "ml"
   },
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "jamón serrano",
    "quantity": 50,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Cuece los huevos 10 minutos y enfríalos."
   },
   {
    "key": "s2",
    "text": "Tritura los tomates con el ajo y sal; añade el pan troceado y deja que se empape 5 minutos."
   },
   {
    "key": "s3",
    "text": "Tritura de nuevo añadiendo el aceite en hilo hasta que quede una crema espesa."
   },
   {
    "key": "s4",
    "text": "Sírvelo frío con el huevo picado y el jamón en tiras por encima."
   }
  ],
  "description": "1. Cuece los huevos 10 minutos y enfríalos.\n\n2. Tritura los tomates con el ajo y sal; añade el pan troceado y deja que se empape 5 minutos.\n\n3. Tritura de nuevo añadiendo el aceite en hilo hasta que quede una crema espesa.\n\n4. Sírvelo frío con el huevo picado y el jamón en tiras por encima.",
  "image_url": "https://live.staticflickr.com/4017/4494091661_e6f7ff1081_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4017/4494091661_e6f7ff1081_b.jpg"
  ],
  "photo_credit": "jlastras · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/22662305@N04/4494091661"
 },
 {
  "name": "Ensalada mediterránea",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 2,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "lechuga romana",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "pepino",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "cebolla morada",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "queso feta",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "aceitunas negras",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "orégano",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Lava y trocea la lechuga."
   },
   {
    "key": "s2",
    "text": "Corta el tomate en gajos, el pepino en medias lunas y la cebolla en aros finos."
   },
   {
    "key": "s3",
    "text": "Reparte todo en una fuente con las aceitunas y el queso feta en dados."
   },
   {
    "key": "s4",
    "text": "Aliña con el aceite, sal y una pizca de orégano."
   }
  ],
  "description": "1. Lava y trocea la lechuga.\n\n2. Corta el tomate en gajos, el pepino en medias lunas y la cebolla en aros finos.\n\n3. Reparte todo en una fuente con las aceitunas y el queso feta en dados.\n\n4. Aliña con el aceite, sal y una pizca de orégano.",
  "image_url": "https://live.staticflickr.com/2685/5863586770_309bbfd5cb_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2685/5863586770_309bbfd5cb_b.jpg"
  ],
  "photo_credit": "ozmafan · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/35735307@N00/5863586770"
 },
 {
  "name": "Crema de calabaza",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 35,
  "ingredients": [
   {
    "name": "calabaza",
    "quantity": 800,
    "unit": "g"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "caldo de verduras",
    "quantity": 700,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 20,
    "unit": "ml"
   },
   {
    "name": "nuez moscada",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pocha la cebolla picada en el aceite 5 minutos."
   },
   {
    "key": "s2",
    "text": "Añade la calabaza y la zanahoria troceadas y rehoga 3 minutos."
   },
   {
    "key": "s3",
    "text": "Cubre con el caldo y cuece 20 minutos, hasta que todo esté tierno."
   },
   {
    "key": "s4",
    "text": "Tritura hasta que quede fina, ajusta de sal y añade una pizca de nuez moscada."
   }
  ],
  "description": "1. Pocha la cebolla picada en el aceite 5 minutos.\n\n2. Añade la calabaza y la zanahoria troceadas y rehoga 3 minutos.\n\n3. Cubre con el caldo y cuece 20 minutos, hasta que todo esté tierno.\n\n4. Tritura hasta que quede fina, ajusta de sal y añade una pizca de nuez moscada.",
  "image_url": "https://live.staticflickr.com/106/313561882_5830e604fe_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/106/313561882_5830e604fe_b.jpg"
  ],
  "photo_credit": "stu_spivack · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/35034346243@N01/313561882"
 },
 {
  "name": "Ensalada de quinoa con verduras",
  "tags": [
   "Comida",
   "Ligero"
  ],
  "servings_base": 2,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "quinoa",
    "quantity": 120,
    "unit": "g"
   },
   {
    "name": "tomate cherry",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "pepino",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aguacate",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 25,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Lava la quinoa y cuécela en el doble de agua con sal 12-15 minutos; escúrrela y deja que se enfríe."
   },
   {
    "key": "s2",
    "text": "Corta los tomates por la mitad y el pepino, el pimiento y el aguacate en dados."
   },
   {
    "key": "s3",
    "text": "Mezcla todo con la quinoa."
   },
   {
    "key": "s4",
    "text": "Aliña con el zumo del limón, el aceite y sal."
   }
  ],
  "description": "1. Lava la quinoa y cuécela en el doble de agua con sal 12-15 minutos; escúrrela y deja que se enfríe.\n\n2. Corta los tomates por la mitad y el pepino, el pimiento y el aguacate en dados.\n\n3. Mezcla todo con la quinoa.\n\n4. Aliña con el zumo del limón, el aceite y sal.",
  "image_url": "https://live.staticflickr.com/1272/901705743_ea93902785_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/1272/901705743_ea93902785_b.jpg"
  ],
  "photo_credit": "rusvaplauke · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/7440954@N05/901705743"
 },
 {
  "name": "Sopa de verduras",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 35,
  "ingredients": [
   {
    "name": "puerro",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "apio",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "calabacín",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "judía verde",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "caldo de verduras",
    "quantity": 1200,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 20,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Corta todas las verduras en trozos pequeños."
   },
   {
    "key": "s2",
    "text": "Rehoga el puerro en el aceite 5 minutos."
   },
   {
    "key": "s3",
    "text": "Añade el resto de verduras y el caldo, y cuece a fuego suave 20 minutos."
   },
   {
    "key": "s4",
    "text": "Ajusta de sal y sirve caliente."
   }
  ],
  "description": "1. Corta todas las verduras en trozos pequeños.\n\n2. Rehoga el puerro en el aceite 5 minutos.\n\n3. Añade el resto de verduras y el caldo, y cuece a fuego suave 20 minutos.\n\n4. Ajusta de sal y sirve caliente.",
  "image_url": "https://live.staticflickr.com/3192/2759721625_937b3a1ffa_m.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3192/2759721625_937b3a1ffa_m.jpg"
  ],
  "photo_credit": "startcooking kathy & amandine · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/70893713@N00/2759721625"
 },
 {
  "name": "Poke bowl de salmón",
  "tags": [
   "Comida",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "arroz para sushi",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "salmón",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "aguacate",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "edamame",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "pepino",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "salsa de soja",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "semillas de sésamo",
    "quantity": 10,
    "unit": "g"
   },
   {
    "name": "vinagre de arroz",
    "quantity": 15,
    "unit": "ml"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Cuece el arroz según el paquete, alíñalo con el vinagre y deja que se temple."
   },
   {
    "key": "s2",
    "text": "Corta el salmón (apto para comer crudo) en dados y mézclalo con la soja."
   },
   {
    "key": "s3",
    "text": "Corta el aguacate y el pepino en láminas."
   },
   {
    "key": "s4",
    "text": "Monta los boles con el arroz de base y encima el salmón, el aguacate, el pepino y el edamame."
   },
   {
    "key": "s5",
    "text": "Termina con sésamo por encima."
   }
  ],
  "description": "1. Cuece el arroz según el paquete, alíñalo con el vinagre y deja que se temple.\n\n2. Corta el salmón (apto para comer crudo) en dados y mézclalo con la soja.\n\n3. Corta el aguacate y el pepino en láminas.\n\n4. Monta los boles con el arroz de base y encima el salmón, el aguacate, el pepino y el edamame.\n\n5. Termina con sésamo por encima.",
  "image_url": "https://live.staticflickr.com/4094/5442182933_27e43612f2_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4094/5442182933_27e43612f2_b.jpg"
  ],
  "photo_credit": "photoskate · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/44447572@N06/5442182933"
 },
 {
  "name": "Bacalao al horno con pimientos",
  "tags": [
   "Cena",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "bacalao desalado",
    "quantity": 350,
    "unit": "g"
   },
   {
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento verde",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
    "unit": "ml"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 190 °C."
   },
   {
    "key": "s2",
    "text": "Corta los pimientos y la cebolla en tiras y ásalos 15 minutos en una bandeja con la mitad del aceite."
   },
   {
    "key": "s3",
    "text": "Coloca encima los lomos de bacalao y riega con el resto del aceite con el ajo laminado."
   },
   {
    "key": "s4",
    "text": "Hornea 10-12 minutos, hasta que el bacalao se separe en lascas."
   }
  ],
  "description": "1. Precalienta el horno a 190 °C.\n\n2. Corta los pimientos y la cebolla en tiras y ásalos 15 minutos en una bandeja con la mitad del aceite.\n\n3. Coloca encima los lomos de bacalao y riega con el resto del aceite con el ajo laminado.\n\n4. Hornea 10-12 minutos, hasta que el bacalao se separe en lascas.",
  "image_url": "https://live.staticflickr.com/2232/2262396498_7ac7ceb61c_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2232/2262396498_7ac7ceb61c_b.jpg"
  ],
  "photo_credit": "methTICALman · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/46614245@N00/2262396498"
 },
 {
  "name": "Lasaña de carne",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 6,
  "duration_min": 75,
  "ingredients": [
   {
    "name": "placas de lasaña",
    "quantity": 12,
    "unit": "ud"
   },
   {
    "name": "carne picada mixta",
    "quantity": 500,
    "unit": "g"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate triturado",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "bechamel",
    "quantity": 500,
    "unit": "ml"
   },
   {
    "name": "queso rallado",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "orégano",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pocha la cebolla y la zanahoria picadas en el aceite 8 minutos; añade la carne y dórala."
   },
   {
    "key": "s2",
    "text": "Echa el tomate y una pizca de orégano y cocina 15 minutos a fuego suave."
   },
   {
    "key": "s3",
    "text": "Cuece las placas según el paquete (o hidrátalas si son precocidas)."
   },
   {
    "key": "s4",
    "text": "En una fuente, alterna capas de placas, carne y un poco de bechamel; termina con bechamel y queso rallado."
   },
   {
    "key": "s5",
    "text": "Hornea a 200 °C unos 25 minutos, hasta que esté gratinada. Déjala reposar 10 minutos antes de cortar."
   }
  ],
  "description": "1. Pocha la cebolla y la zanahoria picadas en el aceite 8 minutos; añade la carne y dórala.\n\n2. Echa el tomate y una pizca de orégano y cocina 15 minutos a fuego suave.\n\n3. Cuece las placas según el paquete (o hidrátalas si son precocidas).\n\n4. En una fuente, alterna capas de placas, carne y un poco de bechamel; termina con bechamel y queso rallado.\n\n5. Hornea a 200 °C unos 25 minutos, hasta que esté gratinada. Déjala reposar 10 minutos antes de cortar.",
  "image_url": "https://live.staticflickr.com/3686/11735294004_b733d44485_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3686/11735294004_b733d44485_b.jpg"
  ],
  "photo_credit": "jamesonf · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/24314126@N05/11735294004"
 },
 {
  "name": "Pollo al ajillo",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 40,
  "ingredients": [
   {
    "name": "muslo de pollo",
    "quantity": 800,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 8,
    "unit": "diente"
   },
   {
    "name": "vino blanco",
    "quantity": 120,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 60,
    "unit": "ml"
   },
   {
    "name": "laurel",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "perejil fresco",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Trocea el pollo y sálalo."
   },
   {
    "key": "s2",
    "text": "Dóralo bien en el aceite por todos los lados, unos 10 minutos."
   },
   {
    "key": "s3",
    "text": "Añade los ajos enteros chafados y el laurel y rehoga 2 minutos."
   },
   {
    "key": "s4",
    "text": "Riega con el vino, tapa y cocina a fuego suave 20 minutos, removiendo de vez en cuando."
   },
   {
    "key": "s5",
    "text": "Termina con perejil picado."
   }
  ],
  "description": "1. Trocea el pollo y sálalo.\n\n2. Dóralo bien en el aceite por todos los lados, unos 10 minutos.\n\n3. Añade los ajos enteros chafados y el laurel y rehoga 2 minutos.\n\n4. Riega con el vino, tapa y cocina a fuego suave 20 minutos, removiendo de vez en cuando.\n\n5. Termina con perejil picado.",
  "image_url": "https://adgara01.github.io/NutriFit/img/catalogo/pollo-al-ajillo.svg",
  "image_urls": [
   "https://adgara01.github.io/NutriFit/img/catalogo/pollo-al-ajillo.svg"
  ],
  "photo_credit": "NutriFit · ilustración",
  "photo_source": null
 },
 {
  "name": "Arroz con verduras",
  "tags": [
   "Comida",
   "Vegetariano"
  ],
  "servings_base": 4,
  "duration_min": 40,
  "ingredients": [
   {
    "name": "arroz redondo",
    "quantity": 320,
    "unit": "g"
   },
   {
    "name": "calabacín",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "alcachofa",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "judía verde",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "tomate triturado",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "caldo de verduras",
    "quantity": 1000,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 50,
    "unit": "ml"
   },
   {
    "name": "azafrán",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Sofríe en el aceite la judía, el pimiento, el calabacín y las alcachofas troceadas, 8 minutos."
   },
   {
    "key": "s2",
    "text": "Añade el tomate y cocina 3 minutos más."
   },
   {
    "key": "s3",
    "text": "Echa el arroz, remueve un minuto y vierte el caldo caliente con el azafrán."
   },
   {
    "key": "s4",
    "text": "Cocina 18 minutos sin remover y deja reposar 5 minutos."
   }
  ],
  "description": "1. Sofríe en el aceite la judía, el pimiento, el calabacín y las alcachofas troceadas, 8 minutos.\n\n2. Añade el tomate y cocina 3 minutos más.\n\n3. Echa el arroz, remueve un minuto y vierte el caldo caliente con el azafrán.\n\n4. Cocina 18 minutos sin remover y deja reposar 5 minutos.",
  "image_url": "https://live.staticflickr.com/8309/8038343404_d8bec3af36.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8309/8038343404_d8bec3af36.jpg"
  ],
  "photo_credit": "taskforsome · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/34149453@N07/8038343404"
 },
 {
  "name": "Fajitas de pollo",
  "tags": [
   "Cena",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "pechuga de pollo",
    "quantity": 500,
    "unit": "g"
   },
   {
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento verde",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tortilla de trigo",
    "quantity": 8,
    "unit": "ud"
   },
   {
    "name": "comino",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "guacamole",
    "quantity": 150,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Corta el pollo, los pimientos y la cebolla en tiras."
   },
   {
    "key": "s2",
    "text": "Saltea el pollo a fuego fuerte con el aceite, una pizca de comino, pimentón y sal; resérvalo."
   },
   {
    "key": "s3",
    "text": "Saltea las verduras 5 minutos y vuelve a echar el pollo."
   },
   {
    "key": "s4",
    "text": "Calienta las tortillas y rellénalas con el pollo y las verduras. Sirve con guacamole."
   }
  ],
  "description": "1. Corta el pollo, los pimientos y la cebolla en tiras.\n\n2. Saltea el pollo a fuego fuerte con el aceite, una pizca de comino, pimentón y sal; resérvalo.\n\n3. Saltea las verduras 5 minutos y vuelve a echar el pollo.\n\n4. Calienta las tortillas y rellénalas con el pollo y las verduras. Sirve con guacamole.",
  "image_url": "https://live.staticflickr.com/4015/4589449172_eb046a7f2a_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4015/4589449172_eb046a7f2a_b.jpg"
  ],
  "photo_credit": "Denis Dervisevic · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/23979265@N07/4589449172"
 },
 {
  "name": "Bizcocho de yogur",
  "tags": [
   "Repostería"
  ],
  "servings_base": 8,
  "duration_min": 50,
  "ingredients": [
   {
    "name": "yogur natural",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "azúcar",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "aceite de girasol",
    "quantity": 100,
    "unit": "ml"
   },
   {
    "name": "harina",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "levadura química",
    "quantity": 16,
    "unit": "g"
   },
   {
    "name": "ralladura de limón",
    "quantity": 5,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 180 °C y engrasa un molde."
   },
   {
    "key": "s2",
    "text": "Bate los huevos con el azúcar hasta que blanqueen."
   },
   {
    "key": "s3",
    "text": "Añade el yogur, el aceite y la ralladura, y mezcla."
   },
   {
    "key": "s4",
    "text": "Incorpora la harina tamizada con la levadura con movimientos envolventes."
   },
   {
    "key": "s5",
    "text": "Vierte en el molde y hornea 35-40 minutos, hasta que al pinchar salga limpio."
   }
  ],
  "description": "1. Precalienta el horno a 180 °C y engrasa un molde.\n\n2. Bate los huevos con el azúcar hasta que blanqueen.\n\n3. Añade el yogur, el aceite y la ralladura, y mezcla.\n\n4. Incorpora la harina tamizada con la levadura con movimientos envolventes.\n\n5. Vierte en el molde y hornea 35-40 minutos, hasta que al pinchar salga limpio.",
  "image_url": "https://live.staticflickr.com/8244/8611545120_1175969db1_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8244/8611545120_1175969db1_b.jpg"
  ],
  "photo_credit": "grongar · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/70757891@N00/8611545120"
 },
 {
  "name": "Flan de huevo",
  "tags": [
   "Repostería"
  ],
  "servings_base": 6,
  "duration_min": 60,
  "ingredients": [
   {
    "name": "huevo",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "leche",
    "quantity": 500,
    "unit": "ml"
   },
   {
    "name": "azúcar",
    "quantity": 120,
    "unit": "g"
   },
   {
    "name": "caramelo líquido",
    "quantity": 60,
    "unit": "ml"
   },
   {
    "name": "vainilla",
    "quantity": 2,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 170 °C y cubre el fondo de las flaneras con caramelo."
   },
   {
    "key": "s2",
    "text": "Bate los huevos con el azúcar y la vainilla, sin hacer espuma, y añade la leche templada."
   },
   {
    "key": "s3",
    "text": "Reparte la mezcla en las flaneras."
   },
   {
    "key": "s4",
    "text": "Hornea al baño maría 40 minutos, hasta que cuaje."
   },
   {
    "key": "s5",
    "text": "Déjalo enfriar y guárdalo en la nevera al menos 3 horas antes de desmoldar."
   }
  ],
  "description": "1. Precalienta el horno a 170 °C y cubre el fondo de las flaneras con caramelo.\n\n2. Bate los huevos con el azúcar y la vainilla, sin hacer espuma, y añade la leche templada.\n\n3. Reparte la mezcla en las flaneras.\n\n4. Hornea al baño maría 40 minutos, hasta que cuaje.\n\n5. Déjalo enfriar y guárdalo en la nevera al menos 3 horas antes de desmoldar.",
  "image_url": "https://live.staticflickr.com/4149/4996853387_5d312db469_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4149/4996853387_5d312db469_b.jpg"
  ],
  "photo_credit": "Vegan Feast Catering · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/25128194@N02/4996853387"
 },
 {
  "name": "Tarta de queso al horno",
  "tags": [
   "Repostería"
  ],
  "servings_base": 8,
  "duration_min": 70,
  "ingredients": [
   {
    "name": "queso crema",
    "quantity": 600,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "azúcar",
    "quantity": 180,
    "unit": "g"
   },
   {
    "name": "nata para montar",
    "quantity": 300,
    "unit": "ml"
   },
   {
    "name": "harina",
    "quantity": 20,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 210 °C y forra un molde con papel de horno arrugado."
   },
   {
    "key": "s2",
    "text": "Bate el queso con el azúcar hasta que quede cremoso."
   },
   {
    "key": "s3",
    "text": "Añade los huevos de uno en uno, luego la nata y la harina tamizada."
   },
   {
    "key": "s4",
    "text": "Vierte en el molde y hornea 40-45 minutos: la superficie debe quedar muy dorada y el centro temblón."
   },
   {
    "key": "s5",
    "text": "Déjala enfriar del todo y luego en la nevera unas horas."
   }
  ],
  "description": "1. Precalienta el horno a 210 °C y forra un molde con papel de horno arrugado.\n\n2. Bate el queso con el azúcar hasta que quede cremoso.\n\n3. Añade los huevos de uno en uno, luego la nata y la harina tamizada.\n\n4. Vierte en el molde y hornea 40-45 minutos: la superficie debe quedar muy dorada y el centro temblón.\n\n5. Déjala enfriar del todo y luego en la nevera unas horas.",
  "image_url": "https://live.staticflickr.com/203/513092634_4eeecc0097.jpg",
  "image_urls": [
   "https://live.staticflickr.com/203/513092634_4eeecc0097.jpg"
  ],
  "photo_credit": "c.j.b · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/62961837@N00/513092634"
 },
 {
  "name": "Torrijas",
  "tags": [
   "Repostería"
  ],
  "servings_base": 4,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "barra de pan",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "leche",
    "quantity": 500,
    "unit": "ml"
   },
   {
    "name": "azúcar",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "canela en rama",
    "quantity": 1,
    "unit": "rama"
   },
   {
    "name": "ralladura de limón",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "aceite de girasol",
    "quantity": 300,
    "unit": "ml"
   },
   {
    "name": "canela",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Calienta la leche con la canela en rama, la ralladura y la mitad del azúcar; deja que se temple."
   },
   {
    "key": "s2",
    "text": "Corta el pan del día anterior en rebanadas de dos dedos y empápalas en la leche."
   },
   {
    "key": "s3",
    "text": "Pásalas por huevo batido y fríelas en aceite caliente hasta que se doren por los dos lados."
   },
   {
    "key": "s4",
    "text": "Escúrrelas y rebózalas en el resto del azúcar mezclado con canela."
   }
  ],
  "description": "1. Calienta la leche con la canela en rama, la ralladura y la mitad del azúcar; deja que se temple.\n\n2. Corta el pan del día anterior en rebanadas de dos dedos y empápalas en la leche.\n\n3. Pásalas por huevo batido y fríelas en aceite caliente hasta que se doren por los dos lados.\n\n4. Escúrrelas y rebózalas en el resto del azúcar mezclado con canela.",
  "image_url": "https://live.staticflickr.com/2246/2327540982_cb08da9bf7_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2246/2327540982_cb08da9bf7_b.jpg"
  ],
  "photo_credit": "tnarik · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/80075387@N00/2327540982"
 },
 {
  "name": "Natillas caseras",
  "tags": [
   "Repostería"
  ],
  "servings_base": 4,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "leche",
    "quantity": 750,
    "unit": "ml"
   },
   {
    "name": "yema de huevo",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "azúcar",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "maicena",
    "quantity": 20,
    "unit": "g"
   },
   {
    "name": "canela en rama",
    "quantity": 1,
    "unit": "rama"
   },
   {
    "name": "galletas maría",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "canela",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Calienta la leche con la canela en rama, reservando un vaso."
   },
   {
    "key": "s2",
    "text": "Mezcla en el vaso de leche fría las yemas, el azúcar y la maicena."
   },
   {
    "key": "s3",
    "text": "Retira la canela, añade la mezcla a la leche caliente y cocina a fuego suave sin dejar de remover hasta que espese, sin que hierva."
   },
   {
    "key": "s4",
    "text": "Reparte en cuencos con una galleta encima y canela en polvo. Enfría en la nevera."
   }
  ],
  "description": "1. Calienta la leche con la canela en rama, reservando un vaso.\n\n2. Mezcla en el vaso de leche fría las yemas, el azúcar y la maicena.\n\n3. Retira la canela, añade la mezcla a la leche caliente y cocina a fuego suave sin dejar de remover hasta que espese, sin que hierva.\n\n4. Reparte en cuencos con una galleta encima y canela en polvo. Enfría en la nevera.",
  "image_url": "https://live.staticflickr.com/3304/3583013233_bde547835e_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3304/3583013233_bde547835e_b.jpg"
  ],
  "photo_credit": "Danny / ixfd64 · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/64978778@N00/3583013233"
 },
 {
  "name": "Brownie de chocolate",
  "tags": [
   "Repostería"
  ],
  "servings_base": 9,
  "duration_min": 40,
  "ingredients": [
   {
    "name": "chocolate negro",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "mantequilla",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "azúcar",
    "quantity": 180,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "harina",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "nueces",
    "quantity": 80,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 180 °C y forra un molde cuadrado con papel."
   },
   {
    "key": "s2",
    "text": "Funde el chocolate con la mantequilla al baño maría o en el microondas a golpes cortos."
   },
   {
    "key": "s3",
    "text": "Bate los huevos con el azúcar, añade el chocolate fundido y luego la harina."
   },
   {
    "key": "s4",
    "text": "Incorpora las nueces troceadas y vierte en el molde."
   },
   {
    "key": "s5",
    "text": "Hornea 20-25 minutos: el centro debe quedar algo húmedo. Deja enfriar antes de cortar."
   }
  ],
  "description": "1. Precalienta el horno a 180 °C y forra un molde cuadrado con papel.\n\n2. Funde el chocolate con la mantequilla al baño maría o en el microondas a golpes cortos.\n\n3. Bate los huevos con el azúcar, añade el chocolate fundido y luego la harina.\n\n4. Incorpora las nueces troceadas y vierte en el molde.\n\n5. Hornea 20-25 minutos: el centro debe quedar algo húmedo. Deja enfriar antes de cortar.",
  "image_url": "https://live.staticflickr.com/3262/2760563950_845fa0cfe6_m.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3262/2760563950_845fa0cfe6_m.jpg"
  ],
  "photo_credit": "startcooking kathy & amandine · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/70893713@N00/2760563950"
 }
]$json$::jsonb) loop
    d := jsonb_populate_record(null::public.dishes, r);
    insert into public.dishes (id, user_id, name, tags, servings_base, duration_min, ingredients, steps,
                               description, image_url, image_urls, photo_credit, photo_source)
    values (md5('nutrifit:' || (r->>'name'))::uuid, uid, d.name, d.tags, d.servings_base, d.duration_min,
            d.ingredients, d.steps, d.description, d.image_url, d.image_urls, d.photo_credit, d.photo_source)
    on conflict (id) do update set
      name = excluded.name, tags = excluded.tags, servings_base = excluded.servings_base,
      duration_min = excluded.duration_min, ingredients = excluded.ingredients, steps = excluded.steps,
      description = excluded.description, image_url = excluded.image_url, image_urls = excluded.image_urls,
      photo_credit = excluded.photo_credit, photo_source = excluded.photo_source;
  end loop;
end $$;

select count(*) as recetas_del_catalogo from public.dishes
 where user_id = (select id from public.profiles where lower(username) = 'nutrifit' limit 1);
