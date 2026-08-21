# %%
# NIVEL 1: ASIGNACIÓN Y COMPARACIÓN BÁSICA

# El error más común es confundir = (asignar) con == (comparar)
x = 30000

# Comparación simple
x == 30000  # Devuelve True (en Python la 'T' es mayúscula)
x != 10  # Devuelve True (Diferente de)

x = 30000
y = 500

# --- 1. Comparaciones de Magnitud ---
x > y  # True: ¿x es mayor que y?
x < y  # False: ¿x es menor que y?
x >= 30000  # True: ¿x es mayor o igual a 30000?
y <= 499  # False: ¿y es menor o igual a 499?

# --- 2. Igualdad y Diferencia ---
x == 30000  # True: ¿x es exactamente igual a 30000? (Doble igual)
x != 200  # True: ¿x es diferente de 200?

# --- 3. Comparaciones de Texto (Strings) ---
nombre = "Gemini"
nombre == "gemini"  # False: Python también diferencia entre MAYÚSCULAS y minúsculas
nombre != "Alexa"  # True: ¿El nombre es distinto a "Alexa"?

# --- 4. Lógica de Pertenencia (Muy potente) ---
# ¿Está el valor contenido en este grupo? (%in% de R se convierte en 'in')
x in [100, 200, 30000]  # True: ¿x está en esta lista?

# --- 5. Lógica de Negación ---
# Se usa la palabra reservada 'not' (en lugar de '!')
not (x == 30000)  # False: "No es cierto que x es igual a 30000"

# --- 6. Valores Especiales (Crucial en Análisis de Datos) ---
# En Python nativo se usa None; la comparación se hace preferentemente con 'is'
z = None  # None representa la ausencia de valor
z is None  # True: ¿z es un valor ausente? (Se recomienda 'is None' sobre == None)

# --- 7. Comparación de Vectores (Uno a uno) ---
# Las listas nativas de Python NO comparan elemento a elemento.
# Para lograr el comportamiento vectorial de R (c()), se usa la librería NumPy:
import numpy as np

vec1 = np.array([1, 2, 3])
vec2 = np.array([1, 10, 3])
vec1 == vec2  # array([ True, False,  True]) (Compara posición por posición)


# %%
# NIVEL 2: ESTRUCTURAS DE CONTROL (IF-ELSE)

# El "What if" clásico
# Se usan dos puntos (:) e sangría/indentación en lugar de llaves {}
# 'else if' de R pasa a ser 'elif' en Python
if x == 30000:
    print("PERFECTO")
elif x < 30000:
    print("ACCESIBLE")
else:
    print("NO ACCESIBLE")

x = 30000
y = 150
pais = "Chile"

# --- 1. Condiciones Múltiples con AND ('&&' pasa a 'and') ---
# Ambas deben ser verdaderas para entrar al bloque
if x == 30000 and pais == "Chile":
    print("Producto disponible en Chile a precio perfecto")

# --- 2. Condiciones Múltiples con OR ('||' pasa a 'or') ---
# Basta con que una sea verdadera
if x < 10000 or y < 200:
    print("Tienes un descuento por precio bajo o inventario bajo")

# --- 3. If-Else Anidado (Nested) ---
# Se mantiene la precisión respetando el nivel de sangría (tabulación)
if x <= 30000:
    if x == 30000:
        print("Precio exacto")
    else:
        print("Precio por debajo del presupuesto")
else:
    print("Demasiado caro")

# --- 4. Lógica sobre Colecciones: all() y any() ---
# Las listas nativas usan sintaxis de comprensión para evaluar cada elemento
precios = [25000, 30000, 35000]

if all(p > 20000 for p in precios):
    print("Todos los productos son de gama alta")

if any(p == 30000 for p in precios):
    print("Al menos un producto tiene el precio ideal")

# --- 5. Operador Ternario (El "ifelse" de una sola línea) ---
# Estructura: valor_si_si if prueba else valor_si_no
mensaje = "Comprar ya" if x == 30000 else "Esperar"
print(mensaje)

# %%
# NIVEL 3: OPERADORES DE PERTENENCIA (%in%)

