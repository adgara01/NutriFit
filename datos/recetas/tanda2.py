"""Segunda tanda del catálogo (nov 2026): tapas, ligeros y repostería, más algún principal.
Genera datos/recetas/tanda2.json. Recetas escritas para NutriFit.
Las especias van sin cantidad (su unidad es «pizca») y la cantidad se dice en los pasos."""
import json
N = None
R = []
def r(name, tags, serv, mins, ings, steps, q):
    R.append({"name": name, "tags": tags, "servings_base": serv, "duration_min": mins,
              "ingredients": [{"name": a, "quantity": b, "unit": c} for a, b, c in ings], "steps": steps, "photo_query": q})

# ---------------- TAPAS ----------------
r("Patatas bravas", ["Cena", "Tapas"], 4, 35, [("patata", 4, "ud"), ("aceite de oliva", 200, "ml"), ("salsa brava", 100, "g"), ("alioli", 60, "g"), ("sal", N, "pizca")], [
  "Pela las patatas y córtalas en dados irregulares de unos 3 cm. Lávalas y sécalas bien.",
  "Cuécelas 5 minutos en agua con sal y escúrrelas.",
  "Fríelas en abundante aceite caliente hasta que estén doradas y crujientes, unos 10 minutos.",
  "Escúrrelas en papel, sálalas y sírvelas con la salsa brava y el alioli por encima."], "patatas bravas")
r("Croquetas de jamón", ["Cena", "Tapas"], 4, 90, [("jamón serrano", 120, "g"), ("mantequilla", 60, "g"), ("harina", 80, "g"), ("leche", 700, "ml"), ("huevo", 2, "ud"), ("pan rallado", 100, "g"), ("aceite de girasol", 300, "ml"), ("nuez moscada", N, "pizca")], [
  "Derrite la mantequilla, añade el jamón picado muy fino y rehógalo un minuto.",
  "Incorpora la harina y cocínala 2 minutos sin dejar de remover.",
  "Vierte la leche caliente poco a poco, sin parar de mover, hasta tener una bechamel espesa. Añade una pizca de nuez moscada.",
  "Cocina 10 minutos más a fuego suave, pásala a una fuente, tápala con film a piel y deja que enfríe en la nevera al menos 2 horas.",
  "Forma las croquetas, pásalas por huevo batido y pan rallado.",
  "Fríelas en aceite bien caliente por tandas hasta que estén doradas y escúrrelas en papel."], "croquetas")
r("Gambas al ajillo", ["Cena", "Tapas"], 2, 15, [("gamba", 300, "g"), ("ajo", 4, "diente"), ("guindilla", 1, "ud"), ("aceite de oliva", 80, "ml"), ("perejil fresco", 5, "g"), ("sal", N, "pizca")], [
  "Pela las gambas dejando la cola y sálalas.",
  "Calienta el aceite en una cazuela de barro con los ajos laminados y la guindilla a fuego suave.",
  "Cuando los ajos empiecen a dorarse, sube el fuego y echa las gambas.",
  "Cocínalas un minuto por cada lado, espolvorea perejil picado y sirve en la misma cazuela, con pan para mojar."], "gambas al ajillo")
r("Pimientos de Padrón", ["Cena", "Tapas"], 2, 10, [("pimiento de padrón", 250, "g"), ("aceite de oliva", 30, "ml"), ("sal gruesa", 5, "g")], [
  "Lava los pimientos y sécalos muy bien.",
  "Fríelos en una sartén con el aceite caliente, moviéndolos, hasta que la piel se ampolle y se doren, unos 4 minutos.",
  "Escúrrelos y sírvelos al momento con sal gruesa por encima."], "pimientos de padron")
r("Champiñones al ajillo", ["Cena", "Tapas"], 2, 15, [("champiñones", 300, "g"), ("ajo", 3, "diente"), ("aceite de oliva", 40, "ml"), ("vino blanco", 40, "ml"), ("perejil fresco", 5, "g"), ("sal", N, "pizca")], [
  "Limpia los champiñones con un paño y córtalos en cuartos.",
  "Dora el ajo laminado en el aceite a fuego medio.",
  "Añade los champiñones, sube el fuego y saltéalos 5 minutos hasta que suelten el agua y se doren.",
  "Echa el vino, deja que se evapore, sala y termina con perejil picado."], "champinones al ajillo")
