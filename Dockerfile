# Używamy lekkiego obrazu Node.js jako etap budowania
FROM node:18-alpine AS build

# Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# Kopiujemy pliki package.json i package-lock.json
COPY package*.json ./

# Instalujemy zależności Node.js
RUN npm install

# Kopiujemy resztę plików aplikacji
COPY . .

# Budujemy aplikację na produkcję
RUN npm run build

# Używamy lekkiego obrazu Nginx do serwowania aplikacji
FROM nginx:alpine

# Kopiujemy zbudowaną aplikację do katalogu Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Otwieramy port 80
EXPOSE 80

# Uruchamiamy Nginx w trybie pierwszoplanowym
CMD ["nginx", "-g", "daemon off;"]