# Diferencia clave: == vs in
# == compara igualdad exacta de objetos o contenido.
# in busca si un elemento existe dentro de una lista, tupla, conjunto o texto.
# En un if, 'in' devuelve un único True o False, por lo que es totalmente seguro.

# --- 1. Pertenencia con Listas de Texto ---
# %in% de R se convierte en el operador 'in' en Python
fruta = "Manzana"
canasta = ["Pera", "Manzana", "Uva", "Sandía"]

if fruta in canasta:
    print("La fruta está en el inventario")

# --- 2. Negación de la Pertenencia (El "No está") ---
# Python TIENE un operador nativo directo 'not in' (muy superior a !(x %in% y) de R)
invitado = "Pedro"
lista_negra = ["Juan", "Diego", "Luis"]

if invitado not in lista_negra:
    print("Bienvenido: No estás en la lista negra")

# --- 3. Pertenencia con Rangos No Consecutivos ---
# Para conjuntos específicos usamos listas [...]
dias_oferta = [1, 15, 30]
dia_actual = 15

if dia_actual in dias_oferta:
    print("¡Hoy hay descuento especial!")


# El "Súper Truco": ¿Cómo negar la pertenencia de forma elegante?
# En R tenías que crear %nin%. En Python NATIVE no hace falta truco:
# usas 'not in' de forma 100% natural y legible.

x = 5
if x not in [1, 2, 3]:
    print("X no está en el grupo")

# --- 4. Selección Múltiple con match / case (Equivalente al switch de R) ---
# Disponible a partir de Python 3.10. El caso '_' actúa como 'default' / 'else'.
metodo_pago = "Tarjeta"

match metodo_pago:
    case "Efectivo":
        mensaje_pago = "Diríjase a la caja 1"
    case "Tarjeta":
        mensaje_pago = "Use el terminal electrónico"
    case "Transferencia":
        mensaje_pago = "Envíe el comprobante al correo"
    case _:
        mensaje_pago = "No reconocido"

print(mensaje_pago)

# Alternativa clásica a switch usando Diccionarios (muy usada en Python legacy):
opciones_pago = {
    "Efectivo": "Diríjase a la caja 1",
    "Tarjeta": "Use el terminal electrónico",
    "Transferencia": "Envíe el comprobante al correo",
}
mensaje_pago_dict = opciones_pago.get(metodo_pago, "No reconocido")

# --- 5. switch() con resultados numéricos (Usando match / case) ---
tipo_calculo = "doble"
valor = 100

match tipo_calculo:
    case "doble":
        resultado = valor * 2
    case "triple":
        resultado = valor * 3
    case "mitad":
        resultado = valor / 2
    case _:
        resultado = None

print(resultado)

# --- 6. Rangos Numéricos Consecutivos (Equivalente a 15:22 de R) ---
# En R 15:22 incluye el 22. En Python range(15, 23) excluye el límite superior (23).
y = 18
if y in range(15, 23):  # Genera números del 15 al 22
    print("El valor está en el rango de 15 a 22")


# %%
# NIVEL 4: FUNCIONES BÁSICAS Y MINIMALISTAS


# %%

# ANATOMÍA DE UNA F(X) EN PYTHON:
# Componente | Sintaxis Python | Relevancia
# ------------------------------------------------------------------------------
# Argumentos | def f(x, y=1):  | Materias primas. Soporta defaults y tipo de dato.
# Cuerpo     | Identación (4)  | La lógica dentro del bloque sin llaves {}.
# Entorno    | Scope (LEGB)    | Prioriza ámbito local sobre global.
# Retorno    | return x        | ¡OJO! Si no pones return, Python devuelve None
#            |                 | (a diferencia de R que retorna la última línea).

# Pasar argumentos por Posición vs Nombre:
# Por posición: saludar_repetido("Juan", 5)
# Por nombre (Keyword Args): saludar_repetido(veces=5, nombre="Juan")


# --- 0. Ejemplo Mínimo y Funciones Lambda ---
# En R: doble <- function(n) n * 2
def doble(n):
    return n * 2


print(doble(10))

# Sintaxis anónima / corta (Equivalente a R 4.1+ \(n) n * 3)
# Se usa la palabra clave 'lambda'
triple = lambda n: n * 3
print(triple(10))


