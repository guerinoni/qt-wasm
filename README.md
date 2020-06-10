# qt-wasm ![Docker Image CI](https://github.com/guerinoni/qt-wasm/workflows/Docker%20Image%20CI/badge.svg)
Docker image for Qt WebAssembly

## Build
```
- clone repository
- cd qt-wasm
- docker build -t qtwa .
```

## Create container

Example that create container with name webassembly from image with name qtwa binding port 8080 of the host machine with 8080 of container and bind local folder with src folder of container
```
docker run -it -p 8080:80 -v $(pwd):/home --name webassembly qtwa
```
