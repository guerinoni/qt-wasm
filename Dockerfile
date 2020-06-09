FROM    ubuntu:18.04

RUN     apt update && apt -qq install -y --no-install-recommends    \
        git                                                         \
        cmake                                                       \
        wget                                                        \
        ca-certificates                                             \
        build-essential                                             \
        python

RUN     git clone https://github.com/emscripten-core/emsdk.git 	&& \
        cd emsdk                                                    && \
        git pull                                                    && \
        git checkout 1.39.8                                         && \
        ./emsdk install 1.39.8                                      && \
        ./emsdk activate 1.39.8                                     && \
        ./emsdk construct_env > /dev/null                           && \
        sed -i -e "/EM_CACHE/d" emsdk_set_env.sh

RUN     wget -c https://download.qt.io/archive/qt/5.15/5.15.0/single/qt-everywhere-src-5.15.0.tar.xz
RUN     tar -xvf qt-everywhere-src-5.15.0.tar.xz

WORKDIR /qt-everywhere-src-5.15.0

ENV     PATH "/emsdk:/emsdk/upstream/emscripten:/emsdk/node/12.9.1_64bit/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV     EMSDK "/emsdk"
ENV     EM_CONFIG "/root/.emscripten"
ENV     EMSDK_NODE "/emsdk/node/12.9.1_64bit/bin/node"

RUN     ./configure                 \
        -xplatform wasm-emscripten  \
        -nomake examples            \
        -nomake tests               \
        -opensource                 \
        -prefix $PWD/qtbase         \
        --confirm-license
RUN     make

EXPOSE  80

WORKDIR /home

CMD     [ "bash" ]