r("Hummus con crudités", ["Cena", "Tapas"], 4, 15, [("garbanzos cocidos", 400, "g"), ("tahini", 40, "g"), ("limón", 1, "ud"), ("ajo", 1, "diente"), ("aceite de oliva virgen extra", 40, "ml"), ("comino", N, "pizca"), ("pimentón dulce", N, "pizca"), ("zanahoria", 2, "ud"), ("pepino", 1, "ud")], [
  "Escurre los garbanzos y guarda un poco del líquido.",
  "Tritúralos con el tahini, el zumo del limón, el ajo, la mitad del aceite, una pizca de comino y sal hasta que quede muy fino; si está espeso, añade un poco del líquido.",
  "Sírvelo en un plato con un hilo de aceite y pimentón por encima.",
  "Acompáñalo con la zanahoria y el pepino cortados en bastones."], "hummus")
r("Tosta de salmón ahumado y queso fresco", ["Cena", "Tapas"], 2, 10, [("pan de centeno", 120, "g"), ("queso crema", 80, "g"), ("salmón ahumado", 100, "g"), ("eneldo fresco", 3, "g"), ("limón", 1, "ud")], [
  "Tuesta las rebanadas de pan.",
  "Úntalas con el queso crema.",
  "Coloca encima el salmón ahumado, unas gotas de limón y eneldo picado."], "salmon toast")
r("Ensaladilla rusa", ["Cena", "Tapas"], 4, 40, [("patata", 4, "ud"), ("zanahoria", 2, "ud"), ("huevo", 3, "ud"), ("atún en lata", 160, "g"), ("guisantes", 80, "g"), ("aceitunas verdes", 40, "g"), ("mayonesa", 200, "g"), ("sal", N, "pizca")], [
  "Cuece las patatas y las zanahorias con piel en agua con sal hasta que estén tiernas, unos 25 minutos; añade los guisantes los últimos 5.",
  "Cuece los huevos 10 minutos y enfríalos.",
  "Pela patatas, zanahorias y huevos y córtalos en dados pequeños.",
  "Mézclalo todo con el atún escurrido y la mayonesa, y decora con las aceitunas.",
  "Déjala en la nevera al menos una hora antes de servir."], "ensaladilla rusa")
r("Mejillones al vapor con limón", ["Cena", "Tapas"], 2, 15, [("mejillón", 1000, "g"), ("vino blanco", 80, "ml"), ("laurel", 1, "ud"), ("limón", 1, "ud")], [
  "Limpia los mejillones quitándoles las barbas y desecha los que estén abiertos.",
  "Ponlos en una olla con el vino y el laurel, tapa y cocina a fuego fuerte.",
  "En 4 o 5 minutos se abrirán; retira los que sigan cerrados.",
  "Sírvelos con gajos de limón."], "mejillones")
r("Tortilla de espinacas", ["Cena", "Vegetariano"], 2, 15, [("huevo", 4, "ud"), ("espinacas", 150, "g"), ("ajo", 1, "diente"), ("aceite de oliva", 20, "ml"), ("sal", N, "pizca")], [
  "Saltea las espinacas con el ajo picado y la mitad del aceite hasta que se reduzcan; escúrrelas.",
  "Bate los huevos con sal y mézclalos con las espinacas.",
  "Cuaja la tortilla en una sartén pequeña con el resto del aceite, dándole la vuelta con un plato."], "spinach omelette")

# ---------------- LIGEROS ----------------
r("Gazpacho andaluz", ["Comida", "Ligero"], 4, 15, [("tomate pera", 8, "ud"), ("pimiento verde", 1, "ud"), ("pepino", 1, "ud"), ("ajo", 1, "diente"), ("pan", 40, "g"), ("aceite de oliva virgen extra", 60, "ml"), ("vinagre de jerez", 20, "ml"), ("sal", N, "pizca")], [
  "Trocea los tomates, el pimiento, el pepino pelado y el ajo.",
  "Tritúralo todo con el pan, el vinagre y sal hasta que quede muy fino.",
  "Añade el aceite poco a poco sin dejar de triturar para que emulsione.",
  "Pásalo por un colador si lo quieres más fino y déjalo en la nevera hasta que esté bien frío."], "gazpacho")
