#!/bin/bash

# --- Configuración ---
# Define los anchos de destino en píxeles
ANCHOS=(200 400 800 1200 1800 2400)

# Formato de salida deseado (ahora WEBP)
FORMATO_SALIDA="webp"

# Calidad de compresión para WEBP (0-100, donde 100 es la mejor calidad/menos compresión)
# Puedes ajustar este valor. 85-90 suele ser un buen equilibrio para web.
CALIDAD_WEBP=70

# --- Lógica del Script ---

# Comprobar si se ha pasado un archivo como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <ruta/a/tu/imagen.ext>"
  echo "Ejemplo: $0 A1C1N00.jpeg" # O A1C1N00.webp si tu original es WEBP
  exit 1
fi

IMAGEN_ORIGEN="$1"

# Comprobar si el archivo de origen existe
if [ ! -f "$IMAGEN_ORIGEN" ]; then
  echo "Error: El archivo '$IMAGEN_ORIGEN' no se encontró."
  exit 1
fi

# Obtener el nombre base del archivo sin extensión
NOMBRE_BASE=$(basename "$IMAGEN_ORIGEN")
NOMBRE_BASE_SIN_EXT="${NOMBRE_BASE%.*}"

echo "Procesando imagen: $IMAGEN_ORIGEN"

# Recorrer cada ancho de destino
for ANCHO in "${ANCHOS[@]}"; do
  NOMBRE_DESTINO="${NOMBRE_BASE_SIN_EXT}-${ANCHO}px.${FORMATO_SALIDA}"
  echo "  Creando: $NOMBRE_DESTINO (Ancho: ${ANCHO}px, Calidad: ${CALIDAD_WEBP})"

  # Comando de ImageMagick para redimensionar y convertir a WEBP con calidad
  convert "$IMAGEN_ORIGEN" -resize "${ANCHO}x" -quality "${CALIDAD_WEBP}" "$NOMBRE_DESTINO"

  if [ $? -ne 0 ]; then
    echo "    ¡Error al crear $NOMBRE_DESTINO!"
  else
    echo "    ¡Creado con éxito!"
  fi
done

echo "Proceso completado para $IMAGEN_ORIGEN."
