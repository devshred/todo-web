# todo-web

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### Build Docker Image
```
docker build -t todo-web .
```

### Run Docker Container
```
docker run -ti --rm -p 8080:80 --name todo-web -e VUE_APP_API_BASE_URL=http://localhost:7001/api/v1/todo/ todo-web
```
