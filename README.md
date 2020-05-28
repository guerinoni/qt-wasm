# qt-wasm
Docker image for Qt WebAssembly 

## Build
```
- clone repository
- cd qt-wasm
- docker build -t <name_of_image> .
```

## Create container

Example that create container with name webassembly from image with name qtwa binding port 8080 of the host machine with 8080 of container and bind local folder with src folder of container
```
docker run -it -p 8080:8080 -v $(pwd):/src --name webassembly qtwa
```
