"""Ingredientes para los platos de usuarios que no tenían (nov 2026) y corrección de la carbonara de @nilpalau.

Uso: python3 datos/ingredientes_platos_usuarios.py > supabase/ingredientes_platos.sql
Solo rellena platos que siguen sin ingredientes.
"""
import json

def ing(name, q, unit):
    return {"name": name, "quantity": q, "unit": unit}

CARBONARA_2 = [ing("espagueti", 200, "g"), ing("guanciale", 100, "g"), ing("yema de huevo", 3, "ud"), ing("huevo", 1, "ud"),
               ing("pecorino", 50, "g"), ing("pimienta negra", None, "pizca"), ing("sal", None, "pizca")]
MAGRET_1 = [ing("magret de pato", 300, "g"), ing("patata", 2, "ud"), ing("mantequilla", 15, "g"), ing("leche", 50, "ml"),
            ing("shiitake", 100, "g"), ing("sal", None, "pizca"), ing("pimienta negra", None, "pizca")]
INGREDIENTES = {
    "4cfcb72f-bc32-49e9-b244-8ddfd5cb7b30": CARBONARA_2,   # pilar · Espaguetis carbonara con guanciale y pecorino (2 raciones)
    "1e5bf250-52c7-479c-bc99-24ed4fb0193a": CARBONARA_2,   # pilar · la otra copia
    "cf76176e-7bce-4f19-9f85-4b30110f876c": MAGRET_1,      # pilar · Magret de pato con puré y shiitake
    "a870c955-3904-425f-97df-7a0a6638efa2": MAGRET_1,      # cova  · Magret de pato con puré y shiitake
}
NILPALAU = "4a9d6513-ba8e-42fd-83cd-6dfcc7462ee4"          # Spaghetti a la carbonara: «4 huevos» -> huevo · 4 ud

def main():
    rows = [{"id": k, "ingredients": v} for k, v in INGREDIENTES.items()]
    data = json.dumps(rows, ensure_ascii=False, indent=1)
    print(f"""-- ============================================================
-- NUTRIFIT — Ingredientes para los platos que no tenían ({len(rows)}) y corrección de la carbonara de @nilpalau
-- Solo rellena platos que siguen sin ingredientes. Se puede repetir sin problema.
-- Pégalo entero en Supabase → SQL Editor → Run.
-- ============================================================
do $$
declare r jsonb; d public.dishes; n int := 0;
begin
  for r in select * from jsonb_array_elements($json${data}$json$::jsonb) loop
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
   where x.id = '{NILPALAU}'
     and exists (select 1 from jsonb_array_elements(to_jsonb(x.ingredients)) e where lower(btrim(e->>'name')) = '4 huevos');
end $$;

select d.name as plato, jsonb_array_length(to_jsonb(d.ingredients)) as ingredientes
  from public.dishes d where d.id in ({', '.join("'" + k + "'" for k in list(INGREDIENTES) + [NILPALAU])})
 order by d.name;
""")

if __name__ == "__main__":
    main()
