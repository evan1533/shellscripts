#!/bin/bash

#ssh pi "/home/pi/.scripts/archive -z /home/pi/ROMS/" &
rsync -ar -e ssh pi:/home/pi/ROMS/ ~/.archive/roms
