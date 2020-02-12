#!/bin/bash

ssh -L 8000:192.168.1.1:80 -C -N -l pi pi2
