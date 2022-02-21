# Vue-based Frontend for a Todo-API
This application is used for sample deployments in the scope of an [OKD](https://www.okd.io) workshop.

## Running prepared image
```
docker run --rm -p 8000:80 --name todo-web -e VUE_APP_API_BASE_URL=https://localhost:8080/api/v1/todo/ quay.io/johschmidtcc/todo-web
```

## Build and run locally
### initial setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve -- --port 8000
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### Build Docker Image
```
docker build -t todo-web .
```

### Run Docker Container
```
docker run -ti --rm -p 8000:80 --name todo-web -e VUE_APP_API_BASE_URL=http://localhost:8080/api/v1/todo/ todo-web
```
