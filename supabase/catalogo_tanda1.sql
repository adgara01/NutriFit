-- ============================================================
-- NUTRIFIT — Catálogo de recetas (30 recetas, tanda1.json)
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
  "name": "Tostadas con tomate y aceite",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 2,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "pan",
    "quantity": 160,
    "unit": "g"
   },
   {
    "name": "tomate",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "aceite de oliva virgen extra",
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
    "text": "Tuesta el pan hasta que esté crujiente por fuera."
   },
   {
    "key": "s2",
    "text": "Si te gusta, frota el diente de ajo pelado sobre el pan caliente."
   },
   {
    "key": "s3",
    "text": "Ralla los tomates por la parte gruesa del rallador, dejando la piel fuera."
   },
   {
    "key": "s4",
    "text": "Reparte el tomate por encima, añade un hilo de aceite y una pizca de sal, y sirve al momento."
   }
  ],
  "description": "1. Tuesta el pan hasta que esté crujiente por fuera.\n\n2. Si te gusta, frota el diente de ajo pelado sobre el pan caliente.\n\n3. Ralla los tomates por la parte gruesa del rallador, dejando la piel fuera.\n\n4. Reparte el tomate por encima, añade un hilo de aceite y una pizca de sal, y sirve al momento.",
  "image_url": "https://live.staticflickr.com/5208/5345371327_71f3ea9dd5.jpg",
  "image_urls": [
   "https://live.staticflickr.com/5208/5345371327_71f3ea9dd5.jpg"
  ],
  "photo_credit": "Oh-Barcelona.com · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/33831399@N04/5345371327"
 },
 {
  "name": "Porridge de avena con plátano y canela",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "copos de avena",
    "quantity": 50,
    "unit": "g"
   },
   {
    "name": "leche",
    "quantity": 250,
    "unit": "ml"
   },
   {
    "name": "plátano",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "canela",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "miel",
    "quantity": 10,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pon la avena y la leche en un cazo a fuego medio."
   },
   {
    "key": "s2",
    "text": "Remueve de vez en cuando durante 5 o 6 minutos, hasta que espese y quede cremosa."
   },
   {
    "key": "s3",
    "text": "Aplasta la mitad del plátano con un tenedor e incorpóralo al final para endulzar."
   },
   {
    "key": "s4",
    "text": "Sirve en un bol con el resto del plátano en rodajas, canela espolvoreada y un poco de miel."
   }
  ],
  "description": "1. Pon la avena y la leche en un cazo a fuego medio.\n\n2. Remueve de vez en cuando durante 5 o 6 minutos, hasta que espese y quede cremosa.\n\n3. Aplasta la mitad del plátano con un tenedor e incorpóralo al final para endulzar.\n\n4. Sirve en un bol con el resto del plátano en rodajas, canela espolvoreada y un poco de miel.",
  "image_url": "https://live.staticflickr.com/8525/8673215959_aedcf110a2_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8525/8673215959_aedcf110a2_b.jpg"
  ],
  "photo_credit": "opacity · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/60258967@N00/8673215959"
 },
 {
  "name": "Yogur griego con granola y frutos rojos",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 5,
  "ingredients": [
   {
    "name": "yogur griego",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "granola",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "frutos rojos congelados",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "miel",
    "quantity": 10,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Si los frutos rojos están congelados, déjalos fuera unos minutos o caliéntalos 30 segundos en el microondas."
   },
   {
    "key": "s2",
    "text": "Pon el yogur en un bol o un vaso ancho."
   },
   {
    "key": "s3",
    "text": "Cubre con la granola y los frutos rojos, y termina con un hilo de miel."
   }
  ],
  "description": "1. Si los frutos rojos están congelados, déjalos fuera unos minutos o caliéntalos 30 segundos en el microondas.\n\n2. Pon el yogur en un bol o un vaso ancho.\n\n3. Cubre con la granola y los frutos rojos, y termina con un hilo de miel.",
  "image_url": "https://live.staticflickr.com/3217/2704159113_8a10bf5756_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3217/2704159113_8a10bf5756_b.jpg"
  ],
  "photo_credit": "dailyfood · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/28970677@N04/2704159113"
 },
 {
  "name": "Huevos revueltos con espinacas",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "espinacas",
    "quantity": 60,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 10,
    "unit": "ml"
   },
   {
    "name": "pan integral",
    "quantity": 60,
    "unit": "g"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Saltea las espinacas en una sartén con el aceite hasta que se reduzcan, unos 2 minutos."
   },
   {
    "key": "s2",
    "text": "Bate los huevos con sal y pimienta."
   },
   {
    "key": "s3",
    "text": "Baja el fuego, añade los huevos y remueve despacio con una espátula hasta que cuajen pero sigan jugosos."
   },
   {
    "key": "s4",
    "text": "Sirve enseguida con el pan tostado."
   }
  ],
  "description": "1. Saltea las espinacas en una sartén con el aceite hasta que se reduzcan, unos 2 minutos.\n\n2. Bate los huevos con sal y pimienta.\n\n3. Baja el fuego, añade los huevos y remueve despacio con una espátula hasta que cuajen pero sigan jugosos.\n\n4. Sirve enseguida con el pan tostado.",
  "image_url": "https://live.staticflickr.com/8465/8121597563_c5752dbd2d_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8465/8121597563_c5752dbd2d_b.jpg"
  ],
  "photo_credit": "ultrakml · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/34948727@N00/8121597563"
 },
 {
  "name": "Tostada de aguacate y huevo",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 10,
  "ingredients": [
   {
    "name": "pan integral",
    "quantity": 60,
    "unit": "g"
   },
   {
    "name": "aguacate",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "huevo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Cuece el huevo 7 minutos en agua hirviendo para que la yema quede melosa, y enfríalo en agua fría."
   },
   {
    "key": "s2",
    "text": "Tuesta el pan."
   },
   {
    "key": "s3",
    "text": "Machaca el aguacate con unas gotas de limón, sal y pimienta."
   },
   {
    "key": "s4",
    "text": "Unta el aguacate en la tostada y pon encima el huevo pelado y abierto por la mitad."
   }
  ],
  "description": "1. Cuece el huevo 7 minutos en agua hirviendo para que la yema quede melosa, y enfríalo en agua fría.\n\n2. Tuesta el pan.\n\n3. Machaca el aguacate con unas gotas de limón, sal y pimienta.\n\n4. Unta el aguacate en la tostada y pon encima el huevo pelado y abierto por la mitad.",
  "image_url": "https://live.staticflickr.com/4294/35555668790_ca5fb33447.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4294/35555668790_ca5fb33447.jpg"
  ],
  "photo_credit": "megh28 · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/156883244@N04/35555668790"
 },
 {
  "name": "Tortitas de avena y plátano",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 2,
  "duration_min": 20,
  "ingredients": [
   {
    "name": "plátano",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "copos de avena",
    "quantity": 80,
    "unit": "g"
   },
   {
    "name": "canela",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "aceite de oliva",
    "quantity": 5,
    "unit": "ml"
   },
   {
    "name": "miel",
    "quantity": 15,
    "unit": "g"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Tritura los plátanos, los huevos, la avena y una pizca de canela hasta tener una masa espesa."
   },
   {
    "key": "s2",
    "text": "Calienta una sartén antiadherente a fuego medio y úntala con unas gotas de aceite."
   },
   {
    "key": "s3",
    "text": "Echa una cucharada grande de masa por tortita y cocina hasta que salgan burbujas en la superficie, unos 2 minutos."
   },
   {
    "key": "s4",
    "text": "Dales la vuelta, cocina un minuto más y sirve con miel o fruta."
   }
  ],
  "description": "1. Tritura los plátanos, los huevos, la avena y una pizca de canela hasta tener una masa espesa.\n\n2. Calienta una sartén antiadherente a fuego medio y úntala con unas gotas de aceite.\n\n3. Echa una cucharada grande de masa por tortita y cocina hasta que salgan burbujas en la superficie, unos 2 minutos.\n\n4. Dales la vuelta, cocina un minuto más y sirve con miel o fruta.",
  "image_url": "https://live.staticflickr.com/2670/3848803773_604c3c7218_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2670/3848803773_604c3c7218_b.jpg"
  ],
  "photo_credit": "jonolist · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/46635911@N00/3848803773"
 },
 {
  "name": "Bocadillo de jamón con tomate",
  "tags": [
   "Desayuno",
   "Carne"
  ],
  "servings_base": 1,
  "duration_min": 5,
  "ingredients": [
   {
    "name": "barra de pan",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "jamón serrano",
    "quantity": 50,
    "unit": "g"
   },
   {
    "name": "aceite de oliva virgen extra",
    "quantity": 10,
    "unit": "ml"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Abre el pan por la mitad; si quieres, tuéstalo un minuto."
   },
   {
    "key": "s2",
    "text": "Ralla el tomate y repártelo por la miga."
   },
   {
    "key": "s3",
    "text": "Añade un hilo de aceite y las lonchas de jamón, cierra y listo."
   }
  ],
  "description": "1. Abre el pan por la mitad; si quieres, tuéstalo un minuto.\n\n2. Ralla el tomate y repártelo por la miga.\n\n3. Añade un hilo de aceite y las lonchas de jamón, cierra y listo.",
  "image_url": "https://live.staticflickr.com/6065/6060474539_39476fbbf0_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/6065/6060474539_39476fbbf0_b.jpg"
  ],
  "photo_credit": "travelwayoflife · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/61664791@N05/6060474539"
 },
 {
  "name": "Batido de plátano y crema de cacahuete",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 5,
  "ingredients": [
   {
    "name": "plátano",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "bebida de avena",
    "quantity": 250,
    "unit": "ml"
   },
   {
    "name": "mantequilla de cacahuete",
    "quantity": 20,
    "unit": "g"
   },
   {
    "name": "copos de avena",
    "quantity": 20,
    "unit": "g"
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
    "text": "Pon todos los ingredientes en el vaso de la batidora."
   },
   {
    "key": "s2",
    "text": "Tritura hasta que quede liso; si lo quieres más frío, añade un par de cubitos de hielo."
   },
   {
    "key": "s3",
    "text": "Sirve enseguida."
   }
  ],
  "description": "1. Pon todos los ingredientes en el vaso de la batidora.\n\n2. Tritura hasta que quede liso; si lo quieres más frío, añade un par de cubitos de hielo.\n\n3. Sirve enseguida.",
  "image_url": "https://live.staticflickr.com/8039/29252705940_623246769d_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8039/29252705940_623246769d_b.jpg"
  ],
  "photo_credit": "RunningStats · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/143500187@N08/29252705940"
 },
 {
  "name": "Tortilla francesa con queso",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 8,
  "ingredients": [
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "queso rallado",
    "quantity": 30,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 5,
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
    "text": "Bate los huevos con una pizca de sal."
   },
   {
    "key": "s2",
    "text": "Calienta el aceite en una sartén pequeña a fuego medio y vierte el huevo."
   },
   {
    "key": "s3",
    "text": "Cuando empiece a cuajar por abajo, reparte el queso en el centro."
   },
   {
    "key": "s4",
    "text": "Dobla la tortilla en tres, deja un minuto más para que se funda el queso y sirve."
   }
  ],
  "description": "1. Bate los huevos con una pizca de sal.\n\n2. Calienta el aceite en una sartén pequeña a fuego medio y vierte el huevo.\n\n3. Cuando empiece a cuajar por abajo, reparte el queso en el centro.\n\n4. Dobla la tortilla en tres, deja un minuto más para que se funda el queso y sirve.",
  "image_url": "https://live.staticflickr.com/3512/3227896436_42aa88cfdf_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3512/3227896436_42aa88cfdf_b.jpg"
  ],
  "photo_credit": "Kent Wang · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/27454212@N00/3227896436"
 },
 {
  "name": "Pudin de chía con mango",
  "tags": [
   "Desayuno",
   "Vegetariano"
  ],
  "servings_base": 1,
  "duration_min": 5,
  "ingredients": [
   {
    "name": "semillas de chía",
    "quantity": 30,
    "unit": "g"
   },
   {
    "name": "bebida de avena",
    "quantity": 200,
    "unit": "ml"
   },
   {
    "name": "mango",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "sirope de agave",
    "quantity": 10,
    "unit": "ml"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Mezcla la chía con la bebida de avena y el sirope en un tarro, y remueve bien para que no se formen grumos."
   },
   {
    "key": "s2",
    "text": "Vuelve a remover a los 10 minutos y guárdalo en la nevera al menos 4 horas, o toda la noche."
   },
   {
    "key": "s3",
    "text": "Antes de comer, cubre con el mango en dados."
   }
  ],
  "description": "1. Mezcla la chía con la bebida de avena y el sirope en un tarro, y remueve bien para que no se formen grumos.\n\n2. Vuelve a remover a los 10 minutos y guárdalo en la nevera al menos 4 horas, o toda la noche.\n\n3. Antes de comer, cubre con el mango en dados.",
  "image_url": "https://live.staticflickr.com/1685/25322778832_9179ed638d_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/1685/25322778832_9179ed638d_b.jpg"
  ],
  "photo_credit": "guillemcat · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/96056991@N08/25322778832"
 },
 {
  "name": "Lentejas estofadas con verduras",
  "tags": [
   "Comida",
   "Vegetariano"
  ],
  "servings_base": 4,
  "duration_min": 50,
  "ingredients": [
   {
    "name": "lenteja",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "patata",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento verde",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "tomate triturado",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "laurel",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
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
    "text": "Lava las lentejas en un colador con agua fría. Las pardinas no necesitan remojo."
   },
   {
    "key": "s2",
    "text": "Pica la cebolla, el pimiento y el ajo bien pequeños y póchalos en una olla con el aceite a fuego medio unos 8 minutos."
   },
   {
    "key": "s3",
    "text": "Añade el tomate triturado y deja que se haga 5 minutos, removiendo de vez en cuando."
   },
   {
    "key": "s4",
    "text": "Aparta la olla del fuego, echa una cucharadita de pimentón, remueve rápido para que no se queme y vuelve al fuego."
   },
   {
    "key": "s5",
    "text": "Incorpora las lentejas, la zanahoria en rodajas, el laurel y agua fría hasta cubrir dos dedos por encima."
   },
   {
    "key": "s6",
    "text": "Cuando hierva, baja el fuego y deja 20 minutos. Añade la patata en trozos medianos, cascándolos con el cuchillo para que suelten almidón."
   },
   {
    "key": "s7",
    "text": "Cocina 20 minutos más, hasta que lentejas y patata estén tiernas. Prueba de sal y deja reposar 5 minutos antes de servir."
   }
  ],
  "description": "1. Lava las lentejas en un colador con agua fría. Las pardinas no necesitan remojo.\n\n2. Pica la cebolla, el pimiento y el ajo bien pequeños y póchalos en una olla con el aceite a fuego medio unos 8 minutos.\n\n3. Añade el tomate triturado y deja que se haga 5 minutos, removiendo de vez en cuando.\n\n4. Aparta la olla del fuego, echa una cucharadita de pimentón, remueve rápido para que no se queme y vuelve al fuego.\n\n5. Incorpora las lentejas, la zanahoria en rodajas, el laurel y agua fría hasta cubrir dos dedos por encima.\n\n6. Cuando hierva, baja el fuego y deja 20 minutos. Añade la patata en trozos medianos, cascándolos con el cuchillo para que suelten almidón.\n\n7. Cocina 20 minutos más, hasta que lentejas y patata estén tiernas. Prueba de sal y deja reposar 5 minutos antes de servir.",
  "image_url": "https://live.staticflickr.com/4129/5094766956_0549d662c2.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4129/5094766956_0549d662c2.jpg"
  ],
  "photo_credit": "Lablascovegmenu · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/35022955@N06/5094766956"
 },
 {
  "name": "Pollo al curry con arroz",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 35,
  "ingredients": [
   {
    "name": "contramuslo de pollo",
    "quantity": 600,
    "unit": "g"
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
    "name": "jengibre",
    "quantity": 10,
    "unit": "g"
   },
   {
    "name": "curry",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "tomate triturado",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "leche de coco",
    "quantity": 400,
    "unit": "ml"
   },
   {
    "name": "arroz basmati",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
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
    "text": "Corta el pollo en dados y sálalo ligeramente."
   },
   {
    "key": "s2",
    "text": "Sofríe la cebolla picada en el aceite 6 minutos; añade el ajo y el jengibre rallados y cocina uno más."
   },
   {
    "key": "s3",
    "text": "Incorpora dos cucharadas de curry y remueve 30 segundos para que suelte el aroma."
   },
   {
    "key": "s4",
    "text": "Añade el pollo y marca 4 o 5 minutos hasta que pierda el color crudo."
   },
   {
    "key": "s5",
    "text": "Echa el tomate y la leche de coco, baja el fuego y deja 15 minutos, hasta que la salsa espese."
   },
   {
    "key": "s6",
    "text": "Mientras, cuece el arroz en agua con sal según el paquete y escúrrelo."
   },
   {
    "key": "s7",
    "text": "Sirve el pollo con su salsa junto al arroz."
   }
  ],
  "description": "1. Corta el pollo en dados y sálalo ligeramente.\n\n2. Sofríe la cebolla picada en el aceite 6 minutos; añade el ajo y el jengibre rallados y cocina uno más.\n\n3. Incorpora dos cucharadas de curry y remueve 30 segundos para que suelte el aroma.\n\n4. Añade el pollo y marca 4 o 5 minutos hasta que pierda el color crudo.\n\n5. Echa el tomate y la leche de coco, baja el fuego y deja 15 minutos, hasta que la salsa espese.\n\n6. Mientras, cuece el arroz en agua con sal según el paquete y escúrrelo.\n\n7. Sirve el pollo con su salsa junto al arroz.",
  "image_url": "https://live.staticflickr.com/1421/1453447361_03b08ebc5c_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/1421/1453447361_03b08ebc5c_b.jpg"
  ],
  "photo_credit": "rovingI · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/70522326@N00/1453447361"
 },
 {
  "name": "Garbanzos con espinacas",
  "tags": [
   "Comida",
   "Vegetariano"
  ],
  "servings_base": 4,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "garbanzos cocidos",
    "quantity": 800,
    "unit": "g"
   },
   {
    "name": "espinacas",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 3,
    "unit": "diente"
   },
   {
    "name": "pan",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "comino",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "vinagre de jerez",
    "quantity": 10,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 50,
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
    "text": "Enjuaga los garbanzos y escúrrelos."
   },
   {
    "key": "s2",
    "text": "Fríe en el aceite los ajos laminados y el pan en trozos hasta que se doren; sácalos y macháchalos en un mortero con el vinagre."
   },
   {
    "key": "s3",
    "text": "En el mismo aceite saltea las espinacas hasta que se reduzcan."
   },
   {
    "key": "s4",
    "text": "Añade una cucharadita de pimentón y otra de comino, remueve y echa enseguida los garbanzos y un vaso de agua."
   },
   {
    "key": "s5",
    "text": "Incorpora el majado, cocina 10 minutos a fuego suave y prueba de sal."
   }
  ],
  "description": "1. Enjuaga los garbanzos y escúrrelos.\n\n2. Fríe en el aceite los ajos laminados y el pan en trozos hasta que se doren; sácalos y macháchalos en un mortero con el vinagre.\n\n3. En el mismo aceite saltea las espinacas hasta que se reduzcan.\n\n4. Añade una cucharadita de pimentón y otra de comino, remueve y echa enseguida los garbanzos y un vaso de agua.\n\n5. Incorpora el majado, cocina 10 minutos a fuego suave y prueba de sal.",
  "image_url": "https://live.staticflickr.com/7068/6891484449_4e91987db2.jpg",
  "image_urls": [
   "https://live.staticflickr.com/7068/6891484449_4e91987db2.jpg"
  ],
  "photo_credit": "onnoth · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/50403002@N00/6891484449"
 },
 {
  "name": "Paella de pollo y verduras",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 50,
  "ingredients": [
   {
    "name": "muslo de pollo",
    "quantity": 500,
    "unit": "g"
   },
   {
    "name": "arroz bomba",
    "quantity": 320,
    "unit": "g"
   },
   {
    "name": "judía verde",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate triturado",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "azafrán",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "caldo de pollo",
    "quantity": 1000,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 50,
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
    "text": "Sala el pollo troceado y dóralo bien en la paellera con el aceite, unos 10 minutos."
   },
   {
    "key": "s2",
    "text": "Añade las judías y el pimiento en tiras y rehoga 5 minutos."
   },
   {
    "key": "s3",
    "text": "Haz un hueco en el centro, sofríe el ajo picado, luego el tomate, y cocina hasta que pierda el agua."
   },
   {
    "key": "s4",
    "text": "Echa una cucharadita de pimentón, remueve y vierte el caldo caliente con el azafrán. Prueba de sal."
   },
   {
    "key": "s5",
    "text": "Cuando hierva, reparte el arroz en forma de cruz y extiéndelo. A partir de aquí no se remueve."
   },
   {
    "key": "s6",
    "text": "Cocina 10 minutos a fuego fuerte y 8 más a fuego suave."
   },
   {
    "key": "s7",
    "text": "Deja reposar 5 minutos tapada con un paño antes de servir."
   }
  ],
  "description": "1. Sala el pollo troceado y dóralo bien en la paellera con el aceite, unos 10 minutos.\n\n2. Añade las judías y el pimiento en tiras y rehoga 5 minutos.\n\n3. Haz un hueco en el centro, sofríe el ajo picado, luego el tomate, y cocina hasta que pierda el agua.\n\n4. Echa una cucharadita de pimentón, remueve y vierte el caldo caliente con el azafrán. Prueba de sal.\n\n5. Cuando hierva, reparte el arroz en forma de cruz y extiéndelo. A partir de aquí no se remueve.\n\n6. Cocina 10 minutos a fuego fuerte y 8 más a fuego suave.\n\n7. Deja reposar 5 minutos tapada con un paño antes de servir.",
  "image_url": "https://live.staticflickr.com/8208/8197006381_472eeab3e7_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8208/8197006381_472eeab3e7_b.jpg"
  ],
  "photo_credit": "Gabriel GM · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/25382620@N03/8197006381"
 },
 {
  "name": "Macarrones con tomate y chorizo",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "macarrones",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "chorizo",
    "quantity": 120,
    "unit": "g"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate frito",
    "quantity": 400,
    "unit": "ml"
   },
   {
    "name": "queso rallado",
    "quantity": 60,
    "unit": "g"
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
    "text": "Cuece los macarrones en agua con sal el tiempo del paquete y escúrrelos."
   },
   {
    "key": "s2",
    "text": "Mientras, sofríe la cebolla picada en el aceite 6 minutos."
   },
   {
    "key": "s3",
    "text": "Añade el chorizo en daditos y cocina 3 minutos para que suelte su grasa."
   },
   {
    "key": "s4",
    "text": "Incorpora el tomate frito, deja 5 minutos y mezcla con la pasta."
   },
   {
    "key": "s5",
    "text": "Sirve con queso rallado por encima o gratina unos minutos en el horno."
   }
  ],
  "description": "1. Cuece los macarrones en agua con sal el tiempo del paquete y escúrrelos.\n\n2. Mientras, sofríe la cebolla picada en el aceite 6 minutos.\n\n3. Añade el chorizo en daditos y cocina 3 minutos para que suelte su grasa.\n\n4. Incorpora el tomate frito, deja 5 minutos y mezcla con la pasta.\n\n5. Sirve con queso rallado por encima o gratina unos minutos en el horno.",
  "image_url": "https://live.staticflickr.com/1347/3166048564_34ff27fa60_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/1347/3166048564_34ff27fa60_b.jpg"
  ],
  "photo_credit": "Craig Anderson · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/24236874@N00/3166048564"
 },
 {
  "name": "Albóndigas en salsa de tomate",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 45,
  "ingredients": [
   {
    "name": "carne picada mixta",
    "quantity": 500,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pan rallado",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "perejil fresco",
    "quantity": 10,
    "unit": "g"
   },
   {
    "name": "harina",
    "quantity": 30,
    "unit": "g"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate triturado",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "vino blanco",
    "quantity": 100,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 60,
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
    "text": "Mezcla la carne con el huevo, el pan rallado, un ajo picado, el perejil y sal."
   },
   {
    "key": "s2",
    "text": "Forma bolas del tamaño de una nuez y pásalas por harina."
   },
   {
    "key": "s3",
    "text": "Dóralas en el aceite por tandas y resérvalas."
   },
   {
    "key": "s4",
    "text": "En el mismo aceite pocha la cebolla y el otro ajo picados, 8 minutos."
   },
   {
    "key": "s5",
    "text": "Añade el vino, deja que se evapore y echa el tomate. Cocina 10 minutos."
   },
   {
    "key": "s6",
    "text": "Vuelve a meter las albóndigas y deja 10 minutos más a fuego suave."
   }
  ],
  "description": "1. Mezcla la carne con el huevo, el pan rallado, un ajo picado, el perejil y sal.\n\n2. Forma bolas del tamaño de una nuez y pásalas por harina.\n\n3. Dóralas en el aceite por tandas y resérvalas.\n\n4. En el mismo aceite pocha la cebolla y el otro ajo picados, 8 minutos.\n\n5. Añade el vino, deja que se evapore y echa el tomate. Cocina 10 minutos.\n\n6. Vuelve a meter las albóndigas y deja 10 minutos más a fuego suave.",
  "image_url": "https://live.staticflickr.com/2663/3716096437_fae41665b5_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2663/3716096437_fae41665b5_b.jpg"
  ],
  "photo_credit": "avlxyz · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/10559879@N00/3716096437"
 },
 {
  "name": "Tofu salteado con brócoli y arroz",
  "tags": [
   "Comida",
   "Vegetariano"
  ],
  "servings_base": 2,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "tofu",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "brócoli",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "zanahoria",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 1,
    "unit": "diente"
   },
   {
    "name": "jengibre",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "salsa de soja",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "arroz basmati",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 20,
    "unit": "ml"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Cuece el arroz según el paquete."
   },
   {
    "key": "s2",
    "text": "Seca bien el tofu con papel de cocina, córtalo en dados y dóralo en una sartén con la mitad del aceite. Resérvalo."
   },
   {
    "key": "s3",
    "text": "Saltea a fuego fuerte el brócoli en ramitos y la zanahoria en tiras con el resto del aceite, 5 minutos."
   },
   {
    "key": "s4",
    "text": "Añade el ajo y el jengibre rallados, vuelve a echar el tofu y riega con la soja."
   },
   {
    "key": "s5",
    "text": "Remueve un minuto y sirve sobre el arroz."
   }
  ],
  "description": "1. Cuece el arroz según el paquete.\n\n2. Seca bien el tofu con papel de cocina, córtalo en dados y dóralo en una sartén con la mitad del aceite. Resérvalo.\n\n3. Saltea a fuego fuerte el brócoli en ramitos y la zanahoria en tiras con el resto del aceite, 5 minutos.\n\n4. Añade el ajo y el jengibre rallados, vuelve a echar el tofu y riega con la soja.\n\n5. Remueve un minuto y sirve sobre el arroz.",
  "image_url": "https://live.staticflickr.com/3673/19760470714_3a76755a78_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3673/19760470714_3a76755a78_b.jpg"
  ],
  "photo_credit": "goblinbox_(queen_of_ad_hoc_bento) · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/25977089@N00/19760470714"
 },
 {
  "name": "Alubias blancas con verduras",
  "tags": [
   "Comida",
   "Vegetariano"
  ],
  "servings_base": 4,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "alubias cocidas",
    "quantity": 800,
    "unit": "g"
   },
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
    "name": "pimiento rojo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "pimentón dulce",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "caldo de verduras",
    "quantity": 500,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
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
    "text": "Enjuaga las alubias y escúrrelas."
   },
   {
    "key": "s2",
    "text": "Pocha el puerro, la zanahoria, el pimiento y el ajo, todo picado, en el aceite durante 10 minutos."
   },
   {
    "key": "s3",
    "text": "Añade una cucharadita de pimentón, remueve y vierte el caldo."
   },
   {
    "key": "s4",
    "text": "Incorpora las alubias y cocina 10 minutos a fuego suave."
   },
   {
    "key": "s5",
    "text": "Aplasta unas cuantas alubias contra la cazuela para que espese el caldo y prueba de sal."
   }
  ],
  "description": "1. Enjuaga las alubias y escúrrelas.\n\n2. Pocha el puerro, la zanahoria, el pimiento y el ajo, todo picado, en el aceite durante 10 minutos.\n\n3. Añade una cucharadita de pimentón, remueve y vierte el caldo.\n\n4. Incorpora las alubias y cocina 10 minutos a fuego suave.\n\n5. Aplasta unas cuantas alubias contra la cazuela para que espese el caldo y prueba de sal.",
  "image_url": "https://live.staticflickr.com/1593/25990272306_7736c06d9d.jpg",
  "image_urls": [
   "https://live.staticflickr.com/1593/25990272306_7736c06d9d.jpg"
  ],
  "photo_credit": "orionpozo · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/65168863@N00/25990272306"
 },
 {
  "name": "Solomillo de cerdo al horno con patatas",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 50,
  "ingredients": [
   {
    "name": "solomillo de cerdo",
    "quantity": 600,
    "unit": "g"
   },
   {
    "name": "patata",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 3,
    "unit": "diente"
   },
   {
    "name": "vino blanco",
    "quantity": 100,
    "unit": "ml"
   },
   {
    "name": "romero",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 200 °C."
   },
   {
    "key": "s2",
    "text": "Corta las patatas en rodajas finas y la cebolla en tiras; colócalas en una bandeja con sal, la mitad del aceite y los ajos aplastados. Hornea 20 minutos."
   },
   {
    "key": "s3",
    "text": "Salpimienta el solomillo, frótalo con romero y márcalo en una sartén caliente con el resto del aceite."
   },
   {
    "key": "s4",
    "text": "Ponlo sobre las patatas, riega con el vino y hornea 15 o 18 minutos."
   },
   {
    "key": "s5",
    "text": "Déjalo reposar 5 minutos antes de cortarlo en medallones."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C.\n\n2. Corta las patatas en rodajas finas y la cebolla en tiras; colócalas en una bandeja con sal, la mitad del aceite y los ajos aplastados. Hornea 20 minutos.\n\n3. Salpimienta el solomillo, frótalo con romero y márcalo en una sartén caliente con el resto del aceite.\n\n4. Ponlo sobre las patatas, riega con el vino y hornea 15 o 18 minutos.\n\n5. Déjalo reposar 5 minutos antes de cortarlo en medallones.",
  "image_url": "https://live.staticflickr.com/2487/4229627664_2da7541669_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2487/4229627664_2da7541669_b.jpg"
  ],
  "photo_credit": "@joefoodie · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/98178986@N00/4229627664"
 },
 {
  "name": "Espaguetis a la boloñesa",
  "tags": [
   "Comida",
   "Carne"
  ],
  "servings_base": 4,
  "duration_min": 40,
  "ingredients": [
   {
    "name": "espagueti",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "carne picada mixta",
    "quantity": 400,
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
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "tomate triturado",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "vino tinto",
    "quantity": 100,
    "unit": "ml"
   },
   {
    "name": "orégano",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "parmesano",
    "quantity": 40,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
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
    "text": "Pica muy fino la cebolla, la zanahoria y el ajo, y póchalos en el aceite 10 minutos."
   },
   {
    "key": "s2",
    "text": "Sube el fuego, añade la carne y deshazla con una cuchara hasta que se dore."
   },
   {
    "key": "s3",
    "text": "Echa el vino y deja que se evapore."
   },
   {
    "key": "s4",
    "text": "Incorpora el tomate, el orégano y sal, y cocina tapado a fuego suave 20 minutos."
   },
   {
    "key": "s5",
    "text": "Cuece la pasta, escúrrela y mézclala con la salsa. Sirve con parmesano."
   }
  ],
  "description": "1. Pica muy fino la cebolla, la zanahoria y el ajo, y póchalos en el aceite 10 minutos.\n\n2. Sube el fuego, añade la carne y deshazla con una cuchara hasta que se dore.\n\n3. Echa el vino y deja que se evapore.\n\n4. Incorpora el tomate, el orégano y sal, y cocina tapado a fuego suave 20 minutos.\n\n5. Cuece la pasta, escúrrela y mézclala con la salsa. Sirve con parmesano.",
  "image_url": "https://live.staticflickr.com/3737/11267498676_b8fc88abed_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3737/11267498676_b8fc88abed_b.jpg"
  ],
  "photo_credit": "matsuyuki · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/12173213@N00/11267498676"
 },
 {
  "name": "Tortilla de patatas con cebolla",
  "tags": [
   "Cena",
   "Vegetariano"
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
    "name": "huevo",
    "quantity": 6,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 250,
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
    "text": "Pela las patatas y córtalas en láminas finas. Pica la cebolla en tiras."
   },
   {
    "key": "s2",
    "text": "Calienta el aceite a fuego medio y confita patata y cebolla con un poco de sal unos 20 minutos, hasta que estén blandas pero sin dorarse mucho."
   },
   {
    "key": "s3",
    "text": "Escúrrelas bien y guarda el aceite para otras veces."
   },
   {
    "key": "s4",
    "text": "Bate los huevos con una pizca de sal, mezcla con la patata y deja que repose 5 minutos."
   },
   {
    "key": "s5",
    "text": "En una sartén con una cucharada de aceite a fuego medio-alto, vierte la mezcla y cuaja 2 o 3 minutos moviendo la sartén."
   },
   {
    "key": "s6",
    "text": "Dale la vuelta con un plato y cuaja 1 o 2 minutos más, según la quieras de jugosa."
   }
  ],
  "description": "1. Pela las patatas y córtalas en láminas finas. Pica la cebolla en tiras.\n\n2. Calienta el aceite a fuego medio y confita patata y cebolla con un poco de sal unos 20 minutos, hasta que estén blandas pero sin dorarse mucho.\n\n3. Escúrrelas bien y guarda el aceite para otras veces.\n\n4. Bate los huevos con una pizca de sal, mezcla con la patata y deja que repose 5 minutos.\n\n5. En una sartén con una cucharada de aceite a fuego medio-alto, vierte la mezcla y cuaja 2 o 3 minutos moviendo la sartén.\n\n6. Dale la vuelta con un plato y cuaja 1 o 2 minutos más, según la quieras de jugosa.",
  "image_url": "https://live.staticflickr.com/4057/4502306959_ca8f57aac4_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4057/4502306959_ca8f57aac4_b.jpg"
  ],
  "photo_credit": "Lablascovegmenu · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/35022955@N06/4502306959"
 },
 {
  "name": "Merluza en salsa verde con guisantes",
  "tags": [
   "Cena",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 25,
  "ingredients": [
   {
    "name": "merluza",
    "quantity": 400,
    "unit": "g"
   },
   {
    "name": "guisantes",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "ajo",
    "quantity": 3,
    "unit": "diente"
   },
   {
    "name": "perejil fresco",
    "quantity": 15,
    "unit": "g"
   },
   {
    "name": "harina",
    "quantity": 10,
    "unit": "g"
   },
   {
    "name": "caldo de pescado",
    "quantity": 250,
    "unit": "ml"
   },
   {
    "name": "vino blanco",
    "quantity": 50,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
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
    "text": "Sala la merluza en trozos o lomos y resérvala."
   },
   {
    "key": "s2",
    "text": "En una cazuela baja, dora a fuego suave el ajo laminado en el aceite sin que llegue a tostarse."
   },
   {
    "key": "s3",
    "text": "Añade la harina, remueve un minuto y echa el vino. Deja que se evapore el alcohol."
   },
   {
    "key": "s4",
    "text": "Vierte el caldo poco a poco sin dejar de mover hasta tener una salsa ligera."
   },
   {
    "key": "s5",
    "text": "Agrega los guisantes y la mitad del perejil picado, y cocina 3 minutos."
   },
   {
    "key": "s6",
    "text": "Coloca la merluza con la piel hacia arriba y cocina 4 o 5 minutos meneando la cazuela para que la salsa ligue."
   },
   {
    "key": "s7",
    "text": "Termina con el resto del perejil y sirve en cuanto el pescado esté hecho por dentro."
   }
  ],
  "description": "1. Sala la merluza en trozos o lomos y resérvala.\n\n2. En una cazuela baja, dora a fuego suave el ajo laminado en el aceite sin que llegue a tostarse.\n\n3. Añade la harina, remueve un minuto y echa el vino. Deja que se evapore el alcohol.\n\n4. Vierte el caldo poco a poco sin dejar de mover hasta tener una salsa ligera.\n\n5. Agrega los guisantes y la mitad del perejil picado, y cocina 3 minutos.\n\n6. Coloca la merluza con la piel hacia arriba y cocina 4 o 5 minutos meneando la cazuela para que la salsa ligue.\n\n7. Termina con el resto del perejil y sirve en cuanto el pescado esté hecho por dentro.",
  "image_url": "https://live.staticflickr.com/3247/2418743663_d825d95c9b_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3247/2418743663_d825d95c9b_b.jpg"
  ],
  "photo_credit": "jlastras · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/22662305@N04/2418743663"
 },
 {
  "name": "Salmón al horno con verduras",
  "tags": [
   "Cena",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "salmón",
    "quantity": 350,
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
    "name": "cebolla morada",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 200 °C."
   },
   {
    "key": "s2",
    "text": "Corta las verduras en trozos parecidos, mézclalas con la mitad del aceite y sal, y hornéalas 15 minutos."
   },
   {
    "key": "s3",
    "text": "Salpimienta el salmón, ponlo sobre las verduras con unas rodajas de limón y riega con el resto del aceite."
   },
   {
    "key": "s4",
    "text": "Hornea 10 o 12 minutos más, hasta que el salmón se separe en láminas."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C.\n\n2. Corta las verduras en trozos parecidos, mézclalas con la mitad del aceite y sal, y hornéalas 15 minutos.\n\n3. Salpimienta el salmón, ponlo sobre las verduras con unas rodajas de limón y riega con el resto del aceite.\n\n4. Hornea 10 o 12 minutos más, hasta que el salmón se separe en láminas.",
  "image_url": "https://live.staticflickr.com/7744/17230996270_347065f1fa_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/7744/17230996270_347065f1fa_b.jpg"
  ],
  "photo_credit": "jules:stonesoup · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/58367355@N00/17230996270"
 },
 {
  "name": "Crema de calabacín",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "calabacín",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "patata",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "puerro",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "caldo de verduras",
    "quantity": 600,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
    "unit": "ml"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   }
  ],
  "steps": [
   {
    "key": "s1",
    "text": "Pocha el puerro en rodajas en el aceite 5 minutos."
   },
   {
    "key": "s2",
    "text": "Añade el calabacín en trozos (con piel) y la patata pelada y troceada, y rehoga 3 minutos."
   },
   {
    "key": "s3",
    "text": "Cubre con el caldo, sala y cuece 15 minutos."
   },
   {
    "key": "s4",
    "text": "Tritura hasta que quede muy fina, ajusta de sal y pimienta y sirve caliente."
   }
  ],
  "description": "1. Pocha el puerro en rodajas en el aceite 5 minutos.\n\n2. Añade el calabacín en trozos (con piel) y la patata pelada y troceada, y rehoga 3 minutos.\n\n3. Cubre con el caldo, sala y cuece 15 minutos.\n\n4. Tritura hasta que quede muy fina, ajusta de sal y pimienta y sirve caliente.",
  "image_url": "https://live.staticflickr.com/5133/5571107308_53788f38fd_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/5133/5571107308_53788f38fd_b.jpg"
  ],
  "photo_credit": "Lablascovegmenu · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/35022955@N06/5571107308"
 },
 {
  "name": "Ensalada de garbanzos",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "garbanzos cocidos",
    "quantity": 400,
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
    "name": "cebolla morada",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pimiento verde",
    "quantity": 1,
    "unit": "ud"
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
    "name": "vinagre de jerez",
    "quantity": 15,
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
    "text": "Enjuaga los garbanzos y escúrrelos bien."
   },
   {
    "key": "s2",
    "text": "Corta los tomates por la mitad y el pepino, la cebolla y el pimiento en daditos."
   },
   {
    "key": "s3",
    "text": "Mezcla todo con las aceitunas en un bol."
   },
   {
    "key": "s4",
    "text": "Aliña con aceite, vinagre y sal, y deja reposar 10 minutos en la nevera antes de servir."
   }
  ],
  "description": "1. Enjuaga los garbanzos y escúrrelos bien.\n\n2. Corta los tomates por la mitad y el pepino, la cebolla y el pimiento en daditos.\n\n3. Mezcla todo con las aceitunas en un bol.\n\n4. Aliña con aceite, vinagre y sal, y deja reposar 10 minutos en la nevera antes de servir.",
  "image_url": "https://live.staticflickr.com/4113/4985882841_3bb689104b_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/4113/4985882841_3bb689104b_b.jpg"
  ],
  "photo_credit": "avlxyz · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/10559879@N00/4985882841"
 },
 {
  "name": "Pechuga de pollo a la plancha con ensalada",
  "tags": [
   "Cena",
   "Carne"
  ],
  "servings_base": 2,
  "duration_min": 20,
  "ingredients": [
   {
    "name": "pechuga de pollo",
    "quantity": 350,
    "unit": "g"
   },
   {
    "name": "lechuga",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "tomate",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "zanahoria",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
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
    "text": "Abre las pechugas en filetes finos y aliña con sal, orégano, unas gotas de limón y un poco de aceite."
   },
   {
    "key": "s2",
    "text": "Cocínalas en una plancha bien caliente 3 minutos por cada lado."
   },
   {
    "key": "s3",
    "text": "Mientras, prepara la ensalada con la lechuga, el tomate en gajos y la zanahoria rallada."
   },
   {
    "key": "s4",
    "text": "Aliña la ensalada y sirve junto al pollo cortado en tiras."
   }
  ],
  "description": "1. Abre las pechugas en filetes finos y aliña con sal, orégano, unas gotas de limón y un poco de aceite.\n\n2. Cocínalas en una plancha bien caliente 3 minutos por cada lado.\n\n3. Mientras, prepara la ensalada con la lechuga, el tomate en gajos y la zanahoria rallada.\n\n4. Aliña la ensalada y sirve junto al pollo cortado en tiras.",
  "image_url": "https://live.staticflickr.com/2358/2258912267_0a977ec3cc_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/2358/2258912267_0a977ec3cc_b.jpg"
  ],
  "photo_credit": "Marco Cabazal · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/11845118@N00/2258912267"
 },
 {
  "name": "Revuelto de setas y gambas",
  "tags": [
   "Cena",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 15,
  "ingredients": [
   {
    "name": "setas variadas",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "gamba",
    "quantity": 150,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 4,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "perejil fresco",
    "quantity": 5,
    "unit": "g"
   },
   {
    "name": "aceite de oliva",
    "quantity": 30,
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
    "text": "Limpia las setas y córtalas en trozos."
   },
   {
    "key": "s2",
    "text": "Dora el ajo laminado en el aceite, añade las setas y saltéalas a fuego fuerte 5 minutos."
   },
   {
    "key": "s3",
    "text": "Incorpora las gambas peladas y cocina un minuto, hasta que cambien de color."
   },
   {
    "key": "s4",
    "text": "Baja el fuego, echa los huevos batidos con sal y remueve suavemente hasta que cuajen jugosos. Termina con perejil."
   }
  ],
  "description": "1. Limpia las setas y córtalas en trozos.\n\n2. Dora el ajo laminado en el aceite, añade las setas y saltéalas a fuego fuerte 5 minutos.\n\n3. Incorpora las gambas peladas y cocina un minuto, hasta que cambien de color.\n\n4. Baja el fuego, echa los huevos batidos con sal y remueve suavemente hasta que cuajen jugosos. Termina con perejil.",
  "image_url": "https://adgara01.github.io/NutriFit/img/catalogo/revuelto-setas-gambas.svg",
  "image_urls": [
   "https://adgara01.github.io/NutriFit/img/catalogo/revuelto-setas-gambas.svg"
  ],
  "photo_credit": "NutriFit · ilustración",
  "photo_source": null
 },
 {
  "name": "Sopa de pollo con fideos",
  "tags": [
   "Cena",
   "Ligero"
  ],
  "servings_base": 4,
  "duration_min": 30,
  "ingredients": [
   {
    "name": "pechuga de pollo",
    "quantity": 250,
    "unit": "g"
   },
   {
    "name": "zanahoria",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "puerro",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "caldo de pollo",
    "quantity": 1500,
    "unit": "ml"
   },
   {
    "name": "fideos",
    "quantity": 120,
    "unit": "g"
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
    "text": "Pon el caldo a calentar con la zanahoria en rodajas y el puerro picado."
   },
   {
    "key": "s2",
    "text": "Cuando hierva, añade la pechuga entera y cuécela 12 minutos."
   },
   {
    "key": "s3",
    "text": "Saca el pollo, desmígalo con dos tenedores y devuélvelo a la olla."
   },
   {
    "key": "s4",
    "text": "Echa los fideos y cocina el tiempo del paquete. Prueba de sal y sirve con perejil picado."
   }
  ],
  "description": "1. Pon el caldo a calentar con la zanahoria en rodajas y el puerro picado.\n\n2. Cuando hierva, añade la pechuga entera y cuécela 12 minutos.\n\n3. Saca el pollo, desmígalo con dos tenedores y devuélvelo a la olla.\n\n4. Echa los fideos y cocina el tiempo del paquete. Prueba de sal y sirve con perejil picado.",
  "image_url": "https://live.staticflickr.com/3162/3079682439_351f008b11_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3162/3079682439_351f008b11_b.jpg"
  ],
  "photo_credit": "bobjudge · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/8286199@N08/3079682439"
 },
 {
  "name": "Pisto con huevo",
  "tags": [
   "Cena",
   "Vegetariano"
  ],
  "servings_base": 2,
  "duration_min": 40,
  "ingredients": [
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
    "name": "tomate triturado",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "huevo",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "aceite de oliva",
    "quantity": 40,
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
    "text": "Pica la cebolla y los pimientos y póchalos en el aceite a fuego medio 10 minutos."
   },
   {
    "key": "s2",
    "text": "Añade el calabacín en daditos y cocina 10 minutos más."
   },
   {
    "key": "s3",
    "text": "Incorpora el tomate y sal, y deja a fuego suave 15 minutos, removiendo de vez en cuando."
   },
   {
    "key": "s4",
    "text": "Haz dos huecos en el pisto, casca los huevos dentro, tapa y deja hasta que la clara cuaje."
   }
  ],
  "description": "1. Pica la cebolla y los pimientos y póchalos en el aceite a fuego medio 10 minutos.\n\n2. Añade el calabacín en daditos y cocina 10 minutos más.\n\n3. Incorpora el tomate y sal, y deja a fuego suave 15 minutos, removiendo de vez en cuando.\n\n4. Haz dos huecos en el pisto, casca los huevos dentro, tapa y deja hasta que la clara cuaje.",
  "image_url": "https://live.staticflickr.com/3232/4558942769_b00f02ebb6.jpg",
  "image_urls": [
   "https://live.staticflickr.com/3232/4558942769_b00f02ebb6.jpg"
  ],
  "photo_credit": "jasonlam · CC BY-SA 2.0",
  "photo_source": "https://www.flickr.com/photos/93512023@N00/4558942769"
 },
 {
  "name": "Dorada al horno con patatas",
  "tags": [
   "Cena",
   "Pescado"
  ],
  "servings_base": 2,
  "duration_min": 45,
  "ingredients": [
   {
    "name": "dorada",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "patata",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "cebolla",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "limón",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "ajo",
    "quantity": 2,
    "unit": "diente"
   },
   {
    "name": "vino blanco",
    "quantity": 80,
    "unit": "ml"
   },
   {
    "name": "aceite de oliva",
    "quantity": 50,
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
    "text": "Precalienta el horno a 200 °C."
   },
   {
    "key": "s2",
    "text": "Coloca las patatas en rodajas y la cebolla en tiras en una bandeja con sal y la mitad del aceite, y hornea 20 minutos."
   },
   {
    "key": "s3",
    "text": "Haz dos cortes en el lomo de cada dorada, sálalas y pon dentro unas rodajas de limón."
   },
   {
    "key": "s4",
    "text": "Colócalas sobre las patatas, riega con el vino y el resto del aceite con el ajo picado, y hornea 15 o 18 minutos."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C.\n\n2. Coloca las patatas en rodajas y la cebolla en tiras en una bandeja con sal y la mitad del aceite, y hornea 20 minutos.\n\n3. Haz dos cortes en el lomo de cada dorada, sálalas y pon dentro unas rodajas de limón.\n\n4. Colócalas sobre las patatas, riega con el vino y el resto del aceite con el ajo picado, y hornea 15 o 18 minutos.",
  "image_url": "https://live.staticflickr.com/8038/7991609406_0f1511e838_b.jpg",
  "image_urls": [
   "https://live.staticflickr.com/8038/7991609406_0f1511e838_b.jpg"
  ],
  "photo_credit": "AndyRobertsPhotos · CC BY 2.0",
  "photo_source": "https://www.flickr.com/photos/21372046@N00/7991609406"
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
