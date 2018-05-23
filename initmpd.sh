#!/bin/bash

MOUNT_POINT=/music
PARTITION=/dev/mmcblk0p3
PLAYLIST=/music/playlists/all.m3u

# wait until mpd is up and responding
mpc -q
while [ $? -ne 0 ]; do
  sleep 1
  mpc -q
done

# update mpd database and playlist
if [ -e /music/update ] || [ -e /music/update.txt ]; then
  # need to do an update
  echo "Updating MPD and playlists"
  # stop playback
  mpc -q stop
  # disable access via USB gadget
  echo "" > /sys/devices/platform/soc/20980000.usb/gadget/lun0/file
  # remount music partition rw
  # not all filesystems support -o remount so
  umount $MOUNT_POINT
  mount -o rw $MOUNT_POINT
  # remount root partition rw
  mount -o remount,rw /
  # regenerate playlist
  find $MOUNT_POINT -name \*.mp3 -o -name \*.wav -o -name \*.ogg -o -name \*.aac -o -name \*.flac > $PLAYLIST
  # update mpd
  mpc --wait update
  # cleanuo
  rm -f /music/update 2> /dev/null
  rm -f /music/update.txt 2> /dev/null
  # reboot (easiets way to reset changes)
  reboot
fi

# (re)set mpd
mpc -q clear
mpc -q random on
mpc -q repeat on
mpc -q single off
mpc -q load all
mpc -q play
