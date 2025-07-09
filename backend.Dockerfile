# --- Build Stage ---
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY AI-SupportedPatientTrackingPlatform.Back-main/src/ ./src/
WORKDIR /app/src/PatientTrackingPlatform.API
RUN dotnet restore
RUN dotnet publish -c Release -o out

# --- Runtime Stage ---
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser
COPY --from=build /app/src/PatientTrackingPlatform.API/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "PatientTrackingPlatform.API.dll"] 