r("Salmorejo cordobés", ["Comida", "Ligero"], 4, 15, [("tomate pera", 8, "ud"), ("pan", 150, "g"), ("ajo", 1, "diente"), ("aceite de oliva virgen extra", 100, "ml"), ("huevo", 2, "ud"), ("jamón serrano", 50, "g"), ("sal", N, "pizca")], [
  "Cuece los huevos 10 minutos y enfríalos.",
  "Tritura los tomates con el ajo y sal; añade el pan troceado y deja que se empape 5 minutos.",
  "Tritura de nuevo añadiendo el aceite en hilo hasta que quede una crema espesa.",
  "Sírvelo frío con el huevo picado y el jamón en tiras por encima."], "salmorejo")
r("Ensalada mediterránea", ["Cena", "Ligero"], 2, 10, [("lechuga romana", 1, "ud"), ("tomate", 2, "ud"), ("pepino", 1, "ud"), ("cebolla morada", 1, "ud"), ("queso feta", 80, "g"), ("aceitunas negras", 40, "g"), ("aceite de oliva virgen extra", 30, "ml"), ("orégano", N, "pizca")], [
  "Lava y trocea la lechuga.",
  "Corta el tomate en gajos, el pepino en medias lunas y la cebolla en aros finos.",
  "Reparte todo en una fuente con las aceitunas y el queso feta en dados.",
  "Aliña con el aceite, sal y una pizca de orégano."], "greek salad")
r("Crema de calabaza", ["Cena", "Ligero"], 4, 35, [("calabaza", 800, "g"), ("cebolla", 1, "ud"), ("zanahoria", 1, "ud"), ("caldo de verduras", 700, "ml"), ("aceite de oliva", 20, "ml"), ("nuez moscada", N, "pizca"), ("sal", N, "pizca")], [
  "Pocha la cebolla picada en el aceite 5 minutos.",
  "Añade la calabaza y la zanahoria troceadas y rehoga 3 minutos.",
  "Cubre con el caldo y cuece 20 minutos, hasta que todo esté tierno.",
  "Tritura hasta que quede fina, ajusta de sal y añade una pizca de nuez moscada."], "pumpkin soup")
r("Ensalada de quinoa con verduras", ["Comida", "Ligero"], 2, 25, [("quinoa", 120, "g"), ("tomate cherry", 150, "g"), ("pepino", 1, "ud"), ("pimiento rojo", 1, "ud"), ("aguacate", 1, "ud"), ("limón", 1, "ud"), ("aceite de oliva virgen extra", 25, "ml"), ("sal", N, "pizca")], [
  "Lava la quinoa y cuécela en el doble de agua con sal 12-15 minutos; escúrrela y deja que se enfríe.",
  "Corta los tomates por la mitad y el pepino, el pimiento y el aguacate en dados.",
  "Mezcla todo con la quinoa.",
  "Aliña con el zumo del limón, el aceite y sal."], "quinoa salad")
r("Sopa de verduras", ["Cena", "Ligero"], 4, 35, [("puerro", 1, "ud"), ("zanahoria", 2, "ud"), ("apio", 2, "ud"), ("calabacín", 1, "ud"), ("judía verde", 100, "g"), ("caldo de verduras", 1200, "ml"), ("aceite de oliva", 20, "ml"), ("sal", N, "pizca")], [
  "Corta todas las verduras en trozos pequeños.",
  "Rehoga el puerro en el aceite 5 minutos.",
  "Añade el resto de verduras y el caldo, y cuece a fuego suave 20 minutos.",
  "Ajusta de sal y sirve caliente."], "vegetable soup")
r("Poke bowl de salmón", ["Comida", "Pescado"], 2, 30, [("arroz para sushi", 150, "g"), ("salmón", 250, "g"), ("aguacate", 1, "ud"), ("edamame", 80, "g"), ("pepino", 1, "ud"), ("salsa de soja", 30, "ml"), ("semillas de sésamo", 10, "g"), ("vinagre de arroz", 15, "ml")], [
  "Cuece el arroz según el paquete, alíñalo con el vinagre y deja que se temple.",
  "Corta el salmón (apto para comer crudo) en dados y mézclalo con la soja.",
  "Corta el aguacate y el pepino en láminas.",
  "Monta los boles con el arroz de base y encima el salmón, el aguacate, el pepino y el edamame.",
  "Termina con sésamo por encima."], "poke bowl salmon")
