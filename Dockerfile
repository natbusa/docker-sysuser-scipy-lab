# Build as natbusa/sysuser-scipy-lab
# Run with the DockerSpawner in JupyterHub

FROM jupyter/scipy-notebook

MAINTAINER Natalino Busa <natalino.busa@gmail.com>

USER root

EXPOSE 8888

# fetch juptyerhub-singleuser entrypoint
RUN wget -q https://raw.githubusercontent.com/jupyterhub/jupyterhub/0.6.1/scripts/jupyterhub-singleuser -O /usr/local/bin/jupyterhub-singleuser && \
    chmod 755 /usr/local/bin/jupyterhub-singleuser

# Install jupyterlab
RUN conda install -c conda-forge --quiet --yes jupyterlab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

#delete the default user, create the user while starting jupyterhub-singleuser via the CMD script
RUN userdel jovyan && rm -rf /home/jovyan
ADD systemuserlab.sh /srv/singleuser/systemuserlab.sh

# smoke test entrypoint
RUN USER_ID=65000 USER=systemusertest sh /srv/singleuser/systemuserlab.sh -h && userdel systemusertest

CMD ["sh", "/srv/singleuser/systemuserlab.sh"]
