FROM tensorflow/tensorflow:2.0.0-gpu-py3-jupyter

ENV PATH /opt/conda/bin:$PATH
RUN apt-get install -y --no-install-recommends wget
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
        chmod a+rwx ~/miniconda.sh 
RUN ~/miniconda.sh -b -p /opt/conda
RUN rm ~/miniconda.sh
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc
RUN echo "conda activate base" >> /etc/bash.bashrc
RUN conda init bash
RUN pip install jupyter matplotlib tensorflow-gpu pandas scipy 
RUN pip install jupyter_http_over_ws
RUN jupyter serverextension enable --py jupyter_http_over_ws


SHELL ["/bin/bash", "-c"]
CMD ["bash", "-c", "source /etc/bash.bashrc && conda activate base && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]