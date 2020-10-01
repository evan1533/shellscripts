#include <stdio.h>
#include <stdlib.h>

static char* toBinary(int num, int size)
{
    char* res = calloc(size + 1, sizeof(char));
    int temp = num;

    if(num < 0)
    {
        temp = (num*-1)-1;
    }

    for(int j = 0; j < size; j++)
    {
        *(res+j) = (num < 0) ? '1' : '0';
    }

    int i = 0;
    while(temp > 0)
    {
        *(res+(size-1-i)) = (num < 0) ? '1'-temp%2 : '0'+temp%2;
        temp = temp >> 1;
        i++;
    }
    return res;
}

int main(int argc, char** argv)
{
    if(argc > 1)
    {
        int num = atoi(argv[1]);
        int size = argc == 3 ? atoi(argv[2]) : 32;
        char* bin_num = toBinary(num, size);
        printf("%s\n", bin_num);
        free(bin_num);
        return 0;
    }
    else
    {
        return 1;
    }
}
