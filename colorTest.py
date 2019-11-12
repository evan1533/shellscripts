for r in range(0, 255, 5):
    for g in range(0, 255, 5):
        for b in range(0, 255, 5):
            print("\033[48;2;%d;%d;%dm(%d, %d, %d)" % (r, g, b, r, g, b), end='')
            print("\033[00m")
