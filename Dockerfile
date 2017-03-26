# Build as natbusa/sysuser-scipy-lab
# Run with the DockerSpawner in JupyterHub

FROM jupyter/datascience-notebook

MAINTAINER Natalino Busa <natalino.busa@gmail.com>

USER root

# delete the default user, create the user while starting jupyterhub-singleuser via the CMD script
RUN userdel jovyan && rm -rf /home/jovyan
ADD systemuserlab.sh /srv/singleuser/systemuserlab.sh

# smoke test entrypoint
RUN USER_ID=65000 USER=systemusertest sh /srv/singleuser/systemuserlab.sh -h && userdel systemusertest

CMD ["sh", "/srv/singleuser/systemuserlab.sh"]
