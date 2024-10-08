# Usamos una imagen base con Java 21
FROM openjdk:21-jdk-slim

# Creamos un usuario no root para mayor seguridad
RUN useradd -m -u 1000 minecraft

# Establecemos el directorio de trabajo
WORKDIR /minecraft

# Instalamos git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Copiamos los archivos a un directorio temporal
COPY . /tmp/minecraft

# Cambiamos el propietario de los archivos en el directorio temporal
RUN chown -R minecraft:minecraft /tmp/minecraft

# Movemos los archivos al directorio de trabajo final y eliminamos el temporal
RUN mv /tmp/minecraft/* /minecraft && rm -r /tmp/minecraft

# Cambiamos al usuario 'minecraft'
USER minecraft

# Exponemos el puerto 25565 para conexiones
EXPOSE 25565

# Comando para ejecutar el script run.sh
CMD ["sh", "./run.sh"]