# --- 1. Funciones con Argumentos Predeterminados ---
# Si el usuario no ingresa 'veces', Python usará el valor 1 por defecto
def saludar_repetido(nombre, veces=1):
    # En Python multiplicamos un string o lista para repetirlo
    # f"{...}" es el equivalente moderno y limpio a paste() de R
    return [f"Hola {nombre}"] * veces


print(saludar_repetido("Gemini"))  # Usa el default (1 vez)
print(saludar_repetido("User", 3))  # Sobrescribe el default (3 veces)


# --- 2. Funciones sin Argumentos (Estáticas) ---
# Importamos el módulo datetime para manejar fechas/horas
from datetime import datetime


def dar_hora():
    print(f"La hora actual es: {datetime.now()}")


dar_hora()  # Se llama siempre con paréntesis vacíos


# --- 3. Funciones que aceptan "Cualquier cosa" (*args) ---
# En R se usa '...'. En Python se usa '*args' para posicionales o '**kwargs' para nombrados.
def super_sumar(*args):
    return sum(args)  # Sumará todos los números que le envíes en una tupla


print(super_sumar(1, 5, 10, 100))  # Resultado: 116


# --- 4. Funciones como Argumentos de otras Funciones ---
# En Python las funciones también son objetos de primera clase ("First Class Citizens")
def operar(x, operacion):
    return operacion(x)


print(operar(5, doble))  # Usamos la función 'doble' creada arriba


# --- 5. Funciones con Verificación de Argumentos ---
# En Python NO existe la función missing(). Para saber si un argumento no fue enviado,
# se asigna 'None' por defecto y se evalúa con 'is None'.
def chequear_dato(x=None):
    if x is None:
        return "¡Oye! Olvidaste poner el número"
    else:
        return x * 10


print(chequear_dato())  # Lanza el mensaje preventivo
print(chequear_dato(5))  # Multiplica por 10 (50)


# %%
# NIVEL 5: FUNCIONES COMPLETAS (MULTIPARTES)
# POR QUÉ RETORNAR OBJETOS COMPLEJOS EN PYTHON:
# En Python, para devolver "combos" de datos (múltiples variables o tipos),
# la alternativa nativa a las listas de R son los DICCIONARIOS o las TUPLAS.

# Elemento en R | Equivalente en Python | Propósito en Nivel 5
# ------------------------------------------------------------------------------
# list()        | dict { key: val }     | Contenedor estructurado llave-valor.
# stopifnot()   | assert / raise        | Detiene el programa si los datos no cumplen condiciones.
# $ (Accessor)  | dict['key'] o dict.key| Acceso a las llaves o atributos del resultado.
# return()      | return                | Salida obligatoria para retornar un valor en Python.

from datetime import date


# --- 1. Retornando Múltiples Objetos (El uso de Diccionarios) ---
# En R usabas list(promedio = ...). En Python el estándar es usar un diccionario { ... }
def analisis_estadistico(vector_datos):

    # Cálculos internos (usando funciones nativas de listas)
    media_val = sum(vector_datos) / len(vector_datos)
    maximo_val = max(vector_datos)
    conteo = len(vector_datos)

    # Creamos un diccionario con llaves (claves) claras para cada resultado
    resultados = {
        "promedio": media_val,
        "valor_max": maximo_val,
        "total_elementos": conteo,
        "fecha_proceso": date.today(),
    }

    return resultados


# Ejecución y acceso al output
mi_informe = analisis_estadistico([10, 20, 30, 40, 50])

# En Python se accede a las llaves usando corchetes ["nombre"] en vez de $
print(mi_informe["promedio"])
print(mi_informe["valor_max"])


# --- 2. Funciones con "Blindaje" (Validación de entrada) ---
# En lugar de stopifnot(), en Python usaste 'assert' o lanzamos un ValueError
def calcular_descuento(precio, porcentaje):

    # Validamos tipos y rangos de forma explícita
    if not isinstance(precio, (int, float)) or precio <= 0:
        raise ValueError("El precio debe ser un número mayor a 0")

    if not isinstance(porcentaje, (int, float)) or not (0 <= porcentaje <= 1):
        raise ValueError("El porcentaje debe ser un número entre 0 y 1")

    precio_final = precio * (1 - porcentaje)
    return precio_final


