"""Reglas de Momento + Tipo de NutriFit en UN solo sitio.

Genera:
  - el bloque de JS de index.html (entre /*CATS-START*/ y /*CATS-END*/) y las listas MEAT_WORDS / FISH_WORDS
  - supabase/catalogar_platos_1_revisar.sql (las mismas reglas en SQL)
Uso: python3 datos/reglas_categorias.py
Así la app y el SQL deciden exactamente lo mismo.
"""
import json, re

MEAT = ['carne','pollo','pavo','ternera','vaca','buey','cerdo','lomo','solomillo','chuleta','chuleton','costilla','jamon','york',
  'bacon','beicon','panceta','pancetta','tocino','lardon','guanciale','prosciutto','speck','salami','chorizo','chistorra','salchichon',
  'salchicha','longaniza','butifarra','morcilla','cordero','lechazo','ternasco','cochinillo','cabrito','conejo','pato','magret',
  'hamburguesa','albondiga','entrecot','secreto iberico','presa iberica','pluma iberica','pechuga','muslo','contramuslo','alita',
  'fuet','sobrasada','codillo','rabo','oreja','manita','higado','jabali','ciervo','gallina','perdiz','faisan','codorniz',
  'pepperoni','mortadela','kebab','carrillera','carrillada','magro','picada','cecina','lacon','callos','pastrami','nugget',
  'carbonara','bolonesa','ragu']
FISH = ['pescado','merluza','pescadilla','salmon','atun','bonito','bacalao','dorada','lubina','sardina','boqueron','anchoa','caballa',
  'rape','rodaballo','trucha','lenguado','emperador','pez espada','gallo','palometa','jurel','salmonete','besugo','mero','abadejo',
  'perca','panga','tilapia','marrajo','anguila','bacaladilla','pescadito','chanquete','gamba','langostino','carabinero','cigala',
  'bogavante','langosta','cangrejo','necora','centolla','percebe','mejillon','almeja','chirla','berberecho','navaja','vieira',
  'zamburina','ostra','calamar','chipiron','sepia','pulpo','pota','erizo','surimi','gula','huevas','marisco']
SWEET = ['tarta','pastel','bizcocho','galleta','magdalena','muffin','brownie','cookie','helado','flan','natilla','arroz con leche',
  'mousse','cheesecake','tiramisu','crepe','donut','postre','bombon','turron','churro','gofre','torrija','coulant','profiterol',
  'bunuelo','rosquilla']
TAPAS = ['tapa','pincho','pintxo','montadito','croqueta','brava','patatas bravas','aperitivo','canape','nacho','hummus','guacamole',
  'gilda','banderilla','tosta','empanadilla','alita','chopito','torrezno','tabla de','calamares a la romana']
LIGHT = ['ensalada','crema','sopa','caldo','gazpacho','salmorejo','pure','bowl','poke','verduras al vapor','carpaccio','tartar','consome']
BREAKFAST = ['desayuno','tostada','yogur','yogurt','avena','porridge','granola','tortita','pancake','batido','smoothie','cereal','muesli',
  'huevos revueltos','croissant','magdalena','bol de fruta','pudin de chia','crepe','bocadillo','sandwich','zumo','cafe']
HEAVY = ['arroz','paella','lenteja','garbanzo','alubia','judion','fabada','cocido','potaje','guiso','estofado','pasta','macarron',
  'espagueti','spaghetti','lasana','canelon','fideua','risotto','curry','carbonara','bolonesa']
ALIASES = {'desayuno':'Desayuno','comida':'Comida','almuerzo':'Comida','cena':'Cena','carne':'Carne','pescado':'Pescado',
  'pescado y marisco':'Pescado','marisco':'Pescado','vegano':'Vegetariano','vegetariano':'Vegetariano','ligero':'Ligero',
  'tapas':'Tapas','tapa':'Tapas','tapas y aperitivos':'Tapas','aperitivo':'Tapas','reposteria':'Repostería','postre':'Repostería',
  'postres':'Repostería','dulce':'Repostería'}

alt = lambda ws: '|'.join(ws)

