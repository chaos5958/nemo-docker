# our local base image
FROM tensorflow/tensorflow:1.15.5-gpu-py3

LABEL description="Container for use with NEMO"
ENV NEMO_CODE_ROOT /workspace/nemo
ENV NEMO_DATA_ROOT /workspace/nemo-data
ENV SNPE_ROOT $NEMO_CODE_ROOT/third_party/snpe
ENV PYTHONPATH  $NEMO_CODE_ROOT:$SNPE_ROOT/lib/python:$PYTHONPATH
WORKDIR /workspace
SHELL ["/bin/bash", "-c"]

# install packages
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
        libglib2.0-0 libxext6 libsm6 libxrender1 \
        git mercurial subversion \
        ffmpeg vim tmux

# install anaconda
ENV PATH /opt/conda/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh -O ~/anaconda.sh && \
        /bin/bash ~/anaconda.sh -b -p /opt/conda && \
        rm ~/anaconda.sh && \
        ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
        echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
        conda update conda && \
        conda update anaconda && \
        conda update --all && \
        echo "conda activate base" >> ~/.bashrc

# create conda environments
RUN conda create -n nemo_py3.6 python=3.6 imageio tensorflow-gpu==1.15
RUN conda create -n nemo_py3.5 python=3.5 imageio

# install awesomevim
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
    sh ~/.vim_runtime/install_awesome_vimrc.sh && \
    echo "stty -ixon" >> ~/.bashrc

# install youtube-dl
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
