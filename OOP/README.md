0 Niveles para dominar la Programación Orientada a Objetos (OOP) comparando R y Python.

Diferencia conceptual clave:

Python usa un sistema Encapsulado (basado en clases tradicionales como Java o C++, donde las funciones viven dentro del objeto).

R históricamente usa un sistema de Sistemas Funcionales (S3/S4: las funciones son genéricas y viven fuera de la clase), aunque desde la librería R6 (y el sistema nativo S7) ya adopta la OOP encapsulada.

Nivel 1: Atributos y Estado (La Clase Base)
Crea una clase vacía o simple y asígnale datos internos (propiedades).

Python: Sintaxis class Persona: con la función constructora __init__(self, nombre).

R (S3 / R6):

En S3: Creación informal mediante una lista normal a la que le asignas una clase (structure(list(nombre = "Juan"), class = "Persona")).

En R6: Creación de una clase formal con R6Class("Persona", public = list(nombre = NULL)).

Nivel 2: Métodos de Instancia y el "Self"
Aprende a definir funciones que operan sobre los datos del propio objeto.

Python: Métodos con el parámetro explícito self (ej. def saludar(self): print(self.nombre)).

R (S3 / R6):

En S3: Definición de una función genérica (saludar <- function(x) UseMethod("saludar")) y su método específico (saludar.Persona <- function(x) ...).

En R6: Definición del método dentro de la lista public = list(saludar = function() self$nombre).

Nivel 3: Herencia (Reutilización de Código)
Una clase "hija" hereda atributos y métodos de una clase "padre".

Python: Sintaxis directa class Empleado(Persona): y llamadas al padre con super().__init__().

R (S3 / R6):

En S3: Herencia por asignación de múltiples clases en un vector: class(objeto) <- c("Empleado", "Persona").

En R6: Sintaxis explícita R6Class("Empleado", inherit = Persona).

Nivel 4: Encapsulamiento y Privacidad (Public vs Private)
Protege atributos sensibles para que no sean modificados directamente desde afuera.

Python: Convención de privacidad usando un guion bajo _atributo (protegido) o doble guion __atributo (privado/mangling).

R (S3 / R6):

En S3: No existe la privacidad nativa; todo el contenido de la lista es accesible.

En R6: Soporte nativo separando en bloques public = list(...) y private = list(...) (se accede internamente mediante private$clave).

Nivel 5: Propiedades Getters y Setters (Validación de Datos)
Controla cómo se leen y escriben las propiedades de un objeto mediante validadores.

Python: Decoradores elegantes @property (getter) y @atributo.setter para validar asignaciones sin romper la sintaxis.

R (S3 / R6):

En S4: Definición formal de la validez mediante setValidity().

En R6: Propiedades Active Binding mediante el bloque active = list(edad = function(val) ...) que intercepta lecturas y escrituras.

Nivel 6: Métodos Mágicos y Sobrecarga de Operadores
Define cómo se comportan los objetos cuando los sumas (+), imprimes o comparas.

Python: Métodos especiales dunder (double underscore) como __str__, __repr__, __add__, __eq__.

R (S3 / R6):

En S3: Sobrecarga de funciones genéricas de R base como print.Persona(), summary.Persona() o el grupo de métodos Ops.Persona.

En R6: Definición de métodos especiales como format() o clone().

Nivel 7: Métodos de Clase y Métodos Estáticos (Factory Patterns)
Funciones asociadas a la "plantilla" de la clase y no a una instancia/objeto en particular.

Python: Decoradores @classmethod (recibe cls) y @staticmethod (función aislada dentro del espacio de la clase).

R (S3 / R6):

En R6: Uso del bloque portable = TRUE o generadores mediante funciones externas que actúan como "fabricas" de instancias.

En S7: Definición de constructores personalizados.

Nivel 8: Clases Abstractas e Interfaces
Crea plantillas para forzar a que las subclases implementen ciertos métodos obligatorios.

Python: Módulo nativo abc usando el decorador @abstractmethod dentro de una clase que hereda de ABC.

R (S3 / S4):

En S4: Uso de clases virtuales con setClassUnion() o setGeneric() para definir interfaces sin código de ejecución.

En S3: Lanzar un error preventivo en la función base stop("El método debe ser implementado").

Nivel 9: Composición y Modificabilidad (Copias por Valor vs Referencia)
Entiende cómo se comportan los objetos en memoria al asignarlos o duplicarlos.

Python: Referencia por defecto (a = b no copia el objeto). Uso del módulo copy (copy.deepcopy()) para clonar estructuras complejas.

R (S3 / S4 / R6):

S3 / S4: Copia en escritura (Copy-on-Modify). Si modificas el objeto dentro de una función, R crea una copia limpia de forma transparente.

R6: Funciona estrictamente por referencia (al estilo Python/Java). Para clonarlo en memoria debes usar explícitamente objeto$clone().

Nivel 10: Metaprogramación, Introspección y Marcos Modernos
Analiza o modifica clases en tiempo de ejecución y usa los estándares de desarrollo actuales.

Python:

Uso de type(), isinstance(), getattr() / setattr().

Uso avanzado de dataclasses y la librería Pydantic para validar tipos de datos automáticamente.

R:

Uso de funciones de introspección: inherits(), is(), s3_dispatch().

Dominio del nuevo estándar oficial unificado de R: S7 (el sistema moderno respaldado por la R Foundation y Posit que unifica S3 y S4).