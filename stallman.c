#include <stdio.h>

int main()
{
    char interjection[] = 
"I'd just like to interject for a moment.  What you're referring to as Linux, \n\
is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux.\n\
Linux is not an operating system unto itself, but rather another free component\n\
of a fully functioning GNU system made useful by the GNU corelibs, shell\n\
utilities and vital system components comprising a full OS as defined by POSIX.\n\
\n\
Many computer users run a modified version of the GNU system every day,\n\
without realizing it.  Through a peculiar turn of events, the version of GNU\n\
which is widely used today is often called \"Linux\", and many of its users are\n\
not aware that it is basically the GNU system, developed by the GNU Project.\n\
\n\
There really is a Linux, and these people are using it, but it is just a\n\
part of the system they use.  Linux is the kernel: the program in the system\n\
that allocates the machine's resources to the other programs that you run.\n\
The kernel is an essential part of an operating system, but useless by itself;\n\
it can only function in the context of a complete operating system.  Linux is\n\
normally used in combination with the GNU operating system: the whole system\n\
is basically GNU with Linux added, or GNU/Linux. All the so-called \"Linux\"\n\
distributions are really distributions of GNU/Linux.";

    printf("%s\n", interjection);
    return 0;
}
