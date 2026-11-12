"""Pasos escritos para los platos de usuarios que no tenían (nov 2026) y genera el SQL.

Uso: python3 datos/pasos_platos_usuarios.py > supabase/pasos_platos.sql
Solo rellena platos que siguen sin pasos ni descripción; borra los platos de prueba listados.
"""
import json

YOGUR = [
    "Pon el yogur griego en un bol y alísalo con una cuchara.",
    "Pela el kiwi y córtalo en dados; corta el plátano en rodajas.",
    "Coloca la fruta sobre el yogur y añade la granola justo antes de comer para que siga crujiente.",
    "Termina con un hilo de miel al gusto.",
]
MAGRET = [
    "Precalienta el horno a 200 °C y asa las patatas enteras, pinchadas con un tenedor, unos 45-50 minutos, hasta que estén tiernas.",
    "Vacía la pulpa de las patatas y cháfala con un poco de mantequilla, un chorrito de leche caliente, sal y pimienta hasta tener un puré suave.",
    "Haz cortes en rombo en la grasa del magret sin llegar a la carne y salpimiéntalo.",
    "Ponlo con la piel hacia abajo en una sartén fría y enciende a fuego medio; deja que la grasa se funda 8-10 minutos, retirando la que sobre.",
    "Dale la vuelta y cocina 3-4 minutos más para que quede rosado. Déjalo reposar 5 minutos antes de cortarlo en láminas.",
    "En un poco de la grasa del pato, saltea las setas shiitake laminadas a fuego fuerte 3-4 minutos con una pizca de sal.",
    "Sirve el magret en láminas con el puré y las setas.",
]
CARBONARA_PECORINO = [
    "Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que suelte la grasa y quede crujiente.",
    "Bate las yemas con un huevo entero, el pecorino rallado y bastante pimienta negra recién molida hasta tener una crema espesa.",
    "Cuece los espaguetis en agua con poca sal (el pecorino ya es salado) y guarda un vaso del agua de cocción antes de escurrirlos.",
    "Fuera del fuego, mezcla la pasta con el guanciale y su grasa, añade la crema de huevo y pecorino y remueve rápido.",
    "Añade agua de cocción poco a poco hasta que la salsa quede sedosa sin que el huevo cuaje. Sirve con más pecorino y pimienta.",
]
PASOS = {
    # Yogurt griego con granola y frutas (adri, enricpuig, gabriel, isabellasiracusa, martaloporta)
    "eb1abd45-338e-45c9-94e2-ffa58c220d4b": YOGUR,
    "d0067788-352d-4c3b-a7e6-f9a3e288401f": YOGUR,
    "c0cf381b-735a-4d89-9dd4-b95ddd6f001a": YOGUR,
    "3d7de619-fe79-4eda-ab8c-7882b31b6b3a": YOGUR,
    "25d07240-4bc6-41a9-8099-17f520944ebe": YOGUR,
    # Magret de pato con puré de patata al horno y setas shiitake (cova, pilar)
    "a870c955-3904-425f-97df-7a0a6638efa2": MAGRET,
    "cf76176e-7bce-4f19-9f85-4b30110f876c": MAGRET,
    # Ensalada de tomate y burrata (mma)
    "db3991ec-24e0-40af-8cd4-22fe97886f30": [
        "Corta los tomates en gajos o en rodajas gruesas y colócalos en un plato con una pizca de sal.",
        "Pon la burrata en el centro y ábrela justo antes de servir.",
        "Pica los pistachos por encima y aliña con un buen chorro de aceite de oliva virgen extra y pimienta negra.",
    ],
    # Zamburiñas con guanciale o jamón (mma)
    "06682bcc-2f0d-48f8-a15a-afbe72652428": [
        "Precalienta el horno con el grill a 220 °C.",
        "Corta el guanciale o el jamón en tiras finas.",
        "Coloca las zamburiñas en su concha sobre una bandeja y reparte el guanciale o el jamón por encima.",
        "Gratina 4-5 minutos, hasta que la grasa se funda y las zamburiñas estén justo hechas. Sírvelas al momento.",
    ],
    # Spaghetti a la carbonara (nilpalau)
    "4a9d6513-ba8e-42fd-83cd-6dfcc7462ee4": [
        "Corta el guanciale en tiras y dóralo en una sartén sin aceite a fuego medio hasta que esté crujiente; apaga el fuego.",
        "Bate los 4 huevos con el parmesano rallado y bastante pimienta negra hasta tener una crema espesa.",
        "Cuece los spaghetti en agua con sal y guarda un vaso del agua de cocción antes de escurrirlos.",
        "Echa la pasta en la sartén del guanciale, fuera del fuego, y añade la crema de huevo y queso.",
        "Mezcla rápido añadiendo un poco de agua de cocción hasta que quede cremosa, sin que el huevo cuaje. Sirve enseguida, con mucho amor y comprensión.",
    ],
    # Espaguetis carbonara con guanciale y pecorino (pilar, dos copias)
    "4cfcb72f-bc32-49e9-b244-8ddfd5cb7b30": CARBONARA_PECORINO,
    "1e5bf250-52c7-479c-bc99-24ed4fb0193a": CARBONARA_PECORINO,
    # Cordero a la plancha con guarnición (teresaabascal)
    "26471ab7-8ee2-4d33-8d29-76d1f23244ac": [
        "Precalienta el horno a 200 °C. Pela el boniato, córtalo en gajos, alíñalo con aceite y sal y hornéalo 25-30 minutos, dándole la vuelta a mitad.",
        "Corta el pimiento verde en tiras y hazlo en la plancha con un poco de aceite hasta que esté tierno; resérvalo.",
        "Saca el cordero de la nevera 15 minutos antes, sécalo con papel y salpimiéntalo.",
        "Cocínalo en la plancha bien caliente 2-3 minutos por cada lado, según el grosor, y déjalo reposar un par de minutos.",
        "Sirve el cordero con el boniato y el pimiento.",
    ],
    # Ensalada healthy (teresaabascal)
    "8b71a01c-9371-400f-8e91-fa0477596dd9": [
        "Lava y trocea la lechuga y ponla de base en un bol.",
        "Corta la remolacha cocida en dados, el aguacate en láminas y los tomates cherry por la mitad.",
        "Reparte por encima el queso fresco desmigado.",
        "Tuesta las pipas de calabaza un par de minutos en una sartén sin aceite y añádelas al final.",
        "Aliña con aceite de oliva, sal y unas gotas de limón o vinagre.",
    ],
}
BORRAR = {  # platos de prueba
    "cbaab783-f116-43dd-87d0-b4030fe698ec": "fkfk",
}

