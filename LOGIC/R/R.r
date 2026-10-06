# Aritmética Básica (Límite Discreto):
# Suma
# Resta

# Aritmética Escalar (Repetición):
# Multiplicación
# División

# Álgebra Exponencial (Escalamiento):
# Potenciación
# Radicación (Raíces)
# Logaritmos

# Cálculo Infinitesimal (Continuo y Cambio):
# Derivación
# Integración



#%%

# Variables numéricas
a <- 12
b <- 4

# 1. SUMA
res_suma <- a + b           # 16

# 2. RESTA
res_resta <- a - b         # 8

# 3. MULTIPLICACIÓN
res_mult <- a * b          # 48

# 4. DIVISIÓN
res_div <- a / b           # 3

# 5. RADICACIÓN (RAÍCES)
raiz_cuadrada <- sqrt(16)  # 4
raiz_cubica <- 27^(1/3)    # 3

# 6. LOGARITMOS
log_natural <- log(exp(1)) # ln(e) = 1
log_base10 <- log10(100)   # log10(100) = 2


# --- CÁLCULO EN R ---

# 7. DERIVACIÓN (Derivar)
f_expr <- expression(3*x^2 + 5*x - 2)
derivada <- D(f_expr, "x")  # Resultado analítico: 3 * (2 * x) + 5 -> 6x + 5

# Evaluar la derivada en x = 2
x <- 2
val_derivada <- eval(derivada) # 6(2) + 5 = 17


# 8. INTEGRACIÓN (Integrar)
f_func <- function(x) { 3*x^2 + 5*x - 2 }
integral_definida <- integrate(f_func, lower = 0, upper = 2) # Resultado: 14


# Imprimir resultados
cat("=== R ===\n")
cat("Suma:", res_suma, "| Resta:", res_resta, "\n")
cat("Multiplicación:", res_mult, "| División:", res_div, "\n")
cat("Raíz Cuadrada de 16:", raiz_cuadrada, "| Raíz Cúbica de 27:", raiz_cubica, "\n")
cat("Log10(100):", log_base10, "\n")
cat("Derivada analítica:", deparse(derivada), "\n")
cat("Valor de la derivada en x=2:", val_derivada, "\n")
cat("Integral definida (0 a 2):", integral_definida$value, "\n")

# ARSENAL DE COMPARACIONES EN R -> DESARROLLADOR EN R

# base sólida: ladrillos (variables), 
# el cemento (operadores de comparación)
# y los planos (estructuras de control).


# MiB ---------------------------------------------------------------------

# 263 MiB) es el indicador de uso de memoria RAM de RStudio. 
# Realmente 263 MiB es un consumo muy bajo y saludable para un entorno de trabajo 
# (generalmente empieza a ser preocupante cuando supera varios Gigabytes 
# y ralentiza la laptop).
# si el indicador se pone en rojo o quieres liberar y optimizar la RAM 
# Aquí tienes las soluciones principales:

# 1. Elimina variables específicas que ya no necesites
rm(dataframe_gigante, modelo_pesado)

# 2. O limpia TODO el entorno de trabajo
rm(list = ls())

# 3. Fuerza a R a liberar la memoria retenida al sistema operativo
gc()
gc


# Notas -------------------------------------------------------------------


# 1. El then en R es "{}" y en python los ":".
# 2. = (Asignación): Se usa para guardar un valor en una variable (ej. x = 10).
# 3. == (Igualdad): Se usa para preguntar si algo es igual a otra cosa (ej. x == 10).
# 4. Los textos strings deben ir entre comillas "".
# 5. En R, nunca uses x == NA. Debido a la lógica estadística del lenguaje, un 
# valor que no existe (NA) no puede ser comparado con nada, ni siquiera con 
# otro NA. Por eso inventaron la función is.na()
# Cuando un código falle, en la consola: traceback() muestra la ruta del crimen.



library(tidyverse)
df_practica %>% View()
# DATASET df_practica -----------------------------------------------------------------

# Definimos el número de filas (N)
n_filas <- 100

# Usamos una "Semilla" para que los números aleatorios sean siempre los mismos
set.seed(123) 

# --- CONSTRUCCIÓN DEL DATA FRAME ---
df_practica <- data.frame(
  # 1. ID Secuencial (Nivel 4: Funcional)
  id = 1:n_filas,
  
  # 2. Datos Normales (Nivel 5: Stats Base)
  # rnorm(n, mean, sd): Ideal para sueldos, estaturas o pesos
  sueldo = round(rnorm(n_filas, mean = 2500, sd = 500), 2),
  
  # 3. Datos Uniformes (Nivel 5: Distribución Uniforme)
  # runif(n, min, max): Para porcentajes o probabilidades
  productividad = round(runif(n_filas, min = 0, max = 1), 2),
  
  # 4. Datos Categóricos Aleatorios (Nivel 3: Pertenencia)
  # sample(): Elige elementos de una lista con o sin reemplazo
  departamento = sample(c("Ventas", "IT", "RRHH", "Finanzas"), 
                        size = n_filas, replace = TRUE),
  
  # 5. Fechas Aleatorias (Nivel 10: Optimización)
  fecha_ingreso = seq(as.Date('2020/01/01'), as.Date('2023/12/31'), 
                      length.out = n_filas)
)

# --- APLICANDO LA LÓGICA DE LOS 10 NIVELES ---

# NIVEL 4 & 5: Función de Validación
# Creamos una lógica para asignar bonos
calcular_bono <- function(sueldo, prod) {
  if (prod > 0.8) return(sueldo * 0.20)
  if (prod > 0.5) return(sueldo * 0.10)
  return(0)
}

# NIVEL 6: Vectorización de la función
calcular_bono_v <- Vectorize(calcular_bono)

# NIVEL 6: Inserción en el Data Frame
df_practica$bono <- calcular_bono_v(df_practica$sueldo, df_practica$productividad)

# NIVEL 2: Comparación y Filtrado
# Solo empleados de IT con sueldo > 2000
empleados_it_top <- df_practica[df_practica$departamento == "IT" & df_practica$sueldo > 2000, ]

# NIVEL 10: Salida del reporte
write.csv(df_practica, "Mi_Primer_Dataset_Pro.csv", row.names = FALSE)

# --- INSPECCIÓN TÉCNICA (Lo que hace un experto) ---
print(head(df_practica)) # Ver las primeras 6 filas
str(df_practica)        # Ver la estructura (Nivel 1 de interpretación)
summary(df_practica)    # Resumen estadístico (Librería stats)


# La f(x) Switch ----------------------------------------------------------

# 1. If-Else clásico
x <- 15
if (x > 20) {
  print("Grande")
} else if (x == 15) {
  print("Es quince")
} else {
  print("Pequeño")
}

# 2. Vectorized If-Else (ifelse) - ¡Súper usado en R!
# Evalúa todo un vector a la vez, no solo un valor.
numeros <- c(1, 10, 5)
resultado <- ifelse(numeros > 5, "Alto", "Bajo")

# 3. Switch (Menos conocido pero muy limpio)
operacion <- "suma"
calculo <- switch(operacion,
                  "suma" = 5 + 5,
                  "resta" = 5 - 2,
                  "multi" = 5 * 2,
                  "No definido" # Valor por defecto
)

# 4. Repeat (Bucle infinito manual)
# Es menos común que 'while' o 'for', se debe romper con 'break'
contador <- 1
repeat {
  print(contador)
  contador <- contador + 1
  if (contador > 3) break
}

# 5. Stop, Warning y Message (Control de flujo de mensajes)
if (x > 10) {
  message("Aviso: el valor es alto")
}



# f(x) El máximo completo ------------------------------------------------------

calcular_area <- function(radio, unidad = "cm") {
  # Validación (buena práctica)
  if (!is.numeric(radio)) stop("El radio debe ser un número")
  
  area <- pi * radio^2
  
  # Devolver una lista permite retornar múltiples valores
  return(list(resultado = area, medida = unidad))
}

