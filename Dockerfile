FROM    ubuntu:20.04
LABEL   maintainer="guerinoni.federico@gmail.com"

RUN     apt update && DEBIAN_FRONTEND="noninteractive" TZ="America/Los_Angeles" apt -qq install -y --no-install-recommends    \
        git                                                         \
        cmake                                                       \
        wget                                                        \
        ca-certificates                                             \
        build-essential                                             \
        python

RUN     git clone https://github.com/emscripten-core/emsdk.git 	&& \
        cd emsdk                                                && \
        git pull                                                && \
        git checkout 1.39.8                                     && \
        ./emsdk install 1.39.8                                  && \
        ./emsdk activate 1.39.8                                 && \
        ./emsdk construct_env > /dev/null                       && \
        sed -i -e "/EM_CACHE/d" emsdk_set_env.sh

RUN     wget -c https://download.qt.io/archive/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz
RUN     tar -xvf qt-everywhere-src-5.15.2.tar.xz

WORKDIR /qt-everywhere-src-5.15.2

ENV     PATH "/emsdk:/emsdk/upstream/emscripten:/emsdk/node/12.9.1_64bit/bin:$PATH"
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
RUN     make -j$(nproc)

ENV     PATH "/qt-everywhere-src-5.15.2/qtbase/bin/:$PATH"

WORKDIR /home

CMD     [ "bash" ]
