FROM docker.io/golang:alpine AS pb
WORKDIR /pb
COPY go.mod go.sum main.go .
RUN go build -o pocketbase

FROM docker.io/node:alpine AS astro
WORKDIR /app
COPY astro.config.mjs package.json package-lock.json .
RUN npm install
COPY public public
COPY src src
RUN npm run build

FROM scratch
WORKDIR /app
COPY --from=pb /pb/pocketbase .
COPY --from=astro /app/dist ./pb_public
ENV GOMEMLIMIT=300MiB
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8090"]