# ==============================================================================
# GUÍA DEFINITIVA DE MACHINE LEARNING EN R (NIVELES 1 AL 10 - TIDYMODELS)
# ==============================================================================
library(tidymodels)

# ------------------------------------------------------------------------------
# NIVEL 1: LA FÓRMULA Y EL MODELO BASE (Estadística Clásica / R Base)
# ------------------------------------------------------------------------------
# La sintaxis de fórmula 'y ~ x' define la variable objetivo y los predictores.
data(diamonds)

# Modelo de Regresión Lineal Clásica
fit_base <- lm(price ~ carat + cut, data = diamonds)
summary(fit_base)


# ------------------------------------------------------------------------------
# NIVEL 2: DIVISIÓN DE DATOS (Data Splitting & Stratification)
# ------------------------------------------------------------------------------
# Separar de forma reproducible en Entrenamiento (Train) y Prueba (Test).
set.seed(123)
data_split <- initial_split(diamonds, prop = 0.80, strata = price)

train_data <- training(data_split)
test_data  <- testing(data_split)


# ------------------------------------------------------------------------------
# NIVEL 3: INGENIERÍA DE CARACTERÍSTICAS (Preprocesamiento con recipes)
# ------------------------------------------------------------------------------
# Las 'recipes' definen las transformaciones sin ejecutar cálculos aún.
recipe_diamonds <- recipe(price ~ carat + cut + clarity + color, data = train_data) %>%
  step_log(price, carat, base = 10) %>%    # Normalización logarítmica
  step_dummy(all_nominal_predictors()) %>% # Variables One-Hot Encoding
  step_normalize(all_numeric_predictors())  # Escalar media 0 y varianza 1


# ------------------------------------------------------------------------------
# NIVEL 4: ESPECIFICACIÓN DEL MODELO (parsnip)
# ------------------------------------------------------------------------------
# Se separa el algoritmo de la librería que lo ejecuta (engine).
rf_spec <- rand_forest(trees = 500, mode = "regression") %>%
  set_engine("ranger") # 'ranger' es una implementación rápida en C++ para Random Forest


# ------------------------------------------------------------------------------
# NIVEL 5: WORKFLOWS (Empaquetar Receta + Modelo)
# ------------------------------------------------------------------------------
# El workflow evita la fuga de datos (data leakage) entre Train y Test.
wf_diamonds <- workflow() %>%
  add_recipe(recipe_diamonds) %>%
  add_model(rf_spec)

# Entrenar el flujo completo
fit_workflow <- fit(wf_diamonds, data = train_data)


# ------------------------------------------------------------------------------
# NIVEL 6: EVALUACIÓN Y MÉTRICAS EN TEST SET (yardstick)
# ------------------------------------------------------------------------------
# Predecir en datos no vistos y evaluar métricas de rendimiento.
preds <- predict(fit_workflow, new_data = test_data) %>%
  bind_cols(test_data)

# Evaluar RMSE y R^2
metrics(preds, truth = price, estimate = .pred)


# ------------------------------------------------------------------------------
# NIVEL 7: VALIDACIÓN CRUZADA (Resampling / Cross-Validation)
# ------------------------------------------------------------------------------
# Divide el set de entrenamiento en K-Folds para estimar la estabilidad del modelo.
set.seed(123)
folds <- vfold_cv(train_data, v = 5, strata = price)

cv_results <- fit_resamples(
  wf_diamonds,
  resamples = folds,
  metrics = metric_set(rmse, rsq, mae)
)

collect_metrics(cv_results)


# ------------------------------------------------------------------------------
# NIVEL 8:OPTIMIZACIÓN DE HIPERPARÁMETROS (Hyperparameter Tuning)
# ------------------------------------------------------------------------------
# Marcamos los parámetros con tune() para encontrar su valor óptimo en una grilla.
rf_tune_spec <- rand_forest(
  mtry = tune(),
  min_n = tune(),
  trees = 500
) %>%
  set_engine("ranger") %>%
  set_mode("regression")

wf_tune <- wf_diamonds %>% update_model(rf_tune_spec)

# Crear grilla aleatoria de prueba
set.seed(123)
tune_results <- tune_grid(
  wf_tune,
  resamples = folds,
  grid = 10
)

best_params <- select_best(tune_results, metric = "rmse")


# ------------------------------------------------------------------------------
# NIVEL 9: AJUSTE FINAL Y ENSAMBLES (Last Fit & Stacking)
# ------------------------------------------------------------------------------
# 'last_fit' entrena con TODO el Train usando los mejores parámetros y evalúa en Test.
final_wf <- finalize_workflow(wf_tune, best_params)
final_fit <- last_fit(final_wf, data_split)

# Métricas finales de producción
collect_metrics(final_fit)


# ------------------------------------------------------------------------------
# NIVEL 10: EXPLICABILIDAD Y SERVIABILIDAD (VIP & vetiver)
# ------------------------------------------------------------------------------
library(vip)
library(vetiver)

# 1. Importancia de Variables (Feature Importance / Explicabilidad)
final_wf_fit <- extract_workflow(final_fit)
final_wf_fit %>%
  extract_fit_parsnip() %>%
  vip(geom = "point")

# 2. Despliegue/Model Serving (Convertir el modelo R en un contrato listo para API)
v <- vetiver_model(final_wf_fit, "modelo_precios_diamantes")
# plumber::pr() %>% vetiver_api(v) # Despliega una API REST local automática