mi_area <- calcular_area(5, "metros")
print(mi_area$resultado)


# estilo "Infix" (Menos usado/Exótico) ------------------------------------
# crear tus propios operadores entre símbolos %

`%sumul%` <- function(a, b) {
  (a + b) * a
}

5 %sumul% 2 # Resultado: (5+2) * 5 = 35



# Funciones de una línea --------------------------------------------------

# Forma tradicional corta
doble <- function(x) x * 2

# Forma ultra-corta (Sintaxis nueva)
triple <- \(x) x * 3

print(triple(10)) # 30


# Enfoque en Listas -------------------------------------------------------
# R es el rey de las listas etiquetadas para agrupar resultados de diferentes tipos.

analizar_numero <- function(n) {
  # Cálculo
  cuadrado <- n^2
  
  # Condicional
  paridad <- ifelse(n %% 2 == 0, "Par", "Impar")
  
  # Bucle/Secuencia
  conteo <- 1:n
  
  # Retornamos una lista (el estándar en R para múltiples resultados)
  return(list(
    resultado_cuadrado = cuadrado,
    tipo = paridad,
    lista_conteo = conteo
  ))
}

# Uso
analisis <- analizar_numero(5)
print(analisis$tipo) # Salida: "Impar"


# archivo de texto o un CSV. ----------------------------------------------
# En R, la forma más común de sacar un "output" que no sea la consola es generar un archivo de texto o un CSV.
analizar_y_guardar_r <- function(n) {
  res <- analizar_numero(n) # Usamos la función que hicimos antes
  
  # Guardar como un archivo de texto simple
  capture.output(print(res), file = "output_r.txt")
  
  return("Archivo guardado con éxito")
}

analizar_y_guardar_r(10)


z
# %in% --------------------------------------------------------------------
# En R, para saber si algo está en un conjunto, usamos el operador %in%.
x <- 1

if (x > 20) {
  print("Grande")
} else if (x %in% 15:22) {  # ¡Aquí está el truco! %in% busca dentro del rango
  print("Está en el rango de 15 a 22")
} else {
  print("Pequeño")
}



# Lógica "Funcional" y Vectorizada ----------------------------------------
# En R, la lógica puede aplicarse a un solo valor o a miles al mismo tiempo.

x <- 10
y <- 20
vector_nums <- c(1, 5, 10)

# 1. IF / ELSE IF / ELSE (Clásico)
# Usamos && (and) y || (or) para valores únicos (escalares)
if (x > 5 && y < 30) {
  print("Lógica AND")
} else if (x == 10 || y == 50) {
  print("Lógica OR")
} else {
  print("Default")
}

# 2. IFELSE Vectorizado (El más potente de R)
# Aplica la lógica a todo un conjunto de datos a la vez
resultados <- ifelse(vector_nums > 5, "Mayor a 5", "Menor o igual")

# 3. SWITCH (Estructura de selección)
# Muy útil para evitar muchos 'else if'
caso <- "resta"
resultado <- switch(caso,
                    "suma" = x + y,
                    "resta" = x - y,
                    "multi" = x * y,
                    stop("Operación no válida") # Manejo de error
)

# 4. ANY / ALL (Lógica sobre conjuntos)
if (any(vector_nums > 8)) print("Al menos uno es > 8")
if (all(vector_nums > 0)) print("Todos son positivos")

# 5. TRY-CATCH (Manejo de errores profesional)
tryCatch({
  log(x)
}, warning = function(w) {
  print("Ojo: hubo un aviso")
}, error = function(e) {
  print("Error fatal")
}, finally = {
  print("Proceso terminado")
}
)









# El enfoque "Limpio" y "Vectorizado" case_when ---------------------------

# Opción 1: El if-else tradicional (Tu código corregido)
x <- 30000

if (x == 30000) {
  print("PERFECTO")
} else if (x < 30000) {
  print("ACCESIBLE")
} else {
  print("NO ACCESIBLE")
}

# Opción 2: El case_when (El más profesional/moderno)
# Si tienes que evaluar muchos rangos, esta función de la librería dplyr es 
# la que usan los expertos para evitar "anidar" tantos else if.

library(dplyr)

resultado <- case_when(
  x == 30000 ~ "PERFECTO",
  x < 30000  ~ "ACCESIBLE",
  TRUE       ~ "NO ACCESIBLE" # Este actúa como el 'else' final
)
print(resultado)



# GUÍA MAESTRA DE R: DE LO BÁSICO A LO AVANZADO ---------------------------

# NIVEL 1: ASIGNACIÓN Y COMPARACIÓN BÁSICA --------------------------------
# El error más común es confundir <- (asignar) con == (comparar)
x <- 30000 

# Comparación simple
x == 30000  # Devuelve TRUE
x != 10     # Devuelve TRUE (Diferente de)

x <- 30000
y <- 500

# --- 1. Comparaciones de Magnitud ---
x > y          # TRUE: ¿x es mayor que y?
x < y          # FALSE: ¿x es menor que y?
x >= 30000     # TRUE: ¿x es mayor o igual a 30000?
y <= 499       # FALSE: ¿y es menor o igual a 499?

# --- 2. Igualdad y Diferencia ---
x == 30000     # TRUE: ¿x es exactamente igual a 30000? (Doble igual)
x != 200       # TRUE: ¿x es diferente de 200?

# --- 3. Comparaciones de Texto (Strings) ---
nombre <- "Gemini"
nombre == "gemini" # FALSE: R diferencia entre MAYÚSCULAS y minúsculas
nombre != "Alexa"  # TRUE: ¿El nombre es distinto a "Alexa"?

# --- 4. Lógica de Pertenencia (Muy potente) ---
# ¿Está el valor contenido en este grupo?
x %in% c(100, 200, 30000) # TRUE: ¿x está en este vector?

# --- 5. Lógica de Negación ---
# El signo ! invierte el resultado (TRUE se vuelve FALSE y viceversa)
!(x == 30000)  # FALSE: "No es cierto que x es igual a 30000"

# --- 6. Valores Especiales (Crucial en Análisis de Datos) ---
z <- NA        # NA representa un valor faltante (Not Available)
is.na(z)       # TRUE: ¿z es un valor faltante? (No se usa == NA)

# --- 7. Comparación de Vectores (Uno a uno) ---
vec1 <- c(1, 2, 3)
vec2 <- c(1, 10, 3)
vec1 == vec2   # TRUE, FALSE, TRUE (Compara posición por posición)


# NIVEL 2: ESTRUCTURAS DE CONTROL (IF-ELSE) -------------------------------

# El objetivo ahora es dominar cómo hacer preguntas más inteligentes combinando 
# varias condiciones y usando funciones que resumen resultados.

# &&	AND (Y)	Solo es verdad si TODO es verdad.
# any()	ALGUNO	Revisa un grupo y avisa si hay al menos un TRUE.
# all()TODOSRevisa un grupo y solo avisa si TODOS son TRUE.

# Fíjate en el ejemplo del If-Else Anidado (Punto 3). 
# Aunque parece más largo, es muy poderoso porque permite filtrar grandes 
# grupos primero y luego entrar en detalles. En programación, esto ayuda a 
# que la computadora no trabaje de más.

Aquí tienes los ejemplos que llevan el if-else al siguiente nivel, incluyendo la lógica "Y" (&&), "O" (||) y las funciones de conjunto.
# El "What if" clásico
if (x == 30000) {
  print("PERFECTO")
} else if (x < 30000) {
  print("ACCESIBLE")
} else {
  print("NO ACCESIBLE")
}

x <- 30000
y <- 150
pais <- "Chile"

# --- 1. Condiciones Múltiples con AND (&&) ---
# Ambas deben ser verdaderas para entrar al bloque
if (x == 30000 && pais == "Chile") {
  print("Producto disponible en Chile a precio perfecto")
}