# calcular_descuento("cien", 0.1) # Lanza un ValueError limpio


# --- 3. El uso de return vs Última Línea ---
# ¡ATENCIÓN! En Python 'return' ES OBLIGATORIO.
# Si no lo pones explícitamente, la función devolverá None (a diferencia de R).
def suma_rapida(a, b):
    return a + b


# --- 4. Funciones que devuelven otras funciones (Closures) ---
# La sintaxis de cierres/closures es conceptualmente idéntica a la de R
def crear_potenciador(exponente):
    def elevar(x):
        return x**exponente  # En Python la potencia se hace con ** (en R es ^)

    return elevar


al_cubo = crear_potenciador(3)  # 'al_cubo' es una función
print(al_cubo(2))  # Resultado: 8


# --- 5. Analizar número (Ejemplo de Diccionario + Colecciones) ---
def analizar_numero(n):
    cuadrado = n**2
    paridad = "Par" if n % 2 == 0 else "Impar"
    # range(1, n + 1) equivale al 1:n de R
    secuencia = list(range(1, n + 1))

    # Retornamos organizado
    return {"res_cuadrado": cuadrado, "tipo": paridad, "secuencia": secuencia}


mi_analisis = analizar_numero(5)
print(mi_analisis["tipo"])


# --- 6. El concepto de "Invisible" / Silenciar salida ---
# Python no tiene un operador invisible() directo. Simplemente se retorna None,
# o la función realiza su tarea de escritura sin lanzar nada en consola.
def guardar_log(mensaje):
    with open("log.txt", "a") as f:
        f.write(f"{mensaje}\n")

    return None  # En Python una función sin print() no muestra nada en consola


# %%
# NIVEL 6<: LÓGICA VECTORIZADA Y SELECCIÓN MÚLTIPLE


# NOTA DE VERDAD TÉCNICA:
# R es rápido en vectores nativos. En Python, para lograr ese "superpoder"
# de vectorización idéntica y sin bucles 'for', se usan NumPy y Pandas.
# Ambas librerías están escritas en C/C++ optimizado.

import numpy as np
import pandas as pd

# --- 0. ifelse() vs np.where() ---
# En R: ifelse(numeros == 30000, "Perfecto", "Otro")
numeros = np.array([10, 30000, 50000])
clasificacion = np.where(numeros == 30000, "Perfecto", "Otro")


# Switch para evitar múltiples 'else if' (usando match/case en Python 3.10+)
operacion = "suma"
match operacion:
    case "suma":
        resultado_switch = 10 + 10
    case "resta":
        resultado_switch = 10 - 5
    case "multi":
        resultado_switch = 10 * 2
    case _:
        resultado_switch = "No definido"


# --- 1. case_when: El equivalente exacto (np.select) ---
# En R usas case_when() de dplyr. En Python la forma más limpia y veloz es np.select()
puntuacion = np.array([10, 50, 85, 95, 100])

# Lista de condiciones (evalúan elemento a elemento)
condiciones = [puntuacion == 100, puntuacion >= 90, puntuacion >= 70, puntuacion >= 50]

# Lista de resultados para cada condición
opciones = ["PERFECTO", "SOBRESALIENTE", "APROBADO", "SUFICIENTE"]

# np.select toma las condiciones, las opciones y 'default' actua como el TRUE ~ "REPROBADO" de R
calificacion = np.select(condiciones, opciones, default="REPROBADO")
print(calificacion)


# --- 2. Vectorización Pura (Operaciones sin bucles) ---
# Al usar arreglos de NumPy o Series de Pandas, las operaciones son vectoriales
precios = np.array([100, 250, 500, 1000])
impuesto = 1.19

# No se necesita un 'for'; opera elemento a elemento
precios_finales = precios * impuesto
print(precios_finales)


# --- 3. Selección con Match (Buscando en Diccionarios) ---
# En R tenías vectores nombrados: paises[codigos]
# En Python usamos listas por comprensión o .map() si usamos Pandas / Diccionarios
codigos = ["CL", "AR", "MX", "CL"]
paises = {"CL": "Chile", "AR": "Argentina", "MX": "México"}

