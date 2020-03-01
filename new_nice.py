#!/usr/bin/python3

import math
import time
import sys

"""
a = 24
om = 0.15
off = 30
sleep = 0.05
args = []
"""
COLORS = ['\033[38;5;11m',
          '\033[38;5;201m',
          '\033[38;5;10m',
          '\033[38;5;63m',
          '\033[38;5;31m',
          '\033[38;5;202m']


def getColor(i: int) -> str:
    return COLORS[i % len(COLORS)]


def readVals():
    global a, om, off, sleep
    helix = open("helix.txt", "r")
    for line in helix:
        args = line.split(",")
        a = int(args[0])
        om = float(args[1])
        off = int(args[2])
        sleep = float(args[3].strip('\n'))
        # print(args)
    helix.close()


def draw_good_thicc(num_rib):
    i = 0
    while True:
        global a, om, off, sleep
        thicc = 35
        if i % 10 == 0:
            readVals()

        jays = [(a*math.cos(i*om - j*2*math.pi/num_rib) + off) for j in range(num_rib)]
        djays = [(thicc*-math.sin(i*om - j*2*math.pi/num_rib)) for j in range(num_rib)]

        fpart = lambda x: x - math.floor(x)
        thikk = 3
        prime_rib = math.floor(fpart(i*om/(2*math.pi) + 0*(1/(2*num_rib)))*num_rib)

        for k in range(0, a+thicc+off+1):
            # Relative rib index
            r = 0
            while r < num_rib:
                # Non-relative rib index
                nrri = (prime_rib-r) % num_rib
                if (k - jays[nrri]+djays[nrri]/2)*(k-jays[nrri]-djays[nrri]/2) < thikk:
                # if k == jays[nrri]:
                    print('%s0' % getColor(nrri), end='\033[0m')
                    break
                
                r += 1

            if r == num_rib:
                r = 0
                while r < num_rib:
                    nrri = (prime_rib-r) % num_rib
                    if (k - jays[nrri]+1.4*djays[nrri]/2)*(k-jays[nrri]-1.4*djays[nrri]/2) < thikk:
                    # if k == jays[nrri]:
                        print('%s,' % getColor(nrri), end='\033[0m')
                        break
                    r += 1

                if r == num_rib:
                    print(" ", end='')
        print()

        i += 1
        time.sleep(sleep)

if __name__ == "__main__":
    if len(sys.argv) >= 1:
        num_rib = int(sys.argv[1])
    draw_good_thicc(num_rib)