# --- 2. Condiciones Múltiples con OR (||) ---
# Basta con que una sea verdadera
if (x < 10000 || y < 200) {
  print("Tienes un descuento por precio bajo o inventario bajo")
}

# --- 3. If-Else Anidado (Nested) ---
# Una pregunta dentro de otra para máxima precisión
if (x <= 30000) {
  if (x == 30000) {
    print("Precio exacto")
  } else {
    print("Precio por debajo del presupuesto")
  }
} else {
  print("Demasiado caro")
}

# --- 4. Lógica sobre Vectores: all() y any() ---
# Muy útil cuando tienes una lista de datos y no solo un número
precios <- c(25000, 30000, 35000)

if (all(precios > 20000)) {
  print("Todos los productos son de gama alta")
}

if (any(precios == 30000)) {
  print("Al menos un producto tiene el precio ideal")
}

# --- 5. El "If" de una sola línea (ifelse) ---
# No es un bloque {}, es una función que devuelve un valor
# Estructura: ifelse(prueba, valor_si_si, valor_si_no)
mensaje <- ifelse(x == 30000, "Comprar ya", "Esperar")
print(mensaje)




# NIVEL 3: OPERADORES DE PERTENENCIA (%in%) -------------------------------

# l operador %in% no solo sirve para rangos numéricos simples, sino para filtrar 
# información compleja de manera muy humana.

# la expansión del Nivel 3, incluyendo el uso con texto, la negación del 
# operador y la alternativa más limpia para múltiples opciones: el switch.

# Diferencia clave: %in% vs ==
# Muchos principiantes intentan usar == para comparar un valor con una lista, 
# pero el resultado es muy distinto. Esta tabla te dará la claridad técnica que buscas:
# Concepto: == Compara posición por posición (reciclaje).
# Resultado: es Un vector de TRUE/FALSE del largo de la lista.
# Uso en if: Peligroso (da advertencia de longitud).
# Concepto: %in% Busca si el elemento existe en el conjunto.
# Resultado: Un único TRUE o FALSE.
# Uso en if: Seguro y recomendado.

# --- 1. Pertenencia con Listas de Texto ---
# Útil para validar categorías o etiquetas
fruta <- "Manzana"
canasta <- c("Pera", "Manzana", "Uva", "Sandía")

if (fruta %in% canasta) {
  print("La fruta está en el inventario")
}

# --- 2. Negación de la Pertenencia (El "No está") ---
# En R, para decir "No está en", ponemos el ! antes de toda la expresión
invitado <- "Pedro"
lista_negra <- c("Juan", "Diego", "Luis")

if (!(invitado %in% lista_negra)) {
  print("Bienvenido: No estás en la lista negra")
}

# --- 3. Pertenencia con Rangos No Consecutivos ---
# A diferencia de 15:22, aquí buscamos valores específicos
dias_oferta <- c(1, 15, 30)
dia_actual <- 15

if (dia_actual %in% dias_oferta) {
  print("¡Hoy hay descuento especial!")
}


# El "Súper Truco": ¿Cómo negar %in% de forma elegante?
# Como R no tiene un operador nativo de "no pertenece" (como el not in de Python),
# muchos programadores crean el suyo propio para que el código se lea más fácil:

# Creamos el operador "no pertenece"
`%nin%` <- Negate(`%in%`)

x <- 5
if (x %nin% c(1, 2, 3)) {
  print("X no está en el grupo")
}

# --- 4. Selección Múltiple Limpia con switch() ---
# El switch es el sustituto elegante para cuando tienes muchos 'else if'
# Se basa en una etiqueta (nombre) para decidir qué camino tomar
metodo_pago <- "Tarjeta"

mensaje_pago <- switch(metodo_pago,
                       "Efectivo" = "Diríjase a la caja 1",
                       "Tarjeta"  = "Use el terminal electrónico",
                       "Transferencia" = "Envíe el comprobante al correo",
                       "No reconocido" # Este actúa como el 'else' final (default)
)
print(mensaje_pago)

# --- 5. switch() con resultados numéricos ---
# También puedes usarlo para ejecutar cálculos
tipo_calculo <- "doble"
valor <- 100

resultado <- switch(tipo_calculo,
                    "doble"  = valor * 2,
                    "triple" = valor * 3,
                    "mitad"  = valor / 2
)
print(resultado)

# Útil para verificar si un valor está dentro de un grupo o rango
y <- 18
if (y %in% 15:22) {
  print("El valor está en el rango de 15 a 22")
}



# NIVEL 4: FUNCIONES BÁSICAS Y MINIMALISTAS -------------------------------


# El Nivel 4 es la puerta de entrada a la automatización. En R, una función 
# no es solo una fórmula; es un objeto que puedes manipular. Aquí expandiremos 
# el concepto de "función minimalista" hacia la flexibilidad, permitiendo que 
# tus funciones acepten múltiples argumentos y tengan valores inteligentes por defecto.

# ANATOMÍA DE UNA F(X) EN R:
# Para dominar este nivel, debes visualizar cómo R procesa los datos que le envías:

# Componente: Argumentos ***** (Ver notas abajo)
# Función en R: (x, y = 1)	
# Relevancia: Define las "materias primas" que necesita el código.

# Componente: Cuerpo
# Función en R: { ... }
# Relevancia: Es la "fábrica" donde ocurre la lógica.

# Componente: Entorno
# Función en R: Scope
# Relevancia: La función prefiere sus propias variables antes que las de afuera.

# Componente: Retorno
# Función: Return
# Relevancia: Si no se pone, R devuelve la última línea ejecutada.

# ***** NOTAS: El Nombre de los Argumentos:
# En R puedes llamar a los argumentos de dos formas:
# Por posición: 
#saludar_repetido("Juan", 5) (R asume que "Juan" es el primero y 5 el segundo).
# Por nombre: 
# saludar_repetido(veces = 5, nombre = "Juan") (R ignora el orden porque le dijiste exactamente qué es cada cosa).

# Consejo: Siempre que una función tenga más de 2 argumentos, es mejor usarlos por nombre para evitar errores humanos.

# Ejemplo mínimo (Función de una sola línea)
doble <- function(n) n * 2
doble(10)

# Sintaxis moderna (R 4.1+)
triple <- \(n) n * 3
triple(10)


# --- 1. Funciones con Argumentos Predeterminados ---
# Si el usuario no ingresa 'b', R usará el valor 1 por defecto
saludar_repetido <- function(nombre, veces = 1) {
  rep(paste("Hola", nombre), veces)
}

saludar_repetido("Gemini")      # Usa el default (1 vez)
saludar_repetido("User", 3)     # Sobrescribe el default (3 veces)

# --- 2. Funciones sin Argumentos (Estáticas) ---
# Útiles para tareas repetitivas de limpieza o reporte de hora
dar_hora <- function() {
  print(paste("La hora actual es:", Sys.time()))
}

dar_hora() # Se llama siempre con paréntesis vacíos

# --- 3. Funciones que aceptan "Cualquier cosa" (...) ---
# El operador 'dots' (...) permite pasar argumentos a otras funciones internas
# Es muy usado en gráficas o reportes complejos
super_sumar <- function(...) {
  sum(...) # Sumará todos los números que le envíes, sin importar cuántos sean
}

super_sumar(1, 5, 10, 100) # Resultado: 116

# --- 4. Funciones como Argumentos de otras Funciones ---
# En R, las funciones son "ciudadanos de primera clase"
operar <- function(x, operacion) {
  operacion(x)
}

operar(5, doble) # Usamos la función 'doble' que definiste antes

# --- 5. Funciones con Verificación de Argumentos ---
# El uso de missing() permite saber si el usuario olvidó un dato
chequear_dato <- function(x) {
  if (missing(x)) {
    return("¡Oye! Olvidaste poner el número")
  } else {
    return(x * 10)
  }
}

