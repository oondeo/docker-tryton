#!/bin/sh

/usr/local/sbin/sshconfig $*

exec /usr/sbin/sshd -f $HOME/.ssh/sshd_config -D -e
