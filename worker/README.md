# Worker Service (.NET)

## Description
Servicio worker que procesa los votos de la base de datos.

## Docker Image
- **DockerHub**: gerardogm/worker:latest
- **Technology**: .NET 7
- **Multi-stage build**: Sí

## Build image
```bash
docker build -t gerardogm/worker:latest .
```

## Execute
```bash
docker run gerardogm/worker:latest
```

## Developed by
Gerardo
