FROM mawall/ubuntu20.04_base

RUN conda install -c conda-forge jupyterlab \
    nodejs \
    xeus-cling

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter lab build && \
    unset NODE_OPTIONS

# Configure jupyter lab for remote access
# TODO: Secure server - https://jupyter-notebook.readthedocs.io/en/stable/public_server.html
RUN jupyter notebook --generate-config && \
    echo "c.NotebookApp.ip = '*'\nc.NotebookApp.port = 9999\n" > /root/.jupyter/jupyter_notebook_config.py

RUN mkdir /notebooks && mkdir /data && mkdir /project

CMD ["sh", "-c", "jupyter lab --allow-root --ip=${HOST_IP} --NotebookApp.iopub_data_rate_limit=10000000000"]