JS = r'''/*CATS-START*/
/* Momento + Tipo — GENERADO por datos/reglas_categorias.py (las mismas reglas que el SQL). No editar a mano. */
const CAT_ALIASES = __ALIASES__;
const CAT_RE = {
  meat: new RegExp('(^| )(__MEAT__)(e?s)?( |$)'),
  fish: new RegExp('(^| )(__FISH__)(e?s)?( |$)'),
  sweet: new RegExp('(^| )(__SWEET__)(e?s)?( |$)'),
  tapas: new RegExp('(^| )(__TAPAS__)(e?s)?( |$)'),
  light: new RegExp('(^| )(__LIGHT__)(e?s)?( |$)'),
  breakfast: new RegExp('(^| )(__BREAKFAST__)(e?s)?( |$)'),
  heavy: new RegExp('(^| )(__HEAVY__)(e?s)?( |$)'),
};
function catNorm(t){ return stripAccents(String(t||'').toLowerCase()).replace(/[^a-z0-9 ]/g, ' ').replace(/\s+/g, ' ').trim(); }
// Tipo adivinado: postre por el nombre; si lleva carne o pescado, lo que más pese; tapas y ligeros por el nombre; si no, Vegetariano.
function guessTipo(d){
  const name = catNorm(d && d.name);
  if(CAT_RE.sweet.test(name)) return 'Repostería';
  let meat = 0, fish = 0;
  ((d && d.ingredients) || []).forEach(raw=>{
    const it = typeof raw==='string' ? { name: raw } : (raw || {});
    const n = catNorm(it.name); if(!n) return;
    const q = Number(it.quantity), u = String(it.unit||'').toLowerCase();
    const w = !(q > 0) ? 40 : (u==='g' || u==='ml') ? q : (u==='kg' || u==='l') ? q*1000 : (u==='ud' ? q*120 : 40);
    if(CAT_RE.fish.test(n)) fish += w; else if(CAT_RE.meat.test(n)) meat += w;
  });
  if(!meat && !fish){ if(CAT_RE.fish.test(name)) fish = 1; else if(CAT_RE.meat.test(name)) meat = 1; }
  if(CAT_RE.tapas.test(name)) return 'Tapas';
  if(meat || fish) return fish >= meat ? 'Pescado' : 'Carne';
  if(CAT_RE.light.test(name)) return 'Ligero';
  return 'Vegetariano';
}
// Etiquetas finales de un plato: sus momentos (o adivinados si no tiene) + un Tipo.
// Si lleva carne o pescado claramente, eso manda sobre Vegetariano/Carne/Pescado; Ligero, Tapas y Repostería se respetan.
function catNewTags(d){
  const moms = []; let old = null;
  ((d && d.tags) || []).forEach(t=>{
    const v = CAT_ALIASES[catNorm(t)]; if(!v) return;
    if(v==='Desayuno' || v==='Comida' || v==='Cena'){ if(!moms.includes(v)) moms.push(v); }
    else if(!old) old = v;
  });
  const guess = guessTipo(d);
  const tipo = ((guess==='Carne' || guess==='Pescado') && (!old || old==='Vegetariano' || old==='Carne' || old==='Pescado')) ? guess : (old || guess);
  if(!moms.length){
    const name = catNorm(d && d.name);
    if(CAT_RE.breakfast.test(name)) moms.push('Desayuno');
    else if(tipo==='Repostería'){}
    else if(tipo==='Ligero' || tipo==='Tapas') moms.push('Cena');
    else if(CAT_RE.heavy.test(name)) moms.push('Comida');
    else moms.push('Comida', 'Cena');
  }
  return moms.concat(tipo);
}
function dishTipo(d){ const t = catNewTags(d); return t[t.length-1]; }
function dishMomentos(d){ return catNewTags(d).filter(t=> t==='Desayuno' || t==='Comida' || t==='Cena'); }
// Antes de guardar: el plato siempre queda con Momento(s) + un Tipo.
function ensureTipoTags(tags, d){ return catNewTags({ ...(d||{}), tags }); }
/*CATS-END*/'''

