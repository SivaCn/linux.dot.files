
         _ _                       _       _      __ _ _
        | (_)_ __  _   ___  __  __| | ___ | |_   / _(_) | ___  ___
        | | | '_ \| | | \ \/ / / _` |/ _ \| __| | |_| | |/ _ \/ __|
        | | | | | | |_| |>  < | (_| | (_) | |_ _|  _| | |  __/\__ \
        |_|_|_| |_|\__,_/_/\_(_)__,_|\___/ \__(_)_| |_|_|\___||___/





How does my Terminal Look like ?


![alt tag](https://raw.githubusercontent.com/SivaCn/linux.dot.files/master/.screenshots/Terminal.png)



How does my vim look like ?

![alt tag](https://raw.githubusercontent.com/SivaCn/linux.dot.files/master/.screenshots/vim.png)

Dot-Files
=========

    A Single Repository that has the needed dot files for Linux.

    Usage:
        Just clone this repo in the user's home directory.


    For cleaning Up the Existing dotfiles:

        $ cat .gitignore | awk -F'!' '{print $2}' | uniq | xargs -n 1 rm -vrf

    ## This will delete the existing specified dotfiles in .gitignore
