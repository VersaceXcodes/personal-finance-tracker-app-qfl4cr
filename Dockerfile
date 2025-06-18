FROM node:18 as frontend-build

WORKDIR /app/vitereact

COPY vitereact/package.json  ./
RUN npm install --legacy-peer-deps

RUN npm install --save-dev eslint-plugin-import eslint-plugin-react @typescript-eslint/parser @typescript-eslint/eslint-plugin
RUN npm install --save-dev eslint-import-resolver-typescript

COPY vitereact ./
RUN npm run build

FROM node:18 as backend

WORKDIR /app/backend

COPY backend/package.json  ./
RUN npm install --production

COPY backend ./
# Copy the frontend build files to the backend's public directory
COPY --from=frontend-build /app/vitereact/dist/ ./public/

EXPOSE 8080
CMD ["node", "server.js"]