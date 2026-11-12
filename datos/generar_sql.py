"""Genera el SQL del catálogo de recetas de NutriFit (cuenta @nutrifit).

Uso: python3 datos/generar_sql.py datos/recetas/tanda1.json datos/recetas/fotos_tanda1.json > supabase/catalogo_tanda1.sql

- Las recetas van a nombre de la cuenta @nutrifit (hay que crearla antes desde la app).
- Cada receta tiene un id fijo (sacado de su nombre), así que el SQL se puede pegar
  varias veces: la segunda vez actualiza en lugar de duplicar.
- Añade a `dishes` las columnas photo_credit y photo_source si aún no existen.
- Los tipos de las columnas (text[] o jsonb) los resuelve jsonb_populate_record.
"""
import json, sys

def sql_str(s):
    return "'" + s.replace("'", "''") + "'"

def main(recipes_path, photos_path):
    recipes = json.load(open(recipes_path, encoding="utf-8"))
    photos = json.load(open(photos_path, encoding="utf-8")) if photos_path else {}
    rows = []
    for r in recipes:
        steps = [{"key": f"s{i+1}", "text": t} for i, t in enumerate(r["steps"])]
        ph = photos.get(r["name"]) or {}
        row = {
            "name": r["name"],
            "tags": r["tags"],
            "servings_base": r["servings_base"],
            "duration_min": r["duration_min"],
            "ingredients": r["ingredients"],
            "steps": steps,
            "description": "\n\n".join(f"{i+1}. {t}" for i, t in enumerate(r["steps"])),
            "image_url": ph.get("url"),
            "image_urls": [ph["url"]] if ph.get("url") else [],
            "photo_credit": f'{ph["author"]} · {ph["license"]}' if ph.get("url") else None,
            "photo_source": ph.get("source"),
        }
        rows.append(row)
    data = json.dumps(rows, ensure_ascii=False, indent=1)
    out = []
    out.append(f"""-- ============================================================
-- NUTRIFIT — Catálogo de recetas ({len(rows)} recetas, {recipes_path.split('/')[-1]})
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

  for r in select * from jsonb_array_elements($json${data}$json$::jsonb) loop
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
""")
    sys.stdout.write("".join(out))

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else None)