chequear_dato() # Lanza el mensaje preventivo



# NIVEL 5: FUNCIONES COMPLETAS (MULTIPARTES) ------------------------------

# Aquí es donde dejas de hacer "calculadoras simples" y empiezas a construir 
# "herramientas de análisis". En R, cuando una función procesa algo complejo, 
# no suele devolver un solo número, sino una Lista. Esto permite que la función 
# te entregue el resultado, los gráficos, los mensajes y las advertencias, 
# todo en un solo paquete.

# Por qué usar Listas en el Retorno
# En el mundo real, los datos nunca vienen solos. Imagina que haces una 
# regresión lineal; necesitas los coeficientes, el error, los p-valores y los residuos.

# Elemento: list()
# Propósito en el Nivel 5: El contenedor universal para devolver "combos" de datos.

# Elemento: stopifnot()
# Propósito en el Nivel 5: El "portero" que revisa que los datos sean válidos antes de entrar.

# Elemento: $ (Accessor)
# Propósito en el Nivel 5: La llave maestra para sacar elementos de una lista devuelta.

# Elemento: return()
# Propósito en el Nivel 5: El punto de salida oficial (buena práctica en funciones largas).

# --- 1. Retornando Múltiples Objetos (El uso de list()) ---
# Útil cuando un proceso genera diferentes tipos de información
analisis_estadistico <- function(vector_datos) {
  
  # Cálculos internos
  media_val <- mean(vector_datos)
  maximo_val <- max(vector_datos)
  conteo <- length(vector_datos)
  
  # Creamos una lista con nombres claros para cada resultado
  resultados <- list(
    promedio = media_val,
    valor_max = maximo_val,
    total_elementos = conteo,
    fecha_proceso = Sys.Date()
  )
  
  return(resultados)
}

# Ejecución y acceso al output
mi_informe <- analisis_estadistico(c(10, 20, 30, 40, 50))
print(mi_informe$promedio)   # Acceso con el signo $
print(mi_informe$valor_max)


# --- 2. Funciones con "Blindaje" (Validación de entrada) ---
# Usamos stopifnot() para asegurar que la función no trabaje con basura
calcular_descuento <- function(precio, porcentaje) {
  
  # Si alguna de estas condiciones falla, la función se detiene inmediatamente
  stopifnot(is.numeric(precio), precio > 0)
  stopifnot(is.numeric(porcentaje), porcentaje >= 0, porcentaje <= 1)
  
  precio_final <- precio * (1 - porcentaje)
  return(precio_final)
}

# calcular_descuento("cien", 0.1) # Esto lanzará un error limpio en lugar de "romperse"


# --- 3. El uso de return() vs Última Línea ---
# En R, no es obligatorio poner 'return()', pero da claridad
suma_rápida <- function(a, b) {
  a + b # R devolverá esto automáticamente porque es lo último
}


# --- 4. Funciones que devuelven otras funciones (Closures) ---
# Este es un concepto avanzado: una función que "fabrica" funciones
crear_potenciador <- function(exponente) {
  function(x) {
    x ^ exponente
  }
}

al_cubo <- crear_potenciador(3) # 'al_cubo' ahora es una función
print(al_cubo(2)) # Resultado: 8

# 




# Una función que devuelve una lista con varios resultados
analizar_numero <- function(n) {
  cuadrado <- n^2
  paridad  <- ifelse(n %% 2 == 0, "Par", "Impar")
  conteo   <- 1:n
  
  # Retornamos todo organizado
  return(list(
    res_cuadrado = cuadrado,
    tipo = paridad,
    secuencia = conteo
  ))
}

mi_analisis <- analizar_numero(5)
print(mi_analisis$tipo)

# El concepto de "Invisible" (Tip Pro)
# A veces quieres que una función haga algo (como guardar un archivo) pero que 
# no ensucie tu consola con texto. Para eso se usa invisible().

guardar_log <- function(mensaje) {
  # Escribe algo en un archivo...
  write(mensaje, file = "log.txt", append = TRUE)
  
  # Devuelve el mensaje pero NO lo imprime en pantalla
  invisible(mensaje) 
}




# NIVEL 6: LÓGICA VECTORIZADA Y SELECCIÓN MÚLTIPLE ------------------------


# ifelse() es mucho más rápido que un bucle para vectores
numeros <- c(10, 30000, 50000)
clasificacion <- ifelse(numeros == 30000, "Perfecto", "Otro")

# Switch para evitar múltiples 'else if'
operacion <- "suma"
resultado_switch <- switch(operacion,
                           "suma" = 10 + 10,
                           "resta" = 10 - 5,
                           "multi" = 10 * 2,
                           "No definido"
)


# Aquí es donde R se vuelve 10 veces más rápido que Python para manipular tablas.
# Este nivel es el "superpoder" de R. Mientras otros lenguajes necesitan 
# usar bucles for para procesar listas, R lo hace de forma nativa y simultánea. 
# Aquí aprenderás a usar case_when (la versión moderna y super vitaminada del 
# if-else) y a dominar el switch con vectores.

# Herramienta:case_when()
# Cuándo usarla:Cuando tienes más de 3 condiciones.
# Ventaja: Es extremadamente fácil de leer y mantener.

# Herramienta:if_else()
# Cuándo usarla:En limpieza de datos (Dataframes).
# Ventaja: Es más rápido y seguro que el ifelse básico.

# Herramienta:Vectorize()
# Cuándo usarla:Para reciclar funciones viejas.
# Ventaja: Te ahorra reescribir código complejo.

# Herramienta:%in%
# Cuándo usarla:Para filtros de pertenencia.
# Ventaja: Evita errores de comparación de vectores de distinta longitud.


# --- 1. case_when: El "If-Else" definitivo (Requiere tidyverse o dplyr) ---
# Es mucho más legible que tener 10 "else if" anidados.
library(dplyr)

puntuacion <- c(10, 50, 85, 95, 100)

calificacion <- case_when(
  puntuacion == 100 ~ "PERFECTO",
  puntuacion >= 90  ~ "SOBRESALIENTE",
  puntuacion >= 70  ~ "APROBADO",
  puntuacion >= 50  ~ "SUFICIENTE",
  TRUE              ~ "REPROBADO" # Este es el 'else' final (el resto)
)

print(calificacion)


# --- 2. Vectorización Pura (Operaciones sin bucles) ---
# R aplica la lógica a cada elemento automáticamente
precios <- c(100, 250, 500, 1000)
impuesto <- 1.19

# No necesitas un 'for' para multiplicar cada uno
precios_finales <- precios * impuesto 
print(precios_finales)


# --- 3. Selección con Match (Buscando en diccionarios) ---
# Útil para traducir códigos o etiquetas rápidamente
codigos <- c("CL", "AR", "MX", "CL")
paises <- c(CL = "Chile", AR = "Argentina", MX = "México")

nombres_completos <- paises[codigos]
print(nombres_completos)


# --- 4. Lógica Condicional dentro de Tablas (mutate + if_else) ---
# if_else (con guion bajo) es la versión estricta y rápida de ifelse()
df <- data.frame(id = 1:4, venta = c(10, 50, 80, 20))

df_final <- df %>%
  mutate(estado = if_else(venta > 40, "Meta Cumplida", "Pendiente"))

print(df_final)


# --- 5. La función "Vectorize" (Transformar funciones normales) ---
# Si creaste una función que solo acepta un número, R puede "vectorizarla"
mi_funcion_simple <- function(n) {
  if (n > 10) "Grande" else "Pequeño"
}

# mi_funcion_simple(c(5, 15)) # Esto daría error... pero:
mi_funcion_vectorial <- Vectorize(mi_funcion_simple)
mi_funcion_vectorial(c(5, 15)) # ¡Ahora funciona con vectores!


