# Triton UBI9 CUDA Container

This repository helps you set up an environment for **Triton** using a Podman container. It is particularly useful for users who want to run Triton on a **Windows host**, which can be advantageous due to the availability of the most up-to-date Nvidia CUDA drivers for Windows.

## Why?

If you're looking to run **Triton** on a **Windows** machine, this containerized setup is for you. A common reason is the compatibility and latest **Nvidia CUDA drivers** available on Windows, making it easier to work with GPU-accelerated applications like Triton.

## Dependencies

To get started, ensure the following dependencies are installed on your Windows system:

- **Nvidia CUDA Drivers** (for Windows)
- **Podman Desktop** (for Windows, using WSL)

## Setup Instructions

### 1. Install Nvidia Container Toolkit on Your Podman Machine

First, access your Podman virtual machine via SSH and install the Nvidia Container Toolkit.

```bash
podman machine ssh
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo yum install -y nvidia-container-toolkit
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
```

Finally, check if the GPU is detected:

```bash
nvidia-ctk cdi list
```

### 2. Clone the Repository and Build the Image

Next, clone this repository and build the container image. This can take a while.
Note: Adjust the env variable `MAX_JOBS=2` depending on your RAM size.

```bash
git clone git@github.com:fulvius31/triton-ubi9-cuda-container.git
cd triton-ubi9-cuda-container
podman build -t triton-ubi9-container .
```

### 3. Run the Image

After building the image, you can run it using the following command (for nvidia GPUs):

```bash
podman run --privileged -it -d --device nvidia.com/gpu=all triton-ubi9-container /bin/bash
```

Ensure that you have configured Podman to allow access to the GPU.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