nombres_completos = [paises[c] for c in codigos]
print(nombres_completos)


# --- 4. Lógica Condicional dentro de Tablas (df.assign + np.where) ---
# En R: df %>% mutate(estado = if_else(venta > 40, "Meta Cumplida", "Pendiente"))
df = pd.DataFrame({"id": [1, 2, 3, 4], "venta": [10, 50, 80, 20]})

# Usamos np.where() para crear una columna de manera estricta y rápida
df["estado"] = np.where(df["venta"] > 40, "Meta Cumplida", "Pendiente")
print(df)


# --- 5. La función "Vectorize" (Transformar funciones normales) ---
# En R usas Vectorize(). En Python, NumPy incluye np.vectorize()
def mi_funcion_simple(n):
    if n > 10:
        return "Grande"
    else:
        return "Pequeño"


# np.vectorize adapta una función escalar para que acepte listas o arreglos
mi_funcion_vectorial = np.vectorize(mi_funcion_simple)
print(mi_funcion_vectorial([5, 15]))  # Retorna array(['Pequeño', 'Grande'])


# %%

# Nivel 7: ESTRUCTURAS ITERATIVAS (Loops) Y BLUCLES INFINITOS

# TABLA COMPARATIVA DE BUCLES Y CONTROL:
# Concepto en R | Equivalente en Python | Descripción
# ------------------------------------------------------------------------------
# for (x in v)  | for x in v:           | Recorre elementos de una lista/rango.
# while (cond)  | while cond:           | Repite mientras la condición sea True.
# repeat { }    | while True:           | Bucle infinito manual (se detiene con break).
# next          | continue              | Salta la iteración actual y pasa a la siguiente.
# break         | break                 | Detiene y sale del bucle inmediatamente.

# --- 1. El Bucle FOR (Iteración sobre un conjunto) ---
# En Python se itera directamente sobre cualquier objeto iterable (listas, tuplas, etc.)
frutas = ["Manzana", "Pera", "Uva"]

for f in frutas:
    print(f"Hoy comeré: {f}")


# --- 2. El Bucle WHILE (Iteración condicional) ---
# Funciona exactamente igual que en R. Hay que actualizar la variable de control.
energia = 100
while energia > 0:
    print(f"Trabajando... Energía restante: {energia}")
    energia -= 25  # Equivalente a: energia = energia - 25


# --- 3. El Bucle REPEAT (Bucle infinito manual) ---
# Python NO tiene la palabra clave 'repeat'. Se simula con 'while True:' y 'break'.
contador = 1
while True:
    print(f"Este es el ciclo número: {contador}")

    if contador == 3:
        print("¡Objetivo alcanzado! Saliendo...")
        break  # Rompe el bucle por completo
    contador += 1


# --- 4. Control de Saltos: CONTINUE (El 'next' de R) ---
# En R usas 'next'. En Python se usa 'continue' para saltarse el resto del bloque.
for i in range(1, 6):  # range(1, 6) genera los números 1, 2, 3, 4, 5
    if i == 3:
        continue  # Si el número es 3, salta la impresión y pasa al 4
    print(f"Procesando número: {i}")


# --- 5. Bucle FOR con Índices (Uso de enumerate o range) ---
# En R: for (i in 1:length(precios))
# En Python: usamos range(len(...)) o enumerate() para modificar por índice
precios = [10, 20, 30]

for i in range(len(precios)):
    precios[i] = precios[i] * 2

print(precios)


# --- BONUS: El truco Pythónico (List Comprehension) ---
# Para transformar datos recorriéndolos sin bucles multilínea,
# en Python se prefiere la "comprensión de listas":
precios_originales = [10, 20, 30]
precios_duplicados = [p * 2 for p in precios_originales]
print(precios_duplicados)  # [20, 40, 60]

# Consejo de interrupción:
# Si un bucle infinito se ejecuta en tu terminal de Python o Jupyter Notebook,
# presiona Ctrl + C o interrumpe el Kernel (botón de Stop).


