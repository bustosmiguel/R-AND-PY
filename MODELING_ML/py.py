# ==============================================================================
# GUÍA DEFINITIVA DE MACHINE LEARNING EN PYTHON (NIVELES 1 AL 10)
# ==============================================================================

import pandas as pd
import numpy as np
from sklearn.datasets import fetch_california_housing

# Carga de datos base para los ejemplos
data = fetch_california_housing(as_frame=True)
X = data.data
y = data.target


# ------------------------------------------------------------------------------
# NIVEL 1: EL MODELO BASE Y LA SINTAXIS FIT / PREDICT
# ------------------------------------------------------------------------------
# La interfaz unificada de Scikit-Learn se basa en .fit() y .predict().
from sklearn.linear_model import LinearRegression

model_base = LinearRegression()
model_base.fit(X, y) # Entrenamiento
preds_base = model_base.predict(X) # Predicción


# ------------------------------------------------------------------------------
# NIVEL 2: DIVISIÓN DE DATOS (Train / Test Split)
# ------------------------------------------------------------------------------
# Separación reproducible para evitar la memorización y evaluar la generalización.
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.20, random_state=123
)


# ------------------------------------------------------------------------------
# NIVEL 3: INGENIERÍA DE CARACTERÍSTICAS (Transformers & Preprocessing)
# ------------------------------------------------------------------------------
# Limpieza, imputación de valores nulos y escalado de variables.
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.impute import SimpleImputer

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test) # OJO: Solo transform en Test para evitar Data Leakage


# ------------------------------------------------------------------------------
# NIVEL 4: PREPROCESAMIENTO POR TIPO DE COLUMNA (ColumnTransformer)
# ------------------------------------------------------------------------------
# Aplica transformaciones distintas a columnas numéricas y categóricas.
from sklearn.compose import ColumnTransformer

num_cols = X.select_dtypes(include=['float64', 'int64']).columns

preprocessor = ColumnTransformer(
    transformers=[
        ('num', StandardScaler(), num_cols)
    ]
)


# ------------------------------------------------------------------------------
# NIVEL 5: PIPELINES (Empaquetado de Preprocesamiento + Algoritmo)
# ------------------------------------------------------------------------------
# Unifica la transformación de datos y el modelo en un solo objeto reutilizable.
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestRegressor

pipeline = Pipeline(steps=[
    ('prep', preprocessor),
    ('model', RandomForestRegressor(n_estimators=100, random_state=123))
])

pipeline.fit(X_train, y_train)


# ------------------------------------------------------------------------------
# NIVEL 6: EVALUACIÓN Y MÉTRICAS
# ------------------------------------------------------------------------------
# Evaluación en el conjunto de prueba usando métricas estándar.
from sklearn.metrics import mean_squared_error, r2_score

y_pred = pipeline.predict(X_test)

rmse = np.sqrt(mean_squared_error(y_test, y_pred))
r2 = r2_score(y_test, y_pred)
print(f"RMSE: {rmse:.4f} | R2: {r2:.4f}")


# ------------------------------------------------------------------------------
# NIVEL 7: VALIDACIÓN CRUZADA (Cross-Validation)
# ------------------------------------------------------------------------------
# Mide la estabilidad del modelo dividiendo el set de entrenamiento en K-Folds.
from sklearn.model_selection import cross_val_score

scores = cross_val_score(
    pipeline, X_train, y_train, cv=5, scoring='neg_root_mean_squared_error'
)

print(f"CV RMSE Promedio: {-scores.mean():.4f}")


# ------------------------------------------------------------------------------
# NIVEL 8: OPTIMIZACIÓN DE HIPERPARÁMETROS (GridSearch & RandomizedSearch)
# ------------------------------------------------------------------------------
# Búsqueda automatizada de las mejores combinaciones de parámetros.
from sklearn.model_selection import RandomizedSearchCV

param_grid = {
    'model__n_estimators': [50, 100, 200],
    'model__max_depth': [None, 10, 20],
    'model__min_samples_split': [2, 5]
}

search = RandomizedSearchCV(
    pipeline, param_distributions=param_grid, n_iter=5, cv=3, random_state=123
)
search.fit(X_train, y_train)

best_model = search.best_estimator_


# ------------------------------------------------------------------------------
# NIVEL 9: ALGORITMOS AVANZADOS / GRADIENT BOOSTING (LightGBM / XGBoost)
# ------------------------------------------------------------------------------
# Uso de algoritmos basados en árboles de decisión optimizados para producción.
import lightgbm as lgb

lgb_pipeline = Pipeline(steps=[
    ('prep', preprocessor),
    ('model', lgb.LGBMRegressor(random_state=123, verbose=-1))
])

lgb_pipeline.fit(X_train, y_train)


# ------------------------------------------------------------------------------
# NIVEL 10: EXPLICABILIDAD Y SERIALIZACIÓN (SHAP & Joblib)
# ------------------------------------------------------------------------------
import joblib
import shap

# 1. Serialización del modelo para Producción (Guardar en disco)
joblib.dump(best_model, 'modelo_bienes_raices.pkl')

# Cargar en producción:
# modelo_servidor = joblib.load('modelo_bienes_raices.pkl')

# 2. Explicabilidad con Valores SHAP (Interpretabilidad de Caja Negra)
X_test_prep = preprocessor.transform(X_test)
explainer = shap.Explainer(lgb_pipeline.named_steps['model'])
shap_values = explainer(X_test_prep)

# Visualización de contribución de características (descomentar en entorno interactivo)
# shap.summary_plot(shap_values, X_test)