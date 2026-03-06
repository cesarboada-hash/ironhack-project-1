# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY Worker.csproj .
RUN dotnet restore

# Copy the rest of the source code and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/publish ./

# Set environment variables (can be overridden at runtime)
ENV DB_HOST=db
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=postgres
ENV DB_NAME=postgres
ENV REDIS_HOST=redis

# Define the entry point
ENTRYPOINT ["dotnet", "Worker.dll"]

# Usa una imagen base ligera con Python
FROM python:3.11-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia requirements primero (para cachear dependencias)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el código de la app
COPY . .

# Expone el puerto interno (Gunicorn escucha en 80)
EXPOSE 80

# Comando para ejecutar la app con Gunicorn (4 workers, puerto 80)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:80", "app:app"]