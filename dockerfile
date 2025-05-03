# Etapa 1: build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copiar archivos de solución y proyectos
COPY . . 

# Restaurar dependencias
RUN dotnet restore Chess.sln

# Compilar el proyecto (ajusta el nombre si tu .csproj de consola es diferente)
RUN dotnet publish Applications/ChessClient/ChessClient.csproj -c Release -o /app/publish

# Etapa 2: runtime
FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app

# Copiar archivos publicados
COPY --from=build /app/publish .

# Comando para ejecutar la app
ENTRYPOINT ["dotnet", "ChessClient.dll"]