# Concepto Clave: El "TRUE" al final de case_when
# Nota que en el ejemplo de case_when, la última línea es TRUE ~ "REPROBADO". 
# Esto le dice a R: "Para todo lo que no se cumplió arriba 
# (es decir, el resto de los casos), pon esta etiqueta". Es el equivalente 
# exacto al else { ... } final.






# Nivel 7: ESTRUCTURAS ITERATIVAS (Loops) Y BLUCLES INFINITOS -------------

# Aunque en R siempre preferimos la vectorización (por rapidez), hay momentos 
# donde necesitas un bucle: cuando el paso 2 depende de lo que pasó en el 
# paso 1 (como en una simulación financiera o un modelo matemático).

# Comparativa de Iteración:

# Bucle: for
# Cuando usarlo:Cuando tienes una lista o rango definido.
# Riesgo: Es más lento que la vectorización.

# Bucle: while
# Cuando usarlo: Cuando no sabes cuántas vueltas darás, pero tienes una meta.
# Riesgo: Caer en un bucle infinito si olvidas actualizar la variable.

# Bucle: repeat
# Cuando usarlo: Para procesos complejos que deben evaluarse al final del ciclo.
# Riesgo: Es el más "peligroso" si olvidas el break.


# Aquí tienes el arsenal completo para repetir tareas:


# --- 1. El Bucle FOR (Iteración sobre un conjunto) ---
# Se usa cuando sabes exactamente cuántas veces quieres repetir algo.
frutas <- c("Manzana", "Pera", "Uva")

for (f in frutas) {
  print(paste("Hoy comeré:", f))
}


# --- 2. El Bucle WHILE (Iteración condicional) ---
# Se ejecuta MIENTRAS la condición sea verdadera. 
# ¡Cuidado! Si la condición nunca es falsa, el bucle será infinito.
energia <- 100
while (energia > 0) {
  print(paste("Trabajando... Energía restante:", energia))
  energia <- energia - 25 # IMPORTANTE: Modificar la variable para que termine
}


# --- 3. El Bucle REPEAT (Bucle infinito manual) ---
# No tiene condición de entrada. Tú decides cuándo salir con 'break'.
contador <- 1
repeat {
  print(paste("Este es el ciclo número:", contador))
  
  if (contador == 3) {
    print("¡Objetivo alcanzado! Saliendo...")
    break # Rompe el bucle por completo
  }
  contador <- contador + 1
}


# --- 4. Control de Saltos: NEXT (El 'continue' de R) ---
# Se usa para saltarse una vuelta del bucle sin detenerlo todo.
for (i in 1:5) {
  if (i == 3) {
    next # Si el número es 3, no lo imprimas y pasa al siguiente
  }
  print(paste("Procesando número:", i))
}


# --- 5. Bucle FOR con Índices (Muy usado en programación pro) ---
# Permite modificar el objeto original mientras lo recorres.
precios <- c(10, 20, 30)
for (i in 1:length(precios)) {
  precios[i] <- precios[i] * 2
}
print(precios)

# El Consejo de Oro: ¿For o Vectorización? En R existe la "regla del millón":
# - Si tienes una tarea simple (como multiplicar números), usa Vectorización (ej: x * 2).
# - Si cada paso depende del anterior (como el interés compuesto de una deuda), usa un Bucle.

# Un pequeño truco: 
# Si alguna vez tu terminal de R se queda "pegada" en un bucle infinito, presiona la tecla ESC o el botón rojo de "STOP" en el panel de la consola de RStudio.



# NIVEL 8: BLINDAJE Y GESTIÓN DE MENSAHES (MANEJO DE ERRORES) ------------

# Este es el nivel que separa a los programadores de "scripts" de los 
# desarrolladores de herramientas profesionales. Aquí aprenderás a controlar 
# qué pasa cuando algo sale mal, evitando que tu programa se detenga bruscamente
# y enviando mensajes inteligentes al usuario.

# Jerarquía de señales en R

# Señal: stop()
# Detiene el código: SI
# Propósito: Impedir que el código corra con datos corruptos o imposibles.

# Señal: warning()
# Detiene el código: NO
# Propósito: Alertar sobre algo sospechoso o resultados inusuales.

# Señal: message()
# Detiene el código: NO
# Propósito: Informar al usuario sobre el progreso del script.

# Señal: tryCatch()
# Detiene el código: Crear un sistema resiliente que sabe recuperarse de fallos.
# Propósito: No


# Manejo de errores para que tu código no se detenga si algo falla
tryCatch({
  # Intentamos algo que podría dar error
  resultado <- log("texto") 
}, 
error = function(e) {
  message("¡Ups! Hubo un error: No puedes sacar logaritmo a un texto")
}, 
finally = {
  message("Proceso de seguridad finalizado")
}
)


# --- 1. STOP: Detener el proceso con un error ---
# Se usa cuando continuar el código sería peligroso o imposible.
validar_edad <- function(edad) {
  if (edad < 0) {
    stop("¡ERROR FATAL! La edad no puede ser negativa.")
  }
  print("Edad válida.")
}


# --- 2. WARNING: Dar un aviso sin detener el código ---
# El código sigue corriendo, pero le advierte algo al usuario.
ajustar_valor <- function(x) {
  if (x > 100) {
    warning("Aviso: El valor es muy alto, podría haber imprecisiones.")
  }
  return(x * 2)
}


# --- 3. MESSAGE: Información útil para el usuario ---
# A diferencia de print(), los mensajes se pueden silenciar si se desea.
cargar_datos <- function() {
  message("Iniciando conexión con la base de datos...")
  # Simulación de carga
  message("Datos cargados con éxito.")
}


# --- 4. TRYCATCH: El "Seguro de Vida" del código ---
# Intenta ejecutar algo, y si falla, tiene un plan B (error) o C (warning).
resultado_seguro <- function(dato) {
  tryCatch({
    # PASO A: Intentar la operación
    log(dato)
  }, 
  error = function(e) {
    # PASO B: ¿Qué hacer si hay un ERROR?
    message("Capturamos un error: No se puede calcular logaritmo a un texto.")
    return(NA) # Devolvemos un valor seguro
  }, 
  warning = function(w) {
    # PASO C: ¿Qué hacer si hay un AVISO?
    message("Capturamos un aviso: El número es negativo, el resultado será NaN.")
    return(NaN)
  }, 
  finally = {
    # PASO D: Se ejecuta SIEMPRE (limpieza)
    message("Operación finalizada (con o sin éxito).")
  })
}

# Prueba de fuego:
resultado_seguro(10)      # Funciona bien
resultado_seguro("hola")  # Captura el error y sigue vivo


# --- 5. SUPPRESSWARNINGS: Silenciar avisos conocidos ---
# A veces sabes que algo dará un aviso y no quieres que ensucie la consola.
resultado_silencioso <- suppressWarnings(log(-1))

# El Concepto de "Código Resiliente"
# Imagina que tienes que procesar 1,000 archivos CSV. 
# Si el archivo número 500 está dañado, un código normal se detendría y perderías 
# todo el progreso. Un código con tryCatch diría: "El archivo 500 falló, lo anoto 
# en mi bitácora y sigo con el 501". Eso es lo que te hace un profesional.



# NIVEL 9: OPERADORES PERSONALIZADOS (INFIX) Y CURIOSIDADES EXÓTIC --------
# trata sobre cómo modificar el lenguaje para que se adapte a ti. En R, puedes 
# crear tus propios operadores que se sitúan entre dos valores (como + o -). 
# Estos se llaman operadores Infix.

# Además, veremos un par de curiosidades exóticas que casi nadie usa, pero que 
# te harán ver como un experto total.

# ¿Cuándo usar Operadores Infix?
# Los operadores personalizados son excelentes para DSL (Domain Specific Languages). 
# Si trabajas en finanzas, podrías crear un operador %tasa% que aplique 
# impuestos automáticamente, haciendo que tu código se lea como una oración en 
# lugar de una fórmula matemática compleja:

# Característica: %any%
# Propósito: Crear lógica legible por humanos.
# Nivel de rareza: Alta

# Característica: ->
# Propósito: Cambiar el flujo de lectura del código.
# Nivel de rareza: Media (usado en tuberías largas)

# Característica: Backticks ``
# Propósito: Usar nombres de variables no estándar.
# Nivel de rareza: Alta

# Característica: %/%
# Propósito: Cálculos de tiempos (horas/minutos).
# Nivel de rareza: Baja (muy útil)

# --- 1. Crear tu propio Operador Infix ---
# Regla: El nombre DEBE ir entre signos de porcentaje %nombre%
# Ejemplo: Un operador que concatena texto con un espacio automáticamente
`%+%` <- function(a, b) {
  paste(a, b)
}

"Hola" %+% "Mundo"  # Resultado: "Hola Mundo"


# --- 2. El operador de "Valor por Defecto" (Tipo JavaScript) ---
# Muy útil para manejar NAs de forma elegante
`%or%` <- function(a, b) {
  if (is.na(a) || is.null(a)) return(b) else return(a)
}

valor_sucio <- NA
resultado <- valor_sucio %or% 100  # Si es NA, usa 100
print(resultado)


# --- 3. Asignación hacia la DERECHA (La rareza de R) ---
# Casi todos los lenguajes asignan de derecha a izquierda. R permite ambos.
100 -> variable_derecha
print(variable_derecha)


# --- 4. El uso de backticks `` para nombres "ilegales" ---
# R te permite tener variables con espacios o nombres prohibidos si usas ``
`variable con espacio` <- "Soy rebelde"
print(`variable con espacio`)


# --- 5. Atajos de una sola línea: El punto . en Pipes ---
# Si usas la librería magrittr o dplyr, el punto representa "el dato anterior"
library(dplyr)
5 %>% round(.) # El punto le dice a R: "Pon el 5 aquí explícitamente"


# --- 6. Operadores de Precisión: %/% y %% ---
# Ya los vimos, pero son vitales en lógica de ciclos
10 %/% 3  # División entera: ¿Cuántas veces cabe el 3 en el 10? (3)
10 %% 3   # Módulo: ¿Cuál es el resto de esa división? (1)

# El menos usado: crear tu propio símbolo de operación
`%suma_y_doble%` <- function(a, b) { (a + b) * 2 }
10 %suma_y_doble% 5  # Resultado: (10+5)*2 = 30

# Curiosidad Exótica: La función on.exit()
# Esta es una joya que se usa dentro de funciones. Le dice a R: 
# "No importa qué pase o si hay un error, antes de que esta función se cierre, ejecuta esto". 
# Es perfecto para cerrar conexiones a bases de datos o borrar archivos temporales automáticamente.

mi_proceso <- function() {
  on.exit(message("Limpieza completada automáticamente"))
  print("Ejecutando proceso...")
  # Si aquí hubiera un error, on.exit se ejecutaría igual
}


# Nivel 10: OPTIMIZACIÓN Y SALIDAS (Output) PROFESIONALES ----------------
# En este nivel, dejamos de preocuparnos por si el código funciona y empezamos 
# a preocuparnos por qué tan bien funciona y cómo entregamos los resultados al 
# mundo exterior. Aquí aprenderás a medir el rendimiento y a automatizar 
# la creación de archivos.

# La Caja de Herramientas de Salida

# Función: write.csv()
# Propósito: Guardar tablas para Excel.
# Formato: .csv

# Función: saveRDS()
# Propósito: Guardar objetos de R (listas, modelos) de forma comprimida.
# Formato: .rds

# Función: capture.output()
# Propósito: Guardar el texto que escupe una función compleja.
# Formato: .txt

# Función: png() / pdf()
# Propósito: Abrir un "tunel" para guardar una gráfica sin verla.
# Formato: .png / .pdf


# --- 1. Medir el rendimiento (Benchmarking) ---
# ¿Cuánto tarda realmente tu código? Úsalo para comparar 'for' vs 'vectorización'
inicio <- Sys.time()

# Simulación de un proceso pesado
Sys.sleep(1.5) # Pausa el código por 1.5 segundos

fin <- Sys.time()
tiempo_total <- fin - inicio
print(paste("El proceso tardó:", tiempo_total))


# --- 2. system.time(): Una forma más rápida de medir ---
# Devuelve el tiempo de CPU y el tiempo real transcurrido
system.time({
  resultado <- replicate(1000, mean(runif(1000)))
})


# --- 3. Exportación Masiva de Datos (Ciclos + Write) ---
# Cómo guardar múltiples resultados en archivos distintos automáticamente
nombres <- c("cliente_A", "cliente_B", "cliente_C")

for (nombre in nombres) {
  # Creamos un nombre de archivo dinámico
  archivo <- paste0(nombre, "_reporte.txt")
  
  # Contenido ficticio
  contenido <- paste("Este es el reporte secreto de:", nombre)
  
  # Guardamos
  writeLines(contenido, con = archivo)
  message("Archivo generado: ", archivo)
}


# --- 4. Sink: Redirigir TODA la consola a un archivo ---
# Todo lo que normalmente verías en pantalla se guardará en el .txt
sink("bitacora_total.txt")

print("Este mensaje no saldrá en la consola")
print("Saldrá directamente en el archivo .txt")
summary(rnorm(100))

sink() # ¡IMPORTANTE! Cerramos el sink para volver a ver la consola


# --- 5. List.files: Leer múltiples archivos de golpe ---
# El primer paso para el Big Data: saber qué hay en la carpeta
archivos_en_carpeta <- list.files(pattern = ".txt")
print(archivos_en_carpeta)

# Reflexión Final del Nivel 10: El "Cuello de Botella"
# A este nivel, descubrirás que el mayor retraso en un código no suele ser el 
# cálculo matemático, sino la I/O (Entrada y Salida): leer y escribir archivos.

# Tip Pro: Si tienes que guardar una tabla gigante (millones de filas), usa la 
# librería data.table y su función fwrite(). Es hasta 10 veces más rápida que el 
# write.csv() estándar de R.




# EL BARRENDERO DE DATOS (Data Sweeper) ---------------------------------

# Algo muy básico pero vital es aprender a organizar tu trabajo. 
# En R, esto se llama R Projects (.Rproj). Permite que todo tu código y tus 
# archivos vivan en una "caja" organizada para que nunca más tengas problemas 
# con las rutas de los archivos (getwd y setwd).

# Para cerrar con broche de oro este entrenamiento y pasar a la Gestión de Datos, 
# vamos a construir ese Script de Limpieza Automática.

# Este script es la prueba de fuego: usaremos 
# asignación, funciones, lógica condicional, vectorización y salida de archivos 
# en un solo flujo de trabajo. Imagina que tienes una lista de ventas y quieres 
# que R haga el trabajo sucio por ti.

# PROYECTO: SCRIPT DE LIMPIEZA AUTOMÁTICA
# Objetivo: Cargar, filtrar, procesar y guardar un reporte.

# 1. NIVEL 5: Definimos la "Fábrica" (Función de procesamiento)
# Esta función decide si una venta es "Premium" o "Estándar"
clasificar_venta <- function(monto) {
  if (is.na(monto)) return("DATO FALTANTE") # Nivel 1: Manejo de NAs
  
  # Nivel 2: Lógica condicional
  if (monto >= 500) {
    return("PREMIUM")
  } else {
    return("ESTÁNDAR")
  }
}

# 2. NIVEL 4: Función vectorizada
# Convertimos nuestra función para que trabaje con listas enteras
clasificador_v <- Vectorize(clasificar_venta)

# 3. NIVEL 1 & 6: Creamos "Datos Sucios" (Simulación de carga)
ventas_sucias <- c(100, 600, NA, 450, 800, 20)
nombres_clientes <- c("Juan", "Pedro", "Desconocido", "Ana", "Luis", "Marta")

