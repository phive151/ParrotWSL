DOCS
===
Apt Sources
---

### /etc/apt/sources.list
The sources file that comes with the container is crap in comparison.  The file I've included is rich with comments, direction, and options.
Have yourself a look-see.  Someone took the time to write it out for you. So give it a lil' gander. I am out in the Western United States so 
I have it configured for whats best for me.  
**_Milage may vary._**

WSL2 Config files
---
   + There are two different config files in here. I havent done a whole lot of testing with the distro but since it wasn't custom made for WSL2
     I imagine that there are items left wanting.  That being the case, I am throwing in some config file:
1. "wsl.conf"
   - Found at /etc/wsl.conf; this is your **_"per distro"_** config file. Options and definitions can be found [here](https://learn.microsoft.com/en-us/windows/wsl/wsl-config).
2. .wslconfig
   - This one goes in your Windows user profile "C:\Users\<UserName>\.wslconfig". Again, options and definitions can be found [here](https://learn.microsoft.com/en-us/windows/wsl/wsl-config).
     #### **_Do not add this file until you are sure you know what you are doing!!_**
   - If all of a sudden your WSL2 starts erroring out, delete this file and it will almost certainly resolve itself.
  ***
DOT FILES
---

This is how my ZSH is set up.  It keeps true to the "parrot" prompt and has your bells and whistles without all the _"Oh My ZSmess"_.
1. _".zshrc"_ found in your `"$ZDOTDIR"`which defaults to your $HOME `"${HOME}/.zshrc"` -or- `~/.zshrc`   
   - This is your zsh run commands file.  I keep general config stuff but I like to seperate out my
path and aliases into seperate files.  I think it looks cleaner 🤷🏻‍♂️.
2. _".zalias"_ found at `"${ZDOTDIR}/.zalias"`
   - I keep all my aliases here.  Mostly becasue I had them in a `rc` file and lost everything so now I keep them seperated out.
3. _".zprofile"_ found at `"${ZDOTDIR}/.zprofile"`
   - Path and if then tests for `$ENV` variables.
