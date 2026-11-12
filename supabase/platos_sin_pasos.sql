-- ============================================================
-- NUTRIFIT — Platos SIN pasos (para que Claude les escriba los pasos)
-- No cambia nada: solo saca una lista. Pégalo en Supabase → SQL Editor → Run,
-- pulsa en la celda del resultado («platos»), copia todo su contenido y pégaselo a Claude.
-- ============================================================
select json_agg(json_build_object(
         'id', d.id,
         'usuario', u.username,
         'nombre', d.name,
         'raciones', d.servings_base,
         'ingredientes', d.ingredients
       ) order by u.username, d.name) as platos
  from public.dishes d
  left join public.profiles u on u.id = d.user_id
 where coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(d.steps)) = 'array' then to_jsonb(d.steps) else '[]'::jsonb end), 0) = 0
   and coalesce(btrim(d.description), '') = '';
