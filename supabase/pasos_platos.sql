-- ============================================================
-- NUTRIFIT — Pasos para los platos que no tenían (14 platos) y borrar platos de prueba
-- Solo rellena platos que siguen sin pasos ni descripción (no pisa nada que alguien haya escrito).
-- Borra: fkfk (platos de prueba).
-- Pégalo entero en Supabase → SQL Editor → Run. Se puede repetir sin problema.
-- ============================================================
do $$
declare r jsonb; d public.dishes; n int := 0;
begin
  for r in select * from jsonb_array_elements($json$[
 {
  "id": "eb1abd45-338e-45c9-94e2-ffa58c220d4b",
  "steps": [
   {
    "key": "s1",
    "text": "Pon el yogur griego en un bol y alísalo con una cuchara."
   },
   {
    "key": "s2",
    "text": "Pela el kiwi y córtalo en dados; corta el plátano en rodajas."
   },
   {
    "key": "s3",
    "text": "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente."
   },
   {
    "key": "s4",
    "text": "Termina con un hilo de miel al gusto."
   }
  ],
  "description": "1. Pon el yogur griego en un bol y alísalo con una cuchara.\n\n2. Pela el kiwi y córtalo en dados; corta el plátano en rodajas.\n\n3. Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.\n\n4. Termina con un hilo de miel al gusto."
 },
 {
  "id": "d0067788-352d-4c3b-a7e6-f9a3e288401f",
  "steps": [
   {
    "key": "s1",
    "text": "Pon el yogur griego en un bol y alísalo con una cuchara."
   },
   {
    "key": "s2",
    "text": "Pela el kiwi y córtalo en dados; corta el plátano en rodajas."
   },
   {
    "key": "s3",
    "text": "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente."
   },
   {
    "key": "s4",
    "text": "Termina con un hilo de miel al gusto."
   }
  ],
  "description": "1. Pon el yogur griego en un bol y alísalo con una cuchara.\n\n2. Pela el kiwi y córtalo en dados; corta el plátano en rodajas.\n\n3. Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.\n\n4. Termina con un hilo de miel al gusto."
 },
 {
  "id": "c0cf381b-735a-4d89-9dd4-b95ddd6f001a",
  "steps": [
   {
    "key": "s1",
    "text": "Pon el yogur griego en un bol y alísalo con una cuchara."
   },
   {
    "key": "s2",
    "text": "Pela el kiwi y córtalo en dados; corta el plátano en rodajas."
   },
   {
    "key": "s3",
    "text": "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente."
   },
   {
    "key": "s4",
    "text": "Termina con un hilo de miel al gusto."
   }
  ],
  "description": "1. Pon el yogur griego en un bol y alísalo con una cuchara.\n\n2. Pela el kiwi y córtalo en dados; corta el plátano en rodajas.\n\n3. Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.\n\n4. Termina con un hilo de miel al gusto."
 },
 {
  "id": "3d7de619-fe79-4eda-ab8c-7882b31b6b3a",
  "steps": [
   {
    "key": "s1",
    "text": "Pon el yogur griego en un bol y alísalo con una cuchara."
   },
   {
    "key": "s2",
    "text": "Pela el kiwi y córtalo en dados; corta el plátano en rodajas."
   },
   {
    "key": "s3",
    "text": "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente."
   },
   {
    "key": "s4",
    "text": "Termina con un hilo de miel al gusto."
   }
  ],
  "description": "1. Pon el yogur griego en un bol y alísalo con una cuchara.\n\n2. Pela el kiwi y córtalo en dados; corta el plátano en rodajas.\n\n3. Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.\n\n4. Termina con un hilo de miel al gusto."
 },
 {
  "id": "25d07240-4bc6-41a9-8099-17f520944ebe",
  "steps": [
   {
    "key": "s1",
    "text": "Pon el yogur griego en un bol y alísalo con una cuchara."
   },
   {
    "key": "s2",
    "text": "Pela el kiwi y córtalo en dados; corta el plátano en rodajas."
   },
   {
    "key": "s3",
    "text": "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente."
   },
   {
    "key": "s4",
    "text": "Termina con un hilo de miel al gusto."
   }
  ],
  "description": "1. Pon el yogur griego en un bol y alísalo con una cuchara.\n\n2. Pela el kiwi y córtalo en dados; corta el plátano en rodajas.\n\n3. Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.\n\n4. Termina con un hilo de miel al gusto."
 },
 {
  "id": "a870c955-3904-425f-97df-7a0a6638efa2",
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 200 °C y asa las patatas enteras, pinchadas con un tenedor, unos 45-50 minutos, hasta que estén tiernas."
   },
   {
    "key": "s2",
    "text": "Vacía la pulpa de las patatas y cháfala con un poco de mantequilla, un chorrito de leche caliente, sal y pimienta hasta tener un puré suave."
   },
   {
    "key": "s3",
    "text": "Haz cortes en rombo en la grasa del magret sin llegar a la carne y salpimiéntalo."
   },
   {
    "key": "s4",
    "text": "Ponlo con la piel hacia abajo en una sartén fría y enciende a fuego medio; deja que la grasa se funda 8-10 minutos, retirando la que sobre."
   },
   {
    "key": "s5",
    "text": "Dale la vuelta y cocina 3-4 minutos más para que quede rosado. Déjalo reposar 5 minutos antes de cortarlo en láminas."
   },
   {
    "key": "s6",
    "text": "En un poco de la grasa del pato, saltea las setas shiitake laminadas a fuego fuerte 3-4 minutos con una pizca de sal."
   },
   {
    "key": "s7",
    "text": "Sirve el magret en láminas con el puré y las setas."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C y asa las patatas enteras, pinchadas con un tenedor, unos 45-50 minutos, hasta que estén tiernas.\n\n2. Vacía la pulpa de las patatas y cháfala con un poco de mantequilla, un chorrito de leche caliente, sal y pimienta hasta tener un puré suave.\n\n3. Haz cortes en rombo en la grasa del magret sin llegar a la carne y salpimiéntalo.\n\n4. Ponlo con la piel hacia abajo en una sartén fría y enciende a fuego medio; deja que la grasa se funda 8-10 minutos, retirando la que sobre.\n\n5. Dale la vuelta y cocina 3-4 minutos más para que quede rosado. Déjalo reposar 5 minutos antes de cortarlo en láminas.\n\n6. En un poco de la grasa del pato, saltea las setas shiitake laminadas a fuego fuerte 3-4 minutos con una pizca de sal.\n\n7. Sirve el magret en láminas con el puré y las setas."
 },
 {
  "id": "cf76176e-7bce-4f19-9f85-4b30110f876c",
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 200 °C y asa las patatas enteras, pinchadas con un tenedor, unos 45-50 minutos, hasta que estén tiernas."
   },
   {
    "key": "s2",
    "text": "Vacía la pulpa de las patatas y cháfala con un poco de mantequilla, un chorrito de leche caliente, sal y pimienta hasta tener un puré suave."
   },
   {
    "key": "s3",
    "text": "Haz cortes en rombo en la grasa del magret sin llegar a la carne y salpimiéntalo."
   },
   {
    "key": "s4",
    "text": "Ponlo con la piel hacia abajo en una sartén fría y enciende a fuego medio; deja que la grasa se funda 8-10 minutos, retirando la que sobre."
   },
   {
    "key": "s5",
    "text": "Dale la vuelta y cocina 3-4 minutos más para que quede rosado. Déjalo reposar 5 minutos antes de cortarlo en láminas."
   },
   {
    "key": "s6",
    "text": "En un poco de la grasa del pato, saltea las setas shiitake laminadas a fuego fuerte 3-4 minutos con una pizca de sal."
   },
   {
    "key": "s7",
    "text": "Sirve el magret en láminas con el puré y las setas."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C y asa las patatas enteras, pinchadas con un tenedor, unos 45-50 minutos, hasta que estén tiernas.\n\n2. Vacía la pulpa de las patatas y cháfala con un poco de mantequilla, un chorrito de leche caliente, sal y pimienta hasta tener un puré suave.\n\n3. Haz cortes en rombo en la grasa del magret sin llegar a la carne y salpimiéntalo.\n\n4. Ponlo con la piel hacia abajo en una sartén fría y enciende a fuego medio; deja que la grasa se funda 8-10 minutos, retirando la que sobre.\n\n5. Dale la vuelta y cocina 3-4 minutos más para que quede rosado. Déjalo reposar 5 minutos antes de cortarlo en láminas.\n\n6. En un poco de la grasa del pato, saltea las setas shiitake laminadas a fuego fuerte 3-4 minutos con una pizca de sal.\n\n7. Sirve el magret en láminas con el puré y las setas."
 },
 {
  "id": "db3991ec-24e0-40af-8cd4-22fe97886f30",
  "steps": [
   {
    "key": "s1",
    "text": "Corta los tomates en gajos o en rodajas gruesas y colócalos en un plato con una pizca de sal."
   },
   {
    "key": "s2",
    "text": "Pon la burrata en el centro y ábrela justo antes de servir."
   },
   {
    "key": "s3",
    "text": "Pica los pistachos por encima y aliña con un buen chorro de aceite de oliva virgen extra y pimienta negra."
   }
  ],
  "description": "1. Corta los tomates en gajos o en rodajas gruesas y colócalos en un plato con una pizca de sal.\n\n2. Pon la burrata en el centro y ábrela justo antes de servir.\n\n3. Pica los pistachos por encima y aliña con un buen chorro de aceite de oliva virgen extra y pimienta negra."
 },
 {
  "id": "06682bcc-2f0d-48f8-a15a-afbe72652428",
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno con el grill a 220 °C."
   },
   {
    "key": "s2",
    "text": "Corta el guanciale o el jamón en tiras finas."
   },
   {
    "key": "s3",
    "text": "Coloca las zamburiñas en su concha sobre una bandeja y reparte el guanciale o el jamón por encima."
   },
   {
    "key": "s4",
    "text": "Gratina 4-5 minutos, hasta que la grasa se funda y las zamburiñas estén justo hechas. Sírvelas al momento."
   }
  ],
  "description": "1. Precalienta el horno con el grill a 220 °C.\n\n2. Corta el guanciale o el jamón en tiras finas.\n\n3. Coloca las zamburiñas en su concha sobre una bandeja y reparte el guanciale o el jamón por encima.\n\n4. Gratina 4-5 minutos, hasta que la grasa se funda y las zamburiñas estén justo hechas. Sírvelas al momento."
 },
 {
  "id": "4a9d6513-ba8e-42fd-83cd-6dfcc7462ee4",
  "steps": [
   {
    "key": "s1",
    "text": "Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que esté crujiente; apaga el fuego."
   },
   {
    "key": "s2",
    "text": "Bate los 4 huevos con el parmesano rallado y bastante pimienta negra hasta tener una crema espesa."
   },
   {
    "key": "s3",
    "text": "Cuece los spaghetti en agua con sal y guarda un vaso del agua de cocción antes de escurrirlos."
   },
   {
    "key": "s4",
    "text": "Echa la pasta en la sartén del guanciale, fuera del fuego, y añade la crema de huevo y queso."
   },
   {
    "key": "s5",
    "text": "Mezcla rápido añadiendo un poco de agua de cocción hasta que quede cremosa, sin que el huevo cuaje. Sirve enseguida, con mucho amor y comprensión."
   }
  ],
  "description": "1. Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que esté crujiente; apaga el fuego.\n\n2. Bate los 4 huevos con el parmesano rallado y bastante pimienta negra hasta tener una crema espesa.\n\n3. Cuece los spaghetti en agua con sal y guarda un vaso del agua de cocción antes de escurrirlos.\n\n4. Echa la pasta en la sartén del guanciale, fuera del fuego, y añade la crema de huevo y queso.\n\n5. Mezcla rápido añadiendo un poco de agua de cocción hasta que quede cremosa, sin que el huevo cuaje. Sirve enseguida, con mucho amor y comprensión."
 },
 {
  "id": "4cfcb72f-bc32-49e9-b244-8ddfd5cb7b30",
  "steps": [
   {
    "key": "s1",
    "text": "Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que suelte la grasa y quede crujiente."
   },
   {
    "key": "s2",
    "text": "Bate las yemas con un huevo entero, el pecorino rallado y bastante pimienta negra recién molida hasta tener una crema espesa."
   },
   {
    "key": "s3",
    "text": "Cuece los espaguetis en agua con poca sal (el pecorino ya es salado) y guarda un vaso del agua de cocción antes de escurrirlos."
   },
   {
    "key": "s4",
    "text": "Fuera del fuego, mezcla la pasta con el guanciale y su grasa, añade la crema de huevo y pecorino y remueve rápido."
   },
   {
    "key": "s5",
    "text": "Añade agua de cocción poco a poco hasta que la salsa quede sedosa sin que el huevo cuaje. Sirve con más pecorino y pimienta."
   }
  ],
  "description": "1. Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que suelte la grasa y quede crujiente.\n\n2. Bate las yemas con un huevo entero, el pecorino rallado y bastante pimienta negra recién molida hasta tener una crema espesa.\n\n3. Cuece los espaguetis en agua con poca sal (el pecorino ya es salado) y guarda un vaso del agua de cocción antes de escurrirlos.\n\n4. Fuera del fuego, mezcla la pasta con el guanciale y su grasa, añade la crema de huevo y pecorino y remueve rápido.\n\n5. Añade agua de cocción poco a poco hasta que la salsa quede sedosa sin que el huevo cuaje. Sirve con más pecorino y pimienta."
 },
 {
  "id": "1e5bf250-52c7-479c-bc99-24ed4fb0193a",
  "steps": [
   {
    "key": "s1",
    "text": "Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que suelte la grasa y quede crujiente."
   },
   {
    "key": "s2",
    "text": "Bate las yemas con un huevo entero, el pecorino rallado y bastante pimienta negra recién molida hasta tener una crema espesa."
   },
   {
    "key": "s3",
    "text": "Cuece los espaguetis en agua con poca sal (el pecorino ya es salado) y guarda un vaso del agua de cocción antes de escurrirlos."
   },
   {
    "key": "s4",
    "text": "Fuera del fuego, mezcla la pasta con el guanciale y su grasa, añade la crema de huevo y pecorino y remueve rápido."
   },
   {
    "key": "s5",
    "text": "Añade agua de cocción poco a poco hasta que la salsa quede sedosa sin que el huevo cuaje. Sirve con más pecorino y pimienta."
   }
  ],
  "description": "1. Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que suelte la grasa y quede crujiente.\n\n2. Bate las yemas con un huevo entero, el pecorino rallado y bastante pimienta negra recién molida hasta tener una crema espesa.\n\n3. Cuece los espaguetis en agua con poca sal (el pecorino ya es salado) y guarda un vaso del agua de cocción antes de escurrirlos.\n\n4. Fuera del fuego, mezcla la pasta con el guanciale y su grasa, añade la crema de huevo y pecorino y remueve rápido.\n\n5. Añade agua de cocción poco a poco hasta que la salsa quede sedosa sin que el huevo cuaje. Sirve con más pecorino y pimienta."
 },
 {
  "id": "26471ab7-8ee2-4d33-8d29-76d1f23244ac",
  "steps": [
   {
    "key": "s1",
    "text": "Precalienta el horno a 200 °C. Pela el boniato, córtalo en gajos, alíñalo con aceite y sal y hornéalo 25-30 minutos, dándole la vuelta a mitad."
   },
   {
    "key": "s2",
    "text": "Corta el pimiento verde en tiras y hazlo en la plancha con un poco de aceite hasta que esté tierno; resérvalo."
   },
   {
    "key": "s3",
    "text": "Saca el cordero de la nevera 15 minutos antes, sécalo con papel y salpimiéntalo."
   },
   {
    "key": "s4",
    "text": "Cocínalo en la plancha bien caliente 2-3 minutos por cada lado, según el grosor, y déjalo reposar un par de minutos."
   },
   {
    "key": "s5",
    "text": "Sirve el cordero con el boniato y el pimiento."
   }
  ],
  "description": "1. Precalienta el horno a 200 °C. Pela el boniato, córtalo en gajos, alíñalo con aceite y sal y hornéalo 25-30 minutos, dándole la vuelta a mitad.\n\n2. Corta el pimiento verde en tiras y hazlo en la plancha con un poco de aceite hasta que esté tierno; resérvalo.\n\n3. Saca el cordero de la nevera 15 minutos antes, sécalo con papel y salpimiéntalo.\n\n4. Cocínalo en la plancha bien caliente 2-3 minutos por cada lado, según el grosor, y déjalo reposar un par de minutos.\n\n5. Sirve el cordero con el boniato y el pimiento."
 },
 {
  "id": "8b71a01c-9371-400f-8e91-fa0477596dd9",
  "steps": [
   {
    "key": "s1",
    "text": "Lava y trocea la lechuga y ponla de base en un bol."
   },
   {
    "key": "s2",
    "text": "Corta la remolacha cocida en dados, el aguacate en láminas y los tomates cherry por la mitad."
   },
   {
    "key": "s3",
    "text": "Reparte por encima el queso fresco desmigado."
   },
   {
    "key": "s4",
    "text": "Tuesta las pipas de calabaza un par de minutos en una sartén sin aceite y añádelas al final."
   },
   {
    "key": "s5",
    "text": "Aliña con aceite de oliva, sal y unas gotas de limón o vinagre."
   }
  ],
  "description": "1. Lava y trocea la lechuga y ponla de base en un bol.\n\n2. Corta la remolacha cocida en dados, el aguacate en láminas y los tomates cherry por la mitad.\n\n3. Reparte por encima el queso fresco desmigado.\n\n4. Tuesta las pipas de calabaza un par de minutos en una sartén sin aceite y añádelas al final.\n\n5. Aliña con aceite de oliva, sal y unas gotas de limón o vinagre."
 }
]$json$::jsonb) loop
    d := jsonb_populate_record(null::public.dishes, r);
    update public.dishes x set steps = d.steps, description = d.description
     where x.id = (r->>'id')::uuid
       and coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(x.steps)) = 'array' then to_jsonb(x.steps) else '[]'::jsonb end), 0) = 0
       and coalesce(btrim(x.description), '') = '';
    if found then n := n + 1; end if;
  end loop;
  raise notice 'Platos con pasos nuevos: %', n;
end $$;

delete from public.dishes where id in ('cbaab783-f116-43dd-87d0-b4030fe698ec');

select count(*) as platos_que_siguen_sin_pasos from public.dishes d
 where coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(d.steps)) = 'array' then to_jsonb(d.steps) else '[]'::jsonb end), 0) = 0
   and coalesce(btrim(d.description), '') = '';