r("Bacalao al horno con pimientos", ["Cena", "Pescado"], 2, 30, [("bacalao desalado", 350, "g"), ("pimiento rojo", 1, "ud"), ("pimiento verde", 1, "ud"), ("cebolla", 1, "ud"), ("ajo", 2, "diente"), ("aceite de oliva", 40, "ml")], [
  "Precalienta el horno a 190 °C.",
  "Corta los pimientos y la cebolla en tiras y ásalos 15 minutos en una bandeja con la mitad del aceite.",
  "Coloca encima los lomos de bacalao y riega con el resto del aceite con el ajo laminado.",
  "Hornea 10-12 minutos, hasta que el bacalao se separe en lascas."], "baked cod peppers")

# ---------------- PRINCIPALES ----------------
r("Lasaña de carne", ["Comida", "Carne"], 6, 75, [("placas de lasaña", 12, "ud"), ("carne picada mixta", 500, "g"), ("cebolla", 1, "ud"), ("zanahoria", 1, "ud"), ("tomate triturado", 400, "g"), ("bechamel", 500, "ml"), ("queso rallado", 100, "g"), ("aceite de oliva", 30, "ml"), ("orégano", N, "pizca")], [
  "Pocha la cebolla y la zanahoria picadas en el aceite 8 minutos; añade la carne y dórala.",
  "Echa el tomate y una pizca de orégano y cocina 15 minutos a fuego suave.",
  "Cuece las placas según el paquete (o hidrátalas si son precocidas).",
  "En una fuente, alterna capas de placas, carne y un poco de bechamel; termina con bechamel y queso rallado.",
  "Hornea a 200 °C unos 25 minutos, hasta que esté gratinada. Déjala reposar 10 minutos antes de cortar."], "lasagna")
r("Pollo al ajillo", ["Comida", "Carne"], 4, 40, [("muslo de pollo", 800, "g"), ("ajo", 8, "diente"), ("vino blanco", 120, "ml"), ("aceite de oliva", 60, "ml"), ("laurel", 1, "ud"), ("perejil fresco", 5, "g"), ("sal", N, "pizca")], [
  "Trocea el pollo y sálalo.",
  "Dóralo bien en el aceite por todos los lados, unos 10 minutos.",
  "Añade los ajos enteros chafados y el laurel y rehoga 2 minutos.",
  "Riega con el vino, tapa y cocina a fuego suave 20 minutos, removiendo de vez en cuando.",
  "Termina con perejil picado."], "pollo al ajillo")
r("Arroz con verduras", ["Comida", "Vegetariano"], 4, 40, [("arroz redondo", 320, "g"), ("calabacín", 1, "ud"), ("pimiento rojo", 1, "ud"), ("alcachofa", 3, "ud"), ("judía verde", 100, "g"), ("tomate triturado", 100, "g"), ("caldo de verduras", 1000, "ml"), ("aceite de oliva", 50, "ml"), ("azafrán", N, "pizca")], [
  "Sofríe en el aceite la judía, el pimiento, el calabacín y las alcachofas troceadas, 8 minutos.",
  "Añade el tomate y cocina 3 minutos más.",
  "Echa el arroz, remueve un minuto y vierte el caldo caliente con el azafrán.",
  "Cocina 18 minutos sin remover y deja reposar 5 minutos."], "arroz con verduras")
r("Fajitas de pollo", ["Cena", "Carne"], 4, 25, [("pechuga de pollo", 500, "g"), ("pimiento rojo", 1, "ud"), ("pimiento verde", 1, "ud"), ("cebolla", 1, "ud"), ("tortilla de trigo", 8, "ud"), ("comino", N, "pizca"), ("pimentón dulce", N, "pizca"), ("aceite de oliva", 30, "ml"), ("guacamole", 150, "g")], [
  "Corta el pollo, los pimientos y la cebolla en tiras.",
  "Saltea el pollo a fuego fuerte con el aceite, una pizca de comino, pimentón y sal; resérvalo.",
  "Saltea las verduras 5 minutos y vuelve a echar el pollo.",
  "Calienta las tortillas y rellénalas con el pollo y las verduras. Sirve con guacamole."], "chicken fajitas")