# %%
# NIVEL 8: BLINDAJE Y GESTIÓN DE MENSAHES (MANEJO DE ERRORES)

# JERARQUÍA DE SEÑALES Y EXCEPCIONES:
# Señal en R  | Equivalente en Python | Detiene Código | Propósito
# ------------------------------------------------------------------------------
# stop()      | raise Exception()    | SÍ             | Detiene la ejecución por error crítico.
# warning()   | warnings.warn()      | NO             | Genera una advertencia sin detener.
# message()   | print() / logging    | NO             | Informa sobre el progreso del script.
# tryCatch()  | try / except / else  | NO             | Sistema de captura y recuperación.
#             | / finally            |                |

import math
import warnings

# --- Ejemplo Base: try / except (Equivalente al tryCatch simple) ---
try:
    # Intentamos algo que podría dar un TypeError o ValueError
    resultado = math.log("texto")
except TypeError:
    print("¡Ups! Hubo un error: No puedes sacar logaritmo a un texto")
finally:
    print("Proceso de seguridad finalizado")


# --- 1. STOP / RAISE: Detener el proceso con un error ---
# En Python usamos 'raise' para lanzar excepciones (como ValueError, TypeError)
def validar_edad(edad):
    if edad < 0:
        raise ValueError("¡ERROR FATAL! La edad no puede ser negativa.")
    print("Edad válida.")


# --- 2. WARNING: Dar un aviso sin detener el código ---
# Importamos el módulo nativo 'warnings'
def ajustar_valor(x):
    if x > 100:
        warnings.warn("Aviso: El valor es muy alto, podría haber imprecisiones.")
    return x * 2


# --- 3. MESSAGE: Información útil para el usuario ---
# En Python se suele usar print() simple o el módulo profesional 'logging'
def cargar_datos():
    print("Iniciando conexión con la base de datos...")
    # Simulación de carga
    print("Datos cargados con éxito.")


# --- 4. TRYCATCH / TRY-EXCEPT-FINALLY: El "Seguro de Vida" del código ---
# Capturamos excepciones específicas en lugar de errores genéricos
def resultado_seguro(dato):
    try:
        # PASO A: Intentar la operación
        # En Python math.log() sobre un texto da TypeError; sobre un número negativo da ValueError
        if isinstance(dato, (int, float)):
            if dato < 0:
                warnings.warn("Número negativo")
            return math.log(dato)
        else:
            raise TypeError("El dato no es numérico")

    except TypeError as e:
        # PASO B: ¿Qué hacer si hay un ERROR de TIPO?
        print("Capturamos un error: No se puede calcular logaritmo a un texto.")
        return None  # En Python None es el valor seguro equivalente a NA

    except ValueError as e:
        # PASO C: ¿Qué hacer si hay un ERROR de VALOR?
        print("Capturamos un error de valor: El número no está en el dominio.")
        return float("nan")

    finally:
        # PASO D: Se ejecuta SIEMPRE (limpieza)
        print("Operación finalizada (con o sin éxito).")


# Prueba de fuego:
resultado_seguro(10)  # Funciona bien
resultado_seguro("hola")  # Captura el error y el código sigue vivo


# --- 5. SUPPRESSWARNINGS: Silenciar avisos conocidos ---
# En Python usamos un administrador de contexto 'warnings.catch_warnings()'
with warnings.catch_warnings():
    warnings.simplefilter("ignore")
    # Código donde queremos ignorar warnings puntuales
    ajustar_valor(150)


# --- Ejemplo Pro: Procesar múltiples elementos sin que falle el script ---
archivos = [10, "corrupto", 20, 30]

for item in archivos:
    try:
        resultado = item * 2
        print(f"Procesado exitosamente: {resultado}")
    except TypeError:
        print(f"El elemento '{item}' falló, lo anotamos en el log y seguimos.")


# %%
# NIVEL 9: OPERADORES PERSONALIZADOS (INFIX) Y CURIOSIDADES EXÓTIC

