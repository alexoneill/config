# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 0002

# Source all the files in the extra's folder
for file in $HOME/.bashrc.d/*
do
  [ -f $file ] && [ -x $file ] && source $file
done