# ---------------- REPOSTERÍA ----------------
r("Bizcocho de yogur", ["Repostería"], 8, 50, [("yogur natural", 1, "ud"), ("azúcar", 200, "g"), ("huevo", 3, "ud"), ("aceite de girasol", 100, "ml"), ("harina", 250, "g"), ("levadura química", 16, "g"), ("ralladura de limón", 5, "g")], [
  "Precalienta el horno a 180 °C y engrasa un molde.",
  "Bate los huevos con el azúcar hasta que blanqueen.",
  "Añade el yogur, el aceite y la ralladura, y mezcla.",
  "Incorpora la harina tamizada con la levadura con movimientos envolventes.",
  "Vierte en el molde y hornea 35-40 minutos, hasta que al pinchar salga limpio."], "sponge cake")
r("Flan de huevo", ["Repostería"], 6, 60, [("huevo", 4, "ud"), ("leche", 500, "ml"), ("azúcar", 120, "g"), ("caramelo líquido", 60, "ml"), ("vainilla", 2, "g")], [
  "Precalienta el horno a 170 °C y cubre el fondo de las flaneras con caramelo.",
  "Bate los huevos con el azúcar y la vainilla, sin hacer espuma, y añade la leche templada.",
  "Reparte la mezcla en las flaneras.",
  "Hornea al baño maría 40 minutos, hasta que cuaje.",
  "Déjalo enfriar y guárdalo en la nevera al menos 3 horas antes de desmoldar."], "flan")
r("Tarta de queso al horno", ["Repostería"], 8, 70, [("queso crema", 600, "g"), ("huevo", 4, "ud"), ("azúcar", 180, "g"), ("nata para montar", 300, "ml"), ("harina", 20, "g")], [
  "Precalienta el horno a 210 °C y forra un molde con papel de horno arrugado.",
  "Bate el queso con el azúcar hasta que quede cremoso.",
  "Añade los huevos de uno en uno, luego la nata y la harina tamizada.",
  "Vierte en el molde y hornea 40-45 minutos: la superficie debe quedar muy dorada y el centro temblón.",
  "Déjala enfriar del todo y luego en la nevera unas horas."], "cheesecake")
r("Torrijas", ["Repostería"], 4, 30, [("barra de pan", 1, "ud"), ("leche", 500, "ml"), ("azúcar", 80, "g"), ("canela en rama", 1, "rama"), ("ralladura de limón", 5, "g"), ("huevo", 2, "ud"), ("aceite de girasol", 300, "ml"), ("canela", N, "pizca")], [
  "Calienta la leche con la canela en rama, la ralladura y la mitad del azúcar; deja que se temple.",
  "Corta el pan del día anterior en rebanadas de dos dedos y empápalas en la leche.",
  "Pásalas por huevo batido y fríelas en aceite caliente hasta que se doren por los dos lados.",
  "Escúrrelas y rebózalas en el resto del azúcar mezclado con canela."], "torrijas")
r("Natillas caseras", ["Repostería"], 4, 25, [("leche", 750, "ml"), ("yema de huevo", 4, "ud"), ("azúcar", 100, "g"), ("maicena", 20, "g"), ("canela en rama", 1, "rama"), ("galletas maría", 4, "ud"), ("canela", N, "pizca")], [
  "Calienta la leche con la canela en rama, reservando un vaso.",
  "Mezcla en el vaso de leche fría las yemas, el azúcar y la maicena.",
  "Retira la canela, añade la mezcla a la leche caliente y cocina a fuego suave sin dejar de remover hasta que espese, sin que hierva.",
  "Reparte en cuencos con una galleta encima y canela en polvo. Enfría en la nevera."], "natillas")
r("Brownie de chocolate", ["Repostería"], 9, 40, [("chocolate negro", 200, "g"), ("mantequilla", 150, "g"), ("azúcar", 180, "g"), ("huevo", 3, "ud"), ("harina", 80, "g"), ("nueces", 80, "g")], [
  "Precalienta el horno a 180 °C y forra un molde cuadrado con papel.",
  "Funde el chocolate con la mantequilla al baño maría o en el microondas a golpes cortos.",
  "Bate los huevos con el azúcar, añade el chocolate fundido y luego la harina.",
  "Incorpora las nueces troceadas y vierte en el molde.",
  "Hornea 20-25 minutos: el centro debe quedar algo húmedo. Deja enfriar antes de cortar."], "brownie")

json.dump(R, open('/home/user/NutriFit/datos/recetas/tanda2.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print(len(R))
