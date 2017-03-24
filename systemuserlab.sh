#!/bin/sh

sh /srv/singleuser/systemuser.sh \
  --SingleUserNotebookApp.default_url=/lab \
  --SingleUserNotebookApp.disable_user_config=True \
  $@