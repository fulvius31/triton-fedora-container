FROM nvcr.io/nvidia/cuda:12.4.1-cudnn-devel-ubi9
RUN dnf update -y && \
    dnf install -y python3-pip python3-devel \
        git vim zlib-devel libxml2-devel gcc g++ \
        cmake ninja-build gcc-c++ make libtool
        
WORKDIR /src
RUN git clone --depth 1 https://github.com/openai/triton.git
WORKDIR /src/triton
RUN pip install ninja cmake wheel pybind11 torch numpy matplotlib pandas

RUN export MAX_JOBS=2 && pip -v install -e ./python --timeout 120
