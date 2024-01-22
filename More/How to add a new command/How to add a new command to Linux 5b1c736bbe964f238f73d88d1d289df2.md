# How to add a new command to Linux

**In Linux, a command is a program or utility that you can execute from the command line (terminal) to perform specific tasks.** It's a way of interacting with your computer directly through text-based instructions, rather than using graphical interfaces like windows and icons.

### For example,

### if we input the `“userinformation”` command, the output will give the user name and its ID in the system”.

## 💡 ***Step 1: Write the program content for the command in any text editor***

```cpp
#include <iostream>
#include <unistd.h>
#include <sys/types.h>

using namespace std;

int main()
{
    cout<<"username = "<<getlogin()<<endl;
    cout<<"userid = "<<getuid()<<endl;
    return 0;
}
```

In this code, we utilize **`‘getuid’`and `‘getlogin’`**function from `**‘glibc’**` library which returns the ID of the current user in the system and its name.

## 💡 *Step 2: Compile this code with g++ compiler*

 Now, we run this command in the terminal, but in the current directory !!!

![Untitled](How%20to%20add%20a%20new%20command%20to%20Linux%205b1c736bbe964f238f73d88d1d289df2/Untitled.png)

## 💡 ***Step 3: Add the binary file to the system's PATH***

![Untitled](How%20to%20add%20a%20new%20command%20to%20Linux%205b1c736bbe964f238f73d88d1d289df2/Untitled%201.png)

Now, we can run `**“userinformation”**`command from anywhere 🎃

![Untitled](How%20to%20add%20a%20new%20command%20to%20Linux%205b1c736bbe964f238f73d88d1d289df2/Untitled%202.png)