# 4. NIVEL 6: Procesamiento masivo (Data Wrangling básico)
tabla_ventas <- data.frame(
  Cliente = nombres_clientes,
  Monto = ventas_sucias
)

# Creamos una nueva columna con nuestra lógica
tabla_ventas$Categoria <- clasificador_v(tabla_ventas$Monto)

# 5. NIVEL 7 & 8: Limpieza de Errores
# Eliminamos filas con NAs para que el reporte sea limpio
tabla_limpia <- na.omit(tabla_ventas)

# 6. NIVEL 10: Exportación del Reporte Final
# Guardamos el resultado en un archivo y avisamos al usuario
write.csv(tabla_limpia, "Reporte_Ventas_Limpio.csv", row.names = FALSE)

message("--- PROCESO COMPLETADO ---")
message("Se procesaron ", nrow(tabla_ventas), " registros.")
message("El archivo 'Reporte_Ventas_Limpio.csv' está listo en tu carpeta.")

# ¿Qué acabas de lograr con este código? 
# Acabas de replicar el Ciclo de Vida de la Ciencia de Datos:

# - Ingesta: Creaste (o cargaste) datos.
# - Limpieza: Detectaste los NA y los clasificaste o eliminaste.
# - Transformación: Aplicaste una lógica de negocio (Premium vs Estándar).
# - Comunicación: Generaste un archivo físico para que otros lo vean.





# LIBRERÍAS ---------------------------------------------------------------

# 1. Librerías Base: Son las herramientas que ya vienen en la caja cuando 
# instalas R (el martillo y el destornillador). No necesitas instalarlas, 
# solo saber que están ahí.

# 2. Librerías Externas: Son herramientas especializadas que compras (descargas gratis) 
# para trabajos específicos (una sierra eléctrica o un escáner láser).

# 1. Cómo leer las Librerías "Base"
# R se carga por defecto con paquetes como base, stats, graphics y utils. 
# Para ver qué funciones tienen, no necesitas internet, todo está en tu computadora.

# ¿Cómo saber qué hay dentro? Usa el comando: library(help = "nombre_del_paquete").

# Para ver todas las funciones básicas de R
library(help = "base")

# Para ver las funciones estadísticas (media, mediana, regresiones)
library(help = "stats")

# Para ver qué funciones de gráficos básicos existen
library(help = "graphics")

# ¿Cómo saber de qué librería viene una función?

# A veces verás funciones escritas con dos puntos dobles ::. 
# Esta es la forma más clara de leer código, porque te dice: Paquete :: Función.
# Ejemplo:
stats::median(c(1, 5, 10)) # "De la librería stats, usa la función median"
base::print("Hola")        # "De la librería base, usa la función print"

# La siguiente más básica: El "Tidyverse"
# Si el paquete base es el motor, el Tidyverse es la carrocería de lujo y el GPS. 
# Es la colección de librerías más importante del R moderno. No viene instalada 
# por defecto, así que este es el proceso:
# Al instalar tidyverse, ya viene incluido:
# ggplot2	El estándar para crear gráficos profesionales.
# dplyr	La herramienta para manipular y filtrar tablas.
# tidyr	Para limpiar datos que están en formatos desordenados.
# readr	Para leer archivos (CSV, TXT) de forma mucho más rápida que el base.
# purrr	Para trabajar con funciones de forma avanzada (Nivel 9-10).
#Cómo "leer" la ayuda de una librería nueva
# Cuando instalas una librería como dplyr y quieres aprender a usarla, 
# el comando más útil para "leerla" de arriba a abajo es:
# Abre una página de ayuda con tutoriales (Vignettes)

vignette(package = "dplyr")

# Lee el tutorial principal de esa librería
vignette("dplyr")

# Las vignettes son documentos opacos o tutoriales tipo "guía" 
# que los desarrolladores añaden a sus paquetes para explicar 
# cómo usarlos.



# DESARROLLADOR EN R: DOMINA CUALQUIER LIBRERÍA -------------------------

# Paso 1: El "Rayos X" de la Librería (Nivel Paquete)
# Para obligar a la librería que me diga qué es, utilizar comandos:

help(package = "nombre")
# Es el mapa general. Te abrirá una pestaña con todas las funciones que 
# contiene el paquete con una descripción de una línea.

ls("package:nombre")
# Te da una lista limpia en la consola con todos los nombres de las funciones.
# Es ideal para saber qué palabras clave buscar.

browseVignettes("nombre")
# Es el "manual de usuario". Muchas librerías incluyen guías tipo artículo que
# explican la filosofía del paquete con ejemplos reales.

# Paso 2: Cómo leer el Descriptor de una Función (Nivel Función)
# Al escribir ?nombre_funcion, 
# verás un documento técnico. 
# Para leerlo rápido y sin perderte, busca siempre estas 4 secciones clave en este orden:

# Usage (Uso): Te dice qué argumentos acepta y, lo más importante, cuáles tienen valores por defecto (los que tienen un =). Si un argumento no tiene =, es obligatorio.
# Arguments (Argumentos): Aquí te explica qué tipo de dato espera la función (¿Un número? ¿Una tabla? ¿Un texto?).
# Value (Valor): Esta es la sección más importante y la que todos ignoran. Te dice qué te va a devolver la función (¿Una lista? ¿Un gráfico? ¿Un dataframe?).
# Examples (Ejemplos): Ve directo al final del documento. Ahí siempre hay código que puedes copiar y pegar para ver la función en acción.
# TIP DE ORO: Usa la función args(nombre_funcion) en la consola para ver rápidamente qué parámetros necesita sin abrir toda la ayuda.

# Paso 3: Entender la "Genealogía" de la Librería
# Para dominar la interpretación, debes clasificar la librería apenas la veas. Casi todas caen en una de estas dos familias:

# Familia:Tidy-Style
# Librerías de Ejemplo:dplyr, ggplot2, tidyr
# Cómo interpretarla:Sus funciones son verbos (select, filter). Se leen de izquierda a derecha usando el pipe %>%.

# Familia:Object-Oriented
# Librerías de Ejemplo:stats, base, lme4
# Cómo interpretarla:Se centran en modelos. Suelen usar fórmulas como y ~ x (y en función de x).

# Ejercicio de Dominio: El método ?
# Intentemos "interpretar" la librería ggplot2 de forma ágil:

library(ggplot2)

# 1. ¿Qué funciones tiene?
ls("package:ggplot2") 

# 2. Me da curiosidad 'qplot'. ¿Cómo la interpreto rápido?
?qplot

# 3. Veo los argumentos: qplot(x, y, data, geom...)
# Interpretación rápida: Necesita una x, una y, y una tabla (data).
# El resto (geom, main, xlab) tienen valores por defecto, no son vitales ahora.

# 4. ¿Qué me devuelve (Value)? 
# Dice: "A ggplot object". 
# Conclusión: Puedo seguir sumándole capas con el signo +







# DOMINAR LAS LIBRERÍAS DE BASE -------------------------------------------

# Es un conjunto de 7 librerías fundamentales que se cargan automáticamente.
# No intentes aprender las miles de funciones a la vez. Agrúpalas así:

# Librería: base
# Propósito: La lógica del lenguaje.
# Qué buscar dentro: Tipos de datos, bucles, operadores, print.

# Librería: stats
# Propósito: El cerebro estadístico.
# Qué buscar dentro: Modelos lineales (lm), distribuciones, medias.

# Librería: graphics
# Propósito: El dibujo técnico.
# Qué buscar dentro: plot, hist, abline (gráficos base).

# Librería: utils
# Propósito: La caja de herramientas.
# Qué buscar dentro: Instalar paquetes, leer CSV, head, str.

# Librería: methods
# Propósito: La estructura pro.
# Qué buscar dentro: Definición de clases y objetos complejos.

