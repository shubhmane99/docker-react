# this is for production environment in this we will setup multi step builds

FROM node:14-alpine as builder

WORKDIR '/app' 
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# copy build folder to nginx container
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html 

# docker run -p 8080:80 ffcdee4eb72f