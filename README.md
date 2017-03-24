# natbusa/sysuser-scipy-lab

Built from the `jupyterhub/systemuser` base image.  
see: https://github.com/jupyterhub/dockerspawner/blob/master/systemuser/README.md

This image contains a single user notebook server for use with
[JupyterHub](https://github.com/jupyterhub/jupyterhub). It is a small extension on the jupyterhub/systemuser, setting the necessary parameters for running JupyterLab by default.

This docker image works in combination with the [DockerSpawner](https://github.com/jupyterhub/dockerspawner) and in particular with the
[SystemUserSpawner](https://github.com/jupyterhub/dockerspawner/blob/master/dockerspawner/systemuserspawner.py)
class to launch user notebook servers within docker containers.

In particular, when configuring the jupyter_config.py
set the following:

```
#select the spawner
c.JupyterHub.spawner_class = 'dockerspawner.SystemUserSpawner'

c.DockerSpawner.container_ip = "0.0.0.0"
c.DockerSpawner.volumes = { '/home/{username}':'/home/{username}' }
c.DockerSpawner.remove_containers = True

#docker container start with lab application, from user homedir
c.DockerSpawner.container_image = 'natbusa/sysuser-scipy-lab'

# map the volumes
c.SystemUserSpawner.host_homedir_format_string = '/home/{username}'
```

This particular server initially runs (within the container) as the `root` user.
When the container is run, it expects to have access to environment variables
for `$USER`, `$USER_ID`, and `$HOME`. It will create a user inside the container
with the specified username and id, and then run the notebook server as that
user (using `sudo`). It also expects the user's home directory (specified by
`$HOME`) to exist -- for example, by being mounted as a volume in the container
when it is run.

For an ansible/vagrant setup for this system user jupyter lab configuration check:
https://github.com/natbusa/datalab

## use this image
This image has been uploaded on docker hub as [natbusa/sysuser-scipy-lab]()

## build your own image

Use the command: `docker build .` and modify the `c.DockerSpawner.container_image` in your jupyterhub configuration accordingly.


