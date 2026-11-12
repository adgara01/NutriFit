-- ============================================================
-- NUTRIFIT — Catalogar TODOS los platos con Momento + Tipo · PASO 1: REVISAR
-- GENERADO por datos/reglas_categorias.py (las mismas reglas que la app).
-- Crea unas funciones de ayuda y ENSEÑA cómo quedarían las etiquetas de cada
-- plato. NO cambia ningún plato. Después, si te parece bien, ejecuta el PASO 2.
--   Momento (varios): Desayuno, Comida, Cena  -> lo usa el mazo aleatorio
--   Tipo (uno):       Carne, Pescado (y marisco), Vegetariano, Ligero, Tapas, Repostería -> Explorar
-- Pégalo entero en Supabase → SQL Editor → Run. Se puede repetir sin problema.
-- ============================================================

create or replace function public.nf_norm(t text)
returns text language sql immutable as $$
  select btrim(regexp_replace(regexp_replace(
    translate(lower(coalesce(t,'')), 'áàäâéèëêíìïîóòöôúùüûñç', 'aaaaeeeeiiiioooouuuunc'),
    '[^a-z0-9 ]', ' ', 'g'), '\s+', ' ', 'g'))
$$;
create or replace function public.nf_has(txt text, words text)
returns boolean language sql immutable as $$
  select nf_norm(txt) ~ ('(^| )(' || words || ')(e?s)?( |$)')
$$;
create or replace function public.nf_meat_words() returns text language sql immutable as $$ select 'carne|pollo|pavo|ternera|vaca|buey|cerdo|lomo|solomillo|chuleta|chuleton|costilla|jamon|york|bacon|beicon|panceta|pancetta|tocino|lardon|guanciale|prosciutto|speck|salami|chorizo|chistorra|salchichon|salchicha|longaniza|butifarra|morcilla|cordero|lechazo|ternasco|cochinillo|cabrito|conejo|pato|magret|hamburguesa|albondiga|entrecot|secreto iberico|presa iberica|pluma iberica|pechuga|muslo|contramuslo|alita|fuet|sobrasada|codillo|rabo|oreja|manita|higado|jabali|ciervo|gallina|perdiz|faisan|codorniz|pepperoni|mortadela|kebab|carrillera|carrillada|magro|picada|cecina|lacon|callos|pastrami|nugget|carbonara|bolonesa|ragu' $$;
create or replace function public.nf_fish_words() returns text language sql immutable as $$ select 'pescado|merluza|pescadilla|salmon|atun|bonito|bacalao|dorada|lubina|sardina|boqueron|anchoa|caballa|rape|rodaballo|trucha|lenguado|emperador|pez espada|gallo|palometa|jurel|salmonete|besugo|mero|abadejo|perca|panga|tilapia|marrajo|anguila|bacaladilla|pescadito|chanquete|gamba|langostino|carabinero|cigala|bogavante|langosta|cangrejo|necora|centolla|percebe|mejillon|almeja|chirla|berberecho|navaja|vieira|zamburina|ostra|calamar|chipiron|sepia|pulpo|pota|erizo|surimi|gula|huevas|marisco' $$;

create or replace function public.nf_guess_tipo(p_name text, p_ings jsonb)
returns text language plpgsql immutable as $$
declare
  it jsonb; n text; q numeric; u text; w numeric; meat numeric := 0; fish numeric := 0;
