# ==============================================================================
# GUÍA DEFINITIVA DE OOP EN R (NIVELES 1 AL 10)
# ==============================================================================

# ------------------------------------------------------------------------------
# NIVEL 1: ATRIBUTOS Y ESTADO (Creación de la Clase Base)
# ------------------------------------------------------------------------------

# Opción S3 (Informal, basado en una lista con atributo de clase):
persona_s3 <- structure(list(nombre = "Juan", edad = 30), class = "Persona")

# Opción R6 (Formal, requiere la librería R6):
library(R6)

PersonaR6 <- R6Class("PersonaR6",
  public = list(
    nombre = NULL,
    edad = NULL,
    initialize = function(nombre, edad) {
      self$nombre <- nombre
      self$edad <- edad
    }
  )
)

p1 <- PersonaR6$new("Juan", 30)


# ------------------------------------------------------------------------------
# NIVEL 2: MÉTODOS DE INSTANCIA Y "SELF"
# ------------------------------------------------------------------------------

# S3: Definimos una función genérica y luego su método para la clase Persona
saludar <- function(x) UseMethod("saludar")
saludar.Persona <- function(x) {
  cat("Hola, soy", x$nombre, "y tengo", x$edad, "años.\n")
}
saludar(persona_s3)

# R6: El método vive DENTRO de la definición y usa self$
PersonaR6 <- R6Class("PersonaR6",
  public = list(
    nombre = NULL,
    saludar = function() {
      cat("Hola, soy", self$nombre, "desde R6.\n")
    }
  )
)


# ------------------------------------------------------------------------------
# NIVEL 3: HERENCIA (Reutilización de Código)
# ------------------------------------------------------------------------------

# S3: La herencia se logra pasando un vector de clases en orden de jerarquía
empleado_s3 <- structure(
  list(nombre = "Ana", edad = 25, puesto = "Analista"),
  class = c("Empleado", "Persona") # Empleado hereda de Persona
)

# R6: Se usa el argumento 'inherit' de forma explícita
EmpleadoR6 <- R6Class("EmpleadoR6",
  inherit = PersonaR6,
  public = list(
    puesto = NULL,
    initialize = function(nombre, edad, puesto) {
      super$initialize(nombre, edad) # Llama al constructor del Padre
      self$puesto <- puesto
    }
  )
)


# ------------------------------------------------------------------------------
# NIVEL 4: ENCAPSULAMIENTO Y PRIVACIDAD (Public vs Private)
# ------------------------------------------------------------------------------

# S3 no tiene privacidad nativa. En R6 se separan las listas public y private:
CuentaBancaria <- R6Class("CuentaBancaria",
  public = list(
    titular = NULL,
    initialize = function(titular, saldo_inicial) {
      self$titular <- titular
      private$saldo <- saldo_inicial
    },
    ver_saldo = function() {
      cat("Saldo actual:", private$saldo, "\n")
    }
  ),
  private = list(
    saldo = 0 # No se puede acceder desde afuera directamente como obj$saldo
  )
)


# ------------------------------------------------------------------------------
# NIVEL 5: PROPIEDADES GETTERS Y SETTERS (Active Bindings)
# ------------------------------------------------------------------------------

# En R6 se usan 'active' para interceptar la lectura/escritura de propiedades
Producto <- R6Class("Producto",
  private = list(.precio = 0),
  active = list(
    precio = function(val) {
      if (missing(val)) return(private$.precio) # Getter
      if (val < 0) stop("El precio no puede ser negativo") # Setter con validación
      private$.precio <- val
    }
  )
)

prod <- Producto$new()
prod$precio <- 100 # Se asigna como variable, pero ejecuta la validación interna


# ------------------------------------------------------------------------------
# NIVEL 6: SOBRECARGA DE MÉTODOS Y IMPRESIÓN (Print Custom)
# ------------------------------------------------------------------------------

# S3: Personalizamos cómo se imprime el objeto en la consola reemplazando print()
print.Persona <- function(x, ...) {
  cat("=== FICHA DE PERSONA ===\n")
  cat("Nombre:", x$nombre, "| Edad:", x$edad, "\n")
}
print(persona_s3)

# R6: Se define el método 'print' dentro del bloque público
PersonaR6 <- R6Class("PersonaR6",
  public = list(
    nombre = "Carlos",
    print = function(...) {
      cat("<Objeto PersonaR6:", self$nombre, ">\n")
    }
  )
)


# ------------------------------------------------------------------------------
# NIVEL 7: MÉTODOS ESTÁTICOS / FÁBRICAS (Factory Methods)
# ------------------------------------------------------------------------------

# Crear una función constructora "Factory" para instanciar objetos con defaults complejos
crear_usuario_anonimo <- function() {
  structure(
    list(id = sample(1000:9999, 1), rol = "Guest", fecha = Sys.Date()),
    class = "Usuario"
  )
}
user1 <- crear_usuario_anonimo()


# ------------------------------------------------------------------------------
# NIVEL 8: CLASES ABSTRACTAS (Interfaces Preventivas)
# ------------------------------------------------------------------------------

# En S3 forzamos a que las subclases implementen métodos obligatorios lanzando un error
procesar_pago <- function(x) UseMethod("procesar_pago")

procesar_pago.default <- function(x) {
  stop("¡ERROR! Esta clase no implementa el método obligatorio 'procesar_pago'")
}


# ------------------------------------------------------------------------------
# NIVEL 9: COMPORTAMIENTO EN MEMORIA (Copia por Valor vs Referencia)
# ------------------------------------------------------------------------------

# 1. S3 es COPIA EN ESCRITURA (Copy-on-Modify)
a_s3 <- structure(list(val = 10), class = "MiClase")
b_s3 <- a_s3
b_s3$val <- 99 # Cambiar 'b' NO modifica 'a'
# a_s3$val sigue siendo 10

# 2. R6 es MODIFICACIÓN POR REFERENCIA (Estilo Python/Java)
Nodo <- R6Class("Nodo", public = list(val = 10))
a_r6 <- Nodo$new()
b_r6 <- a_r6
b_r6$val <- 99 # ¡Cambiar 'b' SÍ modifica 'a'!
# a_r6$val ahora es 99

# Para duplicar un R6 en memoria sin vincularlo se usa $clone():
c_r6 <- a_r6$clone()


# ------------------------------------------------------------------------------
# NIVEL 10: METAPROGRAMACIÓN E INTROSPECCIÓN (S7 / S3 Inspection)
# ------------------------------------------------------------------------------

# 1. Consultar la jerarquía de un objeto en tiempo de ejecución
class(empleado_s3)              # Retorna: "Empleado" "Persona"
inherits(empleado_s3, "Persona") # Retorna: TRUE

# 2. Inspeccionar qué método S3 se va a ejecutar realmente (S3 Dispatch)
s3_dispatch(saludar(persona_s3))

# 3. El estándar moderno S7 (Librería oficial de la R Foundation/Posit)
# install.packages("S7")
library(S7)

# Definición de una clase formal moderna S7 con tipos de datos estrictos
PersonaS7 <- new_class("PersonaS7",
  properties = list(
    nombre = class_character,
    edad = class_numeric
  )
)

p_s7 <- PersonaS7(nombre = "Elena", edad = 28)