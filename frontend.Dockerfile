# --- Build Stage ---
FROM node:20 AS build
WORKDIR /app
COPY AI-SupportedPatientTrackingPlatform.UI-main/package*.json ./
RUN npm install
COPY AI-SupportedPatientTrackingPlatform.UI-main/. ./
RUN npm run build -- --configuration production

# --- Nginx Stage ---
FROM nginx:1.27-alpine AS runtime
COPY --from=build /app/dist/patient-tracking-platform /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 