-- ============================================================
-- NUTRIFIT — Catalogar TODOS los platos con Momento + Tipo · PASO 2: APLICAR
-- Antes ejecuta el PASO 1 (catalogar_platos_1_revisar.sql): crea las funciones
-- y te enseña los cambios. Esto guarda las etiquetas nuevas en todos los platos.
-- Pégalo entero en Supabase → SQL Editor → Run. Se puede repetir sin problema.
-- ============================================================
do $$
declare
  col_type text;
begin
  select data_type into col_type from information_schema.columns
   where table_schema = 'public' and table_name = 'dishes' and column_name = 'tags';
  if col_type = 'jsonb' then
    update public.dishes d set tags = nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags))
     where coalesce(to_jsonb(d.tags), '[]'::jsonb) is distinct from nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags));
  else -- text[]
    update public.dishes d set tags = array(select jsonb_array_elements_text(nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags))))
     where coalesce(to_jsonb(d.tags), '[]'::jsonb) is distinct from nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags));
  end if;
end $$;

-- Resumen: cuántos platos hay de cada Tipo
select t.tipo, count(*) as platos
  from public.dishes d,
       lateral (select x as tipo from jsonb_array_elements_text(to_jsonb(d.tags)) x
                 where x in ('Carne','Pescado','Vegetariano','Ligero','Tapas','Repostería','Sin catalogar') limit 1) t
 group by t.tipo order by platos desc;
