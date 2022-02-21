# Vue-based Frontend for a todo app
This application is used for sample deployments in the scope of an [OKD](https://www.okd.io/) workshop.

## Run API server
To run the backend server do one of the following:
* Implement a server based on [OpenAPI spec](https://raw.githubusercontent.com/devshred/todo-api-spring-kotlin/main/src/main/resources/todo-spec.yaml)
* run [sample app based on Spring/Kotlin](https://github.com/devshred/todo-api-spring-kotlin)
* run [sample app based on Quarkus](https://github.com/devshred/todo-api-quarkus)

## Run Frontend
### Running prepared image
```
docker run --rm -p 8000:80 --name todo-web -e VUE_APP_API_BASE_URL=<path-to-api-server>/api/v1/todo/ quay.io/johschmidtcc/todo-web
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