def main():
    rows = []
    for did, steps in PASOS.items():
        rows.append({
            "id": did,
            "steps": [{"key": f"s{i+1}", "text": t} for i, t in enumerate(steps)],
            "description": "\n\n".join(f"{i+1}. {t}" for i, t in enumerate(steps)),
        })
    data = json.dumps(rows, ensure_ascii=False, indent=1)
    borrar = ", ".join(f"'{i}'" for i in BORRAR)
    print(f"""-- ============================================================
-- NUTRIFIT — Pasos para los platos que no tenían ({len(rows)} platos) y borrar platos de prueba
-- Solo rellena platos que siguen sin pasos ni descripción (no pisa nada que alguien haya escrito).
-- Borra: {', '.join(BORRAR.values())} (platos de prueba).
-- Pégalo entero en Supabase → SQL Editor → Run. Se puede repetir sin problema.
-- ============================================================
do $$
declare r jsonb; d public.dishes; n int := 0;
begin
  for r in select * from jsonb_array_elements($json${data}$json$::jsonb) loop
    d := jsonb_populate_record(null::public.dishes, r);
    update public.dishes x set steps = d.steps, description = d.description
     where x.id = (r->>'id')::uuid
       and coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(x.steps)) = 'array' then to_jsonb(x.steps) else '[]'::jsonb end), 0) = 0
       and coalesce(btrim(x.description), '') = '';
    if found then n := n + 1; end if;
  end loop;
  raise notice 'Platos con pasos nuevos: %', n;
end $$;

delete from public.dishes where id in ({borrar});

select count(*) as platos_que_siguen_sin_pasos from public.dishes d
 where coalesce(jsonb_array_length(case when jsonb_typeof(to_jsonb(d.steps)) = 'array' then to_jsonb(d.steps) else '[]'::jsonb end), 0) = 0
   and coalesce(btrim(d.description), '') = '';
""")

if __name__ == "__main__":
    main()
