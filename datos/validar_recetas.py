"""Comprueba las recetas del catálogo de NutriFit antes de generar el SQL.

Uso: python3 datos/validar_recetas.py datos/catalogo_ingredientes.tsv datos/recetas/tanda1.json [...]
- Cada ingrediente tiene que existir en el catálogo y llevar su unidad por defecto.
- Etiquetas: al menos un momento (Desayuno, Comida o Cena) y exactamente un Tipo.
- Nada de Repostería en comida o cena; pasos y raciones con sentido; nombres sin repetir.
"""
import json, sys

TAGS = {"Desayuno", "Comida", "Cena", "Carne", "Pescado", "Vegetariano", "Ligero", "Tapas", "Repostería"}
TIPOS = {"Carne", "Pescado", "Vegetariano", "Ligero", "Tapas", "Repostería"}
MOMENTS = {"Desayuno", "Comida", "Cena"}
NOT_VEGAN = ("pollo", "pavo", "ternera", "cerdo", "jamón", "chorizo", "carne", "salmón", "merluza", "dorada",
             "gamba", "atún")

def main(cat_path, files):
    cat = dict(line.rstrip("\n").split("\t") for line in open(cat_path, encoding="utf-8") if line.strip())
    errors, names = [], set()
    total = 0
    for f in files:
        for r in json.load(open(f, encoding="utf-8")):
            total += 1
            n = r["name"]
            where = f"{f}: {n}"
            if n.lower() in names: errors.append(f"{where}: nombre repetido")
            names.add(n.lower())
            tags = set(r.get("tags", []))
            if tags - TAGS: errors.append(f"{where}: etiquetas no válidas {sorted(tags - TAGS)}")
            if not tags & MOMENTS and "Repostería" not in tags: errors.append(f"{where}: le falta Desayuno, Comida o Cena")
            if len(tags & TIPOS) != 1: errors.append(f"{where}: necesita exactamente un Tipo")
            if "Repostería" in tags and tags & {"Comida", "Cena"}: errors.append(f"{where}: repostería en comida/cena")
            if not (1 <= r.get("servings_base", 0) <= 12): errors.append(f"{where}: raciones raras")
            if not (2 <= len(r.get("steps", [])) <= 12): errors.append(f"{where}: número de pasos raro")
            for ing in r["ingredients"]:
                nm, q, u = ing["name"], ing["quantity"], ing["unit"]
                if nm not in cat: errors.append(f"{where}: '{nm}' no está en el catálogo"); continue
                if u != cat[nm]: errors.append(f"{where}: '{nm}' va en '{cat[nm]}', no en '{u}'")
                if q is not None and (not isinstance(q, (int, float)) or q <= 0): errors.append(f"{where}: cantidad rara en '{nm}'")
                plant = any(w in nm for w in ("cacahuete", "almendra", "coco", "avena", "soja", "arroz"))
                if "Vegetariano" in tags and not plant and any(w in nm for w in NOT_VEGAN): errors.append(f"{where}: '{nm}' no es vegano")
    print(f"{total} recetas revisadas, {len(errors)} problemas")
    for e in errors: print(" -", e)
    return 1 if errors else 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2:]))
