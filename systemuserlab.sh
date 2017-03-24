#!/bin/sh

sh /srv/singleuser/systemuser.sh \
  --SingleUserNotebookApp.default_url=/lab \
  --SingleUserNotebookApp.notebook_dir=/home/{username} \
  --SingleUserNotebookApp.disable_user_config=True \
  $@