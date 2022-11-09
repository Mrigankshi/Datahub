# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ucsdets/scipy-ml-notebook:2022.3-stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN apt-get update && apt-get install -y \
    htop \
    libopenexr-dev \
    python3 python-dev python3-dev \
    libtbb-dev \
    libjpeg-dev \
    build-essential libssl-dev libffi-dev \
    libxml2-dev libxslt1-dev zlib1g-dev \
    openexr \

# 3) install packages using notebook user
USER jovyan

# RUN conda install -y scikit-learn

RUN pip install --no-cache-dir networkx scipy
RUN pip install git+https://github.com/jamesbowman/openexrpython.git
RUN pip install pyexr

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]
