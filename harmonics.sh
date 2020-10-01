#!/bin/bash

play_freq() {
    ffplay -f lavfi -i "sine=frequency=$1" -nodisp 2> /dev/null
}


play_harmonics() {
    # Base frequency in Hz
    ROOT=$1

    for i in {1..6}
    do
        # Play integer multiples of the root
        new_freq=$(echo "$ROOT * $i" | bc)
        play_freq $new_freq &
        sleep 0.3
    done
}

for f in 200 600;
do
    play_harmonics $f &
done

sleep 5;
killall ffplay
