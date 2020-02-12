#!/bin/bash
# This script makes a backup of a directory to another server.
# Invocation:  ./backup.sh DIRNAME
#
# You must edit the set_variables() function to define the variables
# REMOTEID (your VT email PID) and REMOTEDIR (the path to your home
# directory on rlogin).

#################################################### fn definitions
show_usage() {
   echo "Invocation:  ./backup.sh DIRNAME"
}

get_directory_name() {         # param1: fully-qualified name of dir to backup
   P1=$1
   DIRNAME=${P1##*/}           # HERE BE DRAGONS!
}

set_variables() {
   # Change the values of the variables to make the script work for you:
   TARFILE=/var/tmp/$DIRNAME.tar      # tar file created during backup
   SERVER=rlogin.cs.vt.edu            # server to copy backup to
   REMOTEID=YOURPIDHERE               # your ID on that server
   REMOTEDIR=YOURHOMEDIRHERE          # dir to hold  backup on server
   LOGFILE=~/logs/backup.log          # local log file recording backups
}

create_archive() {             # param1: fully-qualified name of dir to backup
                               # param2: name for tar file
   # Move into the directory to be backed up
   cd $1

   # Run tar to create the archive.
   echo "Creating archive file $2"
   tar cf $2 *
   if [[ $? -ne 0 ]]; then
      echo "Error: tar returned error code $?"
      exit 3                # terminates script
   fi
}

copy_to_server() {          # param1: fully-qualified name of tar file
                            # param2: user name on server
                            # param3: network name of server
                            # param4: destination dir on server
   # Copy the file to another host.
   echo "Copying $1 to $3:$4"
   scp $1 $2@$3:$4
   if [[ $? -ne 0 ]]; then
      echo "Error: scp returned error code $?"
      exit 4                # terminates script
   fi
}

rm_archive() {              # param1: full-qualified name of tar file

   echo "Removing archive file $1"
   rm -f $1
   if [[ $? -ne 0 ]]; then
      echo "Error: rm returned error code $?"
      exit 4                # terminates script
   fi
}

log_backup() {
   echo "$1:  `date`" >> $2
}

#################################################### body of script

if [[ $# -ne 1 ]]; then   # check for a parameter
   show_usage
   exit 1
fi

if [[ ! -d $1 ]]; then    # see if it's a directory
   echo "$1 is not a directory"
   exit 2
fi

BACKUPDIR=$1              # directory to be backed up

# Get actual directory name (strip leading path info, if any)
get_directory_name $BACKUPDIR

# set environment for backup 
set_variables

# create the archive file
create_archive $BACKUPDIR $TARFILE

# copy the archive file to the server
copy_to_server $TARFILE $REMOTEID $SERVER $REMOTEDIR

# clean up archive file
rm_archive $TARFILE

# Create a timestamp in the logfile to record the backup operation.
log_backup $BACKUPDIR $LOGFILE

exit 0                             # return 0 on success