# PARADIGMA Y EQUIVALENCIAS:
# R te permite crear operadores infix usando signos de porcentaje (%ejemplo%).
# En Python NO es posible crear sintaxis con % o crear nuevos operadores arbitrarios,
# pero se logra exactamente lo mismo de dos formas:
# 1. Sobrecargando operadores dunder de Clases (__add__, __or__, etc.)
# 2. Usando funciones simples o el operador de fusión/coalescencia native (a or b / a ?? b).

# Característica R      | Equivalente en Python         | Propósito
# ------------------------------------------------------------------------------
# Infix (%+% / %or%)    | Sobrecarga de métodos (__add__)| Lógica personalizada entre 2 valores.
# -> (Asignación dcha) | No existe nativo              | Python exige variable = valor.
# Backticks ``          | getattr() / dict              | Nombres con espacios no son válidos.
# on.exit()             | try ... finally / try-with    | Garantiza ejecución de limpieza al salir.
# %/% y %%              | // y %                        | División entera y módulo.


# --- 1. Crear tu propio Operador Infix (Sobrecarga de Métodos/Clases) ---
# Para simular la sintaxis de infix en Python, creamos una clase e implementamos __add__ (+)
class Cadena(str):
    def __add__(self, otro):
        # Genera el comportamiento de %+% (agrega espacio automático)
        return Cadena(f"{self} {otro}")


# Uso del operador personalizado '+'
texto1 = Cadena("Hola")
texto2 = Cadena("Mundo")
print(texto1 + texto2)  # Resultado: "Hola Mundo"


# --- 2. El operador de "Valor por Defecto" (Tipo JavaScript / Coalescencia) ---
# En R: valor_sucio %or% 100
# En Python: Se logra de forma nativa usando 'or' o evaluando si es None

valor_sucio = None
# El operador 'or' de Python actúa como Coalescencia: si el primer elemento es Falsy/None, evalúa el segundo.
resultado = valor_sucio or 100
print(resultado)

# Si el valor pudiera ser 0 o False legítimamente y solo quieres filtrar 'None':
resultado_estricto = 100 if valor_sucio is None else valor_sucio


# --- 3. Asignación hacia la DERECHA (No existe en Python) ---
# En R: 100 -> variable_derecha
# En Python la sintaxis de asignación es estrictamente de izquierda a derecha.
variable_derecha = 100
print(variable_derecha)


# --- 4. El uso de Nombres "Ilegales" / Variables con Espacio ---
# Python NO permite crear variables directas con espacio como `variable con espacio`.
# Se simula guardando en diccionarios o usando getattr / setattr en objetos:

variables_dinamicas = {}
variables_dinamicas["variable con espacio"] = "Soy rebelde"
print(variables_dinamicas["variable con espacio"])


# --- 5. Atajos de una sola línea: El equivalente al Pipe con el punto '.' ---
# En R usas magrittr con %>% y el punto '.'.
# En Python se usan expresiones Lambda o encadenamiento de métodos (.pipe() en Pandas):

round_5 = (lambda x: round(x))(5)
print(round_5)


