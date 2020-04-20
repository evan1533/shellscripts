#!/bin/bash
CONFIG_FILE=/home/evan1533/.local/lib/python3.8/site-packages/mps_youtube/config.py
API_KEY="AIzaSyDD-vlcEttzl8meaq0nPhSolz_DuZHQJyg"
cat  $CONFIG_FILE\
    | sed "s/AIzaSyCIM4EzNqi1in22f4Z3Ru3iYvLaY8tc3bo/$API_KEY/g" > ~/new_config.py

vimdiff ~/new_config.py $CONFIG_FILE
rm ~/new_config.py
rm ~/.config/mps-youtube/cache_py_*