def js_block():
    b = JS
    b = b.replace('__ALIASES__', json.dumps(ALIASES, ensure_ascii=False))
    for k, v in (('__MEAT__',MEAT),('__FISH__',FISH),('__SWEET__',SWEET),('__TAPAS__',TAPAS),('__LIGHT__',LIGHT),('__BREAKFAST__',BREAKFAST),('__HEAVY__',HEAVY)):
        b = b.replace(k, alt(v))
    return b

def sql_file():
    al = '\n'.join(f"      when '{k}' then '{v}'" for k, v in ALIASES.items())
    return f"""-- ============================================================
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
    '[^a-z0-9 ]', ' ', 'g'), '\\s+', ' ', 'g'))
$$;
create or replace function public.nf_has(txt text, words text)
returns boolean language sql immutable as $$
  select nf_norm(txt) ~ ('(^| )(' || words || ')(e?s)?( |$)')
$$;
create or replace function public.nf_meat_words() returns text language sql immutable as $$ select '{alt(MEAT)}' $$;
create or replace function public.nf_fish_words() returns text language sql immutable as $$ select '{alt(FISH)}' $$;

create or replace function public.nf_guess_tipo(p_name text, p_ings jsonb)
returns text language plpgsql immutable as $$
declare
  it jsonb; n text; q numeric; u text; w numeric; meat numeric := 0; fish numeric := 0;
begin
  if nf_has(p_name, '{alt(SWEET)}') then return 'Repostería'; end if;
  for it in select * from jsonb_array_elements(case when jsonb_typeof(p_ings)='array' then p_ings else '[]'::jsonb end) loop
    if jsonb_typeof(it) = 'string' then n := it #>> '{{}}'; q := null; u := '';
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
  if nf_has(p_name, '{alt(TAPAS)}') then return 'Tapas'; end if;
  if meat > 0 or fish > 0 then return case when fish >= meat then 'Pescado' else 'Carne' end; end if;
  if nf_has(p_name, '{alt(LIGHT)}') then return 'Ligero'; end if;
  return 'Vegetariano';
end $$;

create or replace function public.nf_new_tags(p_name text, p_ings jsonb, p_tags jsonb)
returns jsonb language plpgsql immutable as $$
declare
  t text; v text; moms text[] := '{{}}'; old_tipo text; guess text; tipo text;
begin
  for t in select jsonb_array_elements_text(case when jsonb_typeof(p_tags)='array' then p_tags else '[]'::jsonb end) loop
    v := case nf_norm(t)
{al}
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
    if nf_has(p_name, '{alt(BREAKFAST)}') then moms := array['Desayuno'];
    elsif tipo = 'Repostería' then moms := '{{}}';
    elsif tipo in ('Ligero','Tapas') then moms := array['Cena'];
    elsif nf_has(p_name, '{alt(HEAVY)}') then moms := array['Comida'];
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
"""

def main():
    p = 'index.html'
    s = open(p, encoding='utf-8').read()
    blk = js_block()
    if '/*CATS-START*/' in s:
        a = s.index('/*CATS-START*/'); b = s.index('/*CATS-END*/') + len('/*CATS-END*/')
        s = s[:a] + blk + s[b:]
    else:
        a = s.index('const GUESS_FISH_EXTRA')
        m = 'function ensureTipoTags(tags, d){'
        b = s.index(m); b = s.index('\n}\n', b) + 3
        s = s[:a] + blk + '\n' + s[b:]
    s = re.sub(r"const MEAT_WORDS = \[[^\]]*\];", 'const MEAT_WORDS = ' + json.dumps(MEAT) + ';', s, count=1)
    s = re.sub(r"const FISH_WORDS = \[[^\]]*\];", 'const FISH_WORDS = ' + json.dumps(FISH) + ';', s, count=1)
    open(p, 'w', encoding='utf-8').write(s)
    open('supabase/catalogar_platos_1_revisar.sql', 'w', encoding='utf-8').write(sql_file())
    print('ok')

if __name__ == '__main__':
    main()