# --- 6. Operadores de Precisión: // y % ---
# División entera (%/% en R) -> // en Python
print(10 // 3)  # División entera: 3

# Módulo (%% en R) -> % en Python
print(10 % 3)  # Módulo: 1


# --- 7. La joya de R: on.exit() vs try ... finally (o Context Managers) ---
# En R: on.exit() ejecuta algo al salir de la función sí o sí.
# En Python: El equivalente directo dentro de una función es la cláusula 'finally'.


def mi_proceso():
    try:
        print("Ejecutando proceso...")
        # Incluso si ocurriera un error aquí, la sección 'finally' se ejecuta siempre
    finally:
        print("Limpieza completada automáticamente (Equivalente exacto a on.exit)")


mi_proceso()

# Forma pro en Python para manejo de recursos: Administradores de contexto (with)
from contextlib import contextmanager


@contextmanager
def proceso_con_limpieza():
    print("Iniciando recursos...")
    try:
        yield
    finally:
        print("Recursos liberados (on.exit pythónico).")


with proceso_con_limpieza():
    print("Ejecutando tarea crítica...")


# %%
# Nivel 10: OPTIMIZACIÓN Y SALIDAS (Output) PROFESIONALES


# LA CAJA DE HERRAMIENTAS DE SALIDA EN PYTHON:
# Función R           | Equivalente en Python          | Formato / Propósito
# ------------------------------------------------------------------------------
# write.csv()         | df.to_csv() / csv.writer()     | Guardar tablas en CSV.
# saveRDS()           | pickle.dump() / joblib.dump()  | Guardar objetos/modelos comprimidos.
# capture.output()    | io.StringIO() / contextlib     | Capturar la salida de consola.
# png() / pdf()       | plt.savefig()                  | Guardar gráficos de Matplotlib.
# writeLines()        | open().write()                 | Escribir líneas de texto en un archivo.
# list.files()        | os.listdir() / glob.glob()     | Listar archivos en una carpeta.

import time
import os
import glob
import contextlib
import io
import pickle

# --- 1. Medir el rendimiento (Benchmarking con time.time()) ---
# Equivalente a Sys.time() en R
inicio = time.time()

# Simulación de un proceso pesado
time.sleep(1.5)  # Pausa el código por 1.5 segundos

fin = time.time()
tiempo_total = fin - inicio
print(f"El proceso tardó: {tiempo_total:.4f} segundos")


# --- 2. system.time(): Forma idiomática con time.perf_counter() ---
# Mide el tiempo de ejecución con alta precisión (CPU/Tiempo Real)
t0 = time.perf_counter()

# Replicar operación pesada
resultado = [sum(os.urandom(100)) for _ in range(1000)]

t1 = time.perf_counter()
print(f"Tiempo transcurrido (perf_counter): {t1 - t0:.4f} segundos")


# --- 3. Exportación Masiva de Datos (Ciclos + Escritura) ---
# Guardar múltiples archivos con nombres dinámicos usando f-strings
nombres = ["cliente_A", "cliente_B", "cliente_C"]

for nombre in nombres:
    # Nombre de archivo dinámico (equivalente a paste0 en R)
    archivo = f"{nombre}_reporte.txt"
    contenido = f"Este es el reporte secreto de: {nombre}"

    # Guardamos usando el manejador de contexto 'with open'
    with open(archivo, "w", encoding="utf-8") as f:
        f.write(contenido)

    print(f"Archivo generado: {archivo}")


# --- 4. Sink: Redirigir la consola a un archivo ---
# En R se usa sink(). En Python la forma más limpia es contextlib.redirect_stdout
with open("bitacora_total.txt", "w", encoding="utf-8") as f:
    with contextlib.redirect_stdout(f):
        print("Este mensaje no saldrá en la consola")
        print("Saldrá directamente en el archivo .txt")
        print(f"Lista procesada: {list(range(10))}")

# Al salir del bloque 'with', la salida vuelve automáticamente a la consola estándar


# --- 5. list.files: Leer múltiples archivos de golpe ---
# En Python usamos el módulo 'glob' para filtrar por patrones como *.txt
archivos_en_carpeta = glob.glob("*.txt")
print("Archivos .txt en la carpeta:", archivos_en_carpeta)


# --- BONUS: Guardar objetos complejos (El saveRDS() / readRDS() de Python) ---
# En R se usa saveRDS() / readRDS(). En Python se usa la librería 'pickle' o 'joblib'
modelo_o_datos = {"coeficientes": [1.5, 2.3], "estado": "entrenado"}

# Guardar (saveRDS)
with open("modelo.rds", "wb") as f:
    pickle.dump(modelo_o_datos, f)

# Cargar (readRDS)
with open("modelo.rds", "rb") as f:
    datos_cargados = pickle.load(f)

print("Objeto cargado desde disco:", datos_cargados)


# --- Limpieza de archivos temporales generados en este script ---
for f in archivos_en_carpeta + ["modelo.rds"]:
    if os.path.exists(f):
        os.remove(f)

# Tip Pro sobre el Cuello de Botella I/O:
# En R, data.table::fwrite() es ultra veloz para DataFrames masivos.
# En Python/Pandas, para guardar tablas gigantes sin cuello de botella de texto (CSV),
# se utiliza el formato binario Parquet mediante 'df.to_parquet()', el cual es hasta
# 10x más rápido y reduce el tamaño de almacenamiento más de un 80%.


#
