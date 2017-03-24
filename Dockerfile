# Build as natbusa/sysuser-scipy-lab
# Run with the DockerSpawner in JupyterHub

FROM jupyterhub/systemuser

MAINTAINER Natalino Busa <natalino.busa@gmail.com>

USER root

# Install jupyterlab
RUN conda install -c conda-forge jupyterlab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

ADD systemuserlab.sh /srv/singleuser/systemuserlab.sh
# smoke test entrypoint
RUN USER_ID=65000 USER=systemusertest sh /srv/singleuser/systemuserlab.sh -h && userdel systemusertest

CMD ["sh", "/srv/singleuser/systemuserlab.sh"]