begin
  if nf_has(p_name, 'tarta|pastel|bizcocho|galleta|magdalena|muffin|brownie|cookie|helado|flan|natilla|arroz con leche|mousse|cheesecake|tiramisu|crepe|donut|postre|bombon|turron|churro|gofre|torrija|coulant|profiterol|bunuelo|rosquilla') then return 'Repostería'; end if;
  for it in select * from jsonb_array_elements(case when jsonb_typeof(p_ings)='array' then p_ings else '[]'::jsonb end) loop
    if jsonb_typeof(it) = 'string' then n := it #>> '{}'; q := null; u := '';
    else n := it->>'name'; u := lower(coalesce(it->>'unit',''));
      begin q := nullif(it->>'quantity','')::numeric; exception when others then q := null; end;
    end if;
    if coalesce(nf_norm(n),'') = '' then continue; end if;
    w := case when q is null or q <= 0 then 40 when u in ('g','ml') then q when u in ('kg','l') then q*1000 when u = 'ud' then q*120 else 40 end;
    if nf_has(n, nf_fish_words()) then fish := fish + w;
    elsif nf_has(n, nf_meat_words()) then meat := meat + w;
    end if;
  end loop;
  if meat = 0 and fish = 0 then
    if nf_has(p_name, nf_fish_words()) then fish := 1; elsif nf_has(p_name, nf_meat_words()) then meat := 1; end if;
  end if;
  if nf_has(p_name, 'tapa|pincho|pintxo|montadito|croqueta|brava|patatas bravas|aperitivo|canape|nacho|hummus|guacamole|gilda|banderilla|tosta|empanadilla|alita|chopito|torrezno|tabla de|calamares a la romana') then return 'Tapas'; end if;
  if meat > 0 or fish > 0 then return case when fish >= meat then 'Pescado' else 'Carne' end; end if;
  if nf_has(p_name, 'ensalada|crema|sopa|caldo|gazpacho|salmorejo|pure|bowl|poke|verduras al vapor|carpaccio|tartar|consome') then return 'Ligero'; end if;
  return 'Vegetariano';
end $$;

create or replace function public.nf_new_tags(p_name text, p_ings jsonb, p_tags jsonb)
returns jsonb language plpgsql immutable as $$
declare
  t text; v text; moms text[] := '{}'; old_tipo text; guess text; tipo text;
begin
  for t in select jsonb_array_elements_text(case when jsonb_typeof(p_tags)='array' then p_tags else '[]'::jsonb end) loop
    v := case nf_norm(t)
      when 'desayuno' then 'Desayuno'
      when 'comida' then 'Comida'
      when 'almuerzo' then 'Comida'
      when 'cena' then 'Cena'
      when 'carne' then 'Carne'
      when 'pescado' then 'Pescado'
      when 'pescado y marisco' then 'Pescado'
      when 'marisco' then 'Pescado'
      when 'vegano' then 'Vegetariano'
      when 'vegetariano' then 'Vegetariano'
      when 'ligero' then 'Ligero'
      when 'tapas' then 'Tapas'
      when 'tapa' then 'Tapas'
      when 'tapas y aperitivos' then 'Tapas'
      when 'aperitivo' then 'Tapas'
      when 'reposteria' then 'Repostería'
      when 'postre' then 'Repostería'
      when 'postres' then 'Repostería'
      when 'dulce' then 'Repostería'
      else null end;
    if v in ('Desayuno','Comida','Cena') then
      if not v = any(moms) then moms := moms || v; end if;
    elsif v is not null and old_tipo is null then old_tipo := v;
    end if;
  end loop;
  guess := nf_guess_tipo(p_name, p_ings);
  tipo := case when guess in ('Carne','Pescado') and (old_tipo is null or old_tipo in ('Vegetariano','Carne','Pescado')) then guess
               else coalesce(old_tipo, guess) end;
  if cardinality(moms) = 0 then
    if nf_has(p_name, 'desayuno|tostada|yogur|yogurt|avena|porridge|granola|tortita|pancake|batido|smoothie|cereal|muesli|huevos revueltos|croissant|magdalena|bol de fruta|pudin de chia|crepe|bocadillo|sandwich|zumo|cafe') then moms := array['Desayuno'];
    elsif tipo = 'Repostería' then moms := '{}';
    elsif tipo in ('Ligero','Tapas') then moms := array['Cena'];
    elsif nf_has(p_name, 'arroz|paella|lenteja|garbanzo|alubia|judion|fabada|cocido|potaje|guiso|estofado|pasta|macarron|espagueti|spaghetti|lasana|canelon|fideua|risotto|curry|carbonara|bolonesa') then moms := array['Comida'];
    else moms := array['Comida','Cena'];
    end if;
  end if;
  return to_jsonb(moms || tipo);
end $$;

-- Vista previa: cada plato con sus etiquetas de ahora y las nuevas (solo los que cambian)
select u.username as usuario, d.name as plato,
       coalesce(to_jsonb(d.tags), '[]'::jsonb) as etiquetas_ahora,
       nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags)) as etiquetas_nuevas
  from public.dishes d
  left join public.profiles u on u.id = d.user_id
 where coalesce(to_jsonb(d.tags), '[]'::jsonb) is distinct from nf_new_tags(d.name, to_jsonb(d.ingredients), to_jsonb(d.tags))
 order by u.username, d.name;
