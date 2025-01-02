FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04
ARG PYTHON_VERSION=3.10
ARG VENV_NAME=OGBENCH
# Use bash as a default shell.
SHELL ["/bin/bash", "-c"]

# Install misc.
RUN apt-get update \
    && apt-get install -y vim bzip2 wget ssh unzip git iproute2 iputils-ping build-essential curl \
    cmake ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 tmux libpoco-dev libeigen3-dev libspdlog-dev

# miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_23.1.0-1-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# clone ogbench
RUN  git clone git@github.com:JisuHann/ogbench.git \
    && cd ogbench
    && /opt/conda/condabin/conda env export > environment.yml