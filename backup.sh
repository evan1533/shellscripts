#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/home /etc /root /boot /opt /usr/local /usr/games /var/backups"
exclude_files="/home/evan1533/.cache/*"

# Where to backup to.
dest="/mnt/backup"

#Check to make sure the remote dir is mounted
dir_grp=$(stat -c "%G" $dest)
count=0
while [ $dir_grp != "users" ]
do
    if [ $count -ge 3 ]
    then
        echo "Backup failed: Unable to mount remote directory"
        exit
    fi
    echo "Remounting remote dir..."
    sudo mount -t nfs 192.168.1.6:/volume1/homes/evan1533/backups/Ubuntu /mnt/backup
    dir_grp=$(stat -c "%G" $dest)
    ((count++))
done

# Create archive filename.
day=$(date +%F)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Create list of installed packages
dpkg --get-selections > /home/evan1533/Package.list
sudo cp -R /etc/apt/sources.list* /home/evan1533/
sudo apt-key exportall > /home/evan1533/Repo.keys

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
sudo tar --exclude='$exclude_files' -czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
