# qt-wasm 
![Docker Image CI](https://github.com/guerinoni/qt-wasm/workflows/Docker%20Image%20CI/badge.svg)
![GitHub Container Registry](https://github.com/guerinoni/qt-wasm/workflows/GitHub%20Container%20Registry/badge.svg)

Docker image for Qt WebAssembly

## Build
```
- clone repository
- cd qt-wasm
- docker build -t qtwa .
```

## Create container

Example that create container with name webassembly from image with name qtwa binding port 8080 of the host machine with 30000 of container and bind local folder with home folder of container
```
docker run -it -p 8080:30000 -v <project_dir>:/home --name webassembly qtwa
```

## Usage

Inside docker container
```
cd <project_dir>
mkdir build
cd build
qmake ..
make
emrun --no_browser --port 30000 <project_name>.html
```
Open your host browser and go to `localhost:8080/<project_name>.html`.
