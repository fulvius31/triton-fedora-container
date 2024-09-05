FROM fedora:40
RUN dnf update -y && \
    dnf install -y python3-pip python3-devel \
        git vim zlib-devel libxml2-devel gcc g++ \
        cmake \
        ninja-build \
        gcc-c++ \
        boost-devel \
        python3-devel \
        make \
        libtool \
        curl

WORKDIR /src
RUN git clone --depth 1 https://github.com/openai/triton.git
WORKDIR /src/triton
RUN pip install ninja cmake wheel pybind11

RUN export MAX_JOBS=2 && pip -v install ./python --timeout 120