# Librería: grDevices
# Propósito: Los colores y formatos.
# Qué buscar dentro: Gestión de PDF, PNG y paletas de colores.

# Librería: datasets
# Propósito: El campo de práctica.
# Qué buscar dentro: Datos reales como iris o mtcars para probar.

# # Las "Funciones Madre" que debes memorizar
# Si dominas estas 5 funciones de base, habrás dominado el 80% del uso diario de la terminal:

str()
# Te dice qué es un objeto. Es la función más importante de R.

summary()
# Te da un resumen estadístico (de stats).

apply()
# La madre de la vectorización (para no usar bucles for).

with()
# Te permite trabajar dentro de una tabla sin escribir el nombre de la tabla mil veces.

do.call()
# Para ejecutar una función usando una lista de argumentos (Nivel experto).


# consejo para tu aprendizaje:  
# Las funciones de las librerías Base suelen ser más "crudas" y difíciles de 
# leer (ej: subset(), tapply()). Las librerías del Tidyverse están diseñadas 
# para leerse como inglés (ej: filter(), select(), mutate()).

# OTROS:
# La librería base, es tan antigua, que NO aplica en virnette, entonces usas:

help.start()
# Este es el comando maestro. Abre una página web en tu navegador local con 
# todos los manuales oficiales de R, incluyendo "An Introduction to R" y 
# "The R Language Definition". Es la verdadera "vignette" del lenguaje base.

library(help = "base") 
# Como vimos, te da la lista de todas las funciones.

?Internal 
# Muchas funciones de base llaman a código en C o Fortran. Si ves esto en 
# una ayuda, estás tocando el fondo del motor.

find("rnorm")
# Muestra como salida la librería de esa f(x)

args(rnorm)
# Lectura de la "Firma" (Argumentos)
# Verás: function (n, mean = 0, sd = 1).
# Interpretación ágil: "Solo necesito darle el número de datos (n). Si no le doy mean o sd, usará 0 y 1 por defecto".

?rnorm
# El Escaneo del Descriptor (?rnorm)
# En rnorm, el Value dice: "numeric vector".
# Esta función me entrega una lista de números, así que puedo guardarla en una variable o graficarla directamente.



# Un truco de "Hacker" para la Terminal
# ver el código fuente de cualquier función de base para entender exactamente 
# cómo la programaron los creadores de R, simplemente escribe el nombre de 
# la función sin paréntesis y presiona Enter:
# Escribe esto para ver cómo R calcula la media por dentro

mean.default






# ERRORES EN R ------------------------------------------------------------
# leer los síntomas de un paciente

# 1. El error de los condicionales vacíos
# Este ocurre cuando intentas hacer un if() con algo que no existe o es NULL

Error: argument is of length zero
Error: el argumento es de longitud cero

# Por qué ocurre: Intentaste evaluar una variable que está vacía.
# Ejemplo: x <- numeric(0); if(x == 10) ... (x no tiene ningún valor adentro).

# 2. El error de longitud en el IF
# R Base solo puede evaluar una cosa a la vez dentro de un if.

he condition has length > 1 and only the first element will be used
la condición tiene longitud > 1 y solo el primer elemento será usado

# Por qué ocurre: Pasaste un vector (varios datos) a un if que solo esperaba un valor.
# Solución: Usa any(), all() o cambia a ifelse() (vectorizado).

# 3. El error de "No lo encuentro"
# Es el error más común de todos.

Error: object 'x' not found
Error: objeto 'x' no encontrado

# or qué ocurre: 1. No has creado la variable. 2. Escribiste mal el nombre (Recuerda: Sueldo no es lo mismo que sueldo). 3. No has cargado la librería que contiene esa función.

# 4. El error de los tipos incompatibles
# Intentar hacer matemáticas con letras.

Error: non-numeric argument to binary operator
Error: argumento no numérico para operador binario

# Por qué ocurre: Intentaste sumar, restar o multiplicar algo que R lee como texto ("10" + 5).
# Solución: Usa as.numeric() para convertir el dato.


# 5. El error de dimensiones (Data Frames)
# Muy común al intentar juntar tablas.

Error: replacement has X rows, data has Y
Error: el reemplazo tiene X filas, los datos tienen Y

# Por qué ocurre: Intentas meter una columna de 10 datos en una tabla que tiene solo 5 filas. No encajan.



# CAUSA, EFECTO Y CONDICIONES DE EXISTENCIA -------------------------------



# ==============================================================================
# SISTEMA INTERACTIVO DE EVALUACIÓN CAUSAL EN R
# ==============================================================================


# ==============================================================================
# EVALUACIÓN DE PERFIL CON TODOS LOS OPERADORES LÓGICOS EN R
# ==============================================================================
# ==============================================================================
# EVALUACIÓN INTERACTIVA PASO A PASO EN R
# ==============================================================================

library(dplyr)

ejecutar_evaluacion <- function() {
  cat("=== INGRESO DE DATOS DEL CANDIDATO (R) ===\n\n")
  
  # Cada readline detiene el programa hasta que presionas Enter
  nombre   <- readline(prompt = "1. Ingrese Nombre: ")
  apellido <- readline(prompt = "2. Ingrese Apellido: ")
  edad     <- as.integer(readline(prompt = "3. Ingrese Edad: "))
  exitos   <- as.integer(readline(prompt = "4. Ingrese Número de Éxitos: "))
  fracasos <- as.integer(readline(prompt = "5. Ingrese Número de Fracasos: "))
  
  # --- EVALUACIÓN DE OPERADORES LÓGICOS ---
  c1 <- (edad == 18)        # ==  (Igualdad)
  c2 <- (fracasos != 0)     # !=  (Desigualdad)
  c3 <- (exitos > 5)        # >   (Mayor que)
  c4 <- (fracasos < 3)      # <   (Menor que)
  c5 <- (edad >= 18)        # >=  (Mayor o igual que)
  c6 <- (exitos <= 10)      # <=  (Menor o igual que)
  
  c7 <- c5 && c4            # &&  (Y escalar)
  c8 <- c3 || c2            # ||  (O escalar)
  
  c9 <- !(fracasos > 5)     # !   (Negación)
  c10 <- "a" %in% strsplit(tolower(nombre), "")[[1]] # %in% (Pertenencia)
  
  `%nin%` <- Negate(`%in%`) # Custom operator
  c11 <- "z" %nin% strsplit(tolower(apellido), "")[[1]] # %nin% (No pertenencia)
  
  c12 <- is.null(nombre)    # is.null
  c13 <- is.na(edad)        # is.na
  
  c14 <- all(c(c5, !c12, !c13)) # all()
  c15 <- any(c(c1, c3, c8))     # any()
  
  # Estructuras condicionales
  estatus <- ifelse(exitos > fracasos, "Experto", "Principiante")
  
  if (edad < 18) {
    categoria <- "Menor de edad"
  } else if (edad >= 18 && exitos > 0) {
    categoria <- "Adulto Activo"
  } else {
    categoria <- "Adulto Inactivo"
  }
  
  dictamen_final <- case_when(
    exitos > fracasos & edad >= 18 ~ "Aprobado con Distinción",
    exitos == fracasos             ~ "En Observación",
    fracasos > exitos | edad < 18  ~ "No Elegible",
    TRUE                           ~ "Estado Indeterminado"
  )
  
  # IMPRESIÓN DEL RESULTADO FINAL
  cat("\n==========================================\n")
  cat("=== DICTAMEN FINAL DE EVALUACIÓN (R) ===\n")
  cat("==========================================\n")
  cat("Candidato:", nombre, apellido, "\n")
  cat("Edad:", edad, "| Éxitos:", exitos, "| Fracasos:", fracasos, "\n")
  cat("Estatus:", estatus, "| Categoría:", categoria, "| Dictamen:", dictamen_final, "\n")
}

# --- PARA EJECUTARLO EN LA CONSOLA ---
# Solo llamas a la función:
ejecutar_evaluacion()
