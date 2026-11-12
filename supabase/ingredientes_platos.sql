-- ============================================================
-- NUTRIFIT — Ingredientes para los platos que no tenían (4) y corrección de la carbonara de @nilpalau
-- Solo rellena platos que siguen sin ingredientes. Se puede repetir sin problema.
-- Pégalo entero en Supabase → SQL Editor → Run.
-- ============================================================
do $$
declare r jsonb; d public.dishes; n int := 0;
begin
  for r in select * from jsonb_array_elements($json$[
 {
  "id": "4cfcb72f-bc32-49e9-b244-8ddfd5cb7b30",
  "ingredients": [
   {
    "name": "espagueti",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "guanciale",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "yema de huevo",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "huevo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pecorino",
    "quantity": 50,
    "unit": "g"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ]
 },
 {
  "id": "1e5bf250-52c7-479c-bc99-24ed4fb0193a",
  "ingredients": [
   {
    "name": "espagueti",
    "quantity": 200,
    "unit": "g"
   },
   {
    "name": "guanciale",
    "quantity": 100,
    "unit": "g"
   },
   {
    "name": "yema de huevo",
    "quantity": 3,
    "unit": "ud"
   },
   {
    "name": "huevo",
    "quantity": 1,
    "unit": "ud"
   },
   {
    "name": "pecorino",
    "quantity": 50,
    "unit": "g"
   },
   {
    "name": "pimienta negra",
    "quantity": null,
    "unit": "pizca"
   },
   {
    "name": "sal",
    "quantity": null,
    "unit": "pizca"
   }
  ]
 },
 {
  "id": "cf76176e-7bce-4f19-9f85-4b30110f876c",
  "ingredients": [
   {
    "name": "magret de pato",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "patata",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "mantequilla",
    "quantity": 15,
    "unit": "g"
   },
   {
    "name": "leche",
    "quantity": 50,
    "unit": "ml"
   },
   {
    "name": "shiitake",
    "quantity": 100,
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
  ]
 },
 {
  "id": "a870c955-3904-425f-97df-7a0a6638efa2",
  "ingredients": [
   {
    "name": "magret de pato",
    "quantity": 300,
    "unit": "g"
   },
   {
    "name": "patata",
    "quantity": 2,
    "unit": "ud"
   },
   {
    "name": "mantequilla",
    "quantity": 15,
    "unit": "g"
   },
   {
    "name": "leche",
    "quantity": 50,
    "unit": "ml"
   },
   {
    "name": "shiitake",
    "quantity": 100,
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
  ]
 }
]$json$::jsonb) loop
    d := jsonb_populate_record(null::public.dishes, r);
    update public.dishes x set ingredients = d.ingredients
     where x.id = (r->>'id')::uuid
       and coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(x.ingredients)) = 'array' then to_jsonb(x.ingredients) else '[]'::jsonb end), 0) = 0;
    if found then n := n + 1; end if;
  end loop;
  raise notice 'Platos con ingredientes nuevos: %', n;

  -- @nilpalau: el ingrediente «4 huevos» pasa a «huevo», 4 ud (el resto igual)
  update public.dishes x set ingredients = (jsonb_populate_record(null::public.dishes, jsonb_build_object('ingredients',
      (select jsonb_agg(case when lower(btrim(e->>'name')) = '4 huevos'
                             then (e - 'ingredient_id') || jsonb_build_object('name','huevo','quantity',4,'unit','ud')
                             else e end order by o)
         from jsonb_array_elements(to_jsonb(x.ingredients)) with ordinality as t(e, o))))).ingredients
   where x.id = '4a9d6513-ba8e-42fd-83cd-6dfcc7462ee4'
     and exists (select 1 from jsonb_array_elements(to_jsonb(x.ingredients)) e where lower(btrim(e->>'name')) = '4 huevos');
end $$;

select d.name as plato, jsonb_array_length(to_jsonb(d.ingredients)) as ingredientes
  from public.dishes d where d.id in ('4cfcb72f-bc32-49e9-b244-8ddfd5cb7b30', '1e5bf250-52c7-479c-bc99-24ed4fb0193a', 'cf76176e-7bce-4f19-9f85-4b30110f876c', 'a870c955-3904-425f-97df-7a0a6638efa2', '4a9d6513-ba8e-42fd-83cd-6dfcc7462ee4')
 order by d.name;

