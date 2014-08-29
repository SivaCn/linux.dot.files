

         _ _                       _       _      __ _ _
        | (_)_ __  _   ___  __  __| | ___ | |_   / _(_) | ___  ___
        | | | '_ \| | | \ \/ / / _` |/ _ \| __| | |_| | |/ _ \/ __|
        | | | | | | |_| |>  < | (_| | (_) | |_ _|  _| | |  __/\__ \
        |_|_|_| |_|\__,_/_/\_(_)__,_|\___/ \__(_)_| |_|_|\___||___/





dotfiles
========


How does my Terminal Look like ?


![alt tag](https://raw.githubusercontent.com/SivaCn/linux.dot.files/master/.screenshots/Terminal.png)



How does my vim look like ?

![alt tag](https://raw.githubusercontent.com/SivaCn/linux.dot.files/master/.screenshots/vim.png)


Install
-------

    A Single Repository that has the needed dot files for Linux.

    Steps to configure:
    
         $ cd ~
         $ git init
         $ git remote add dotfiles_repo https://github.com/SivaCn/linux.dot.files.git
         $ git fetch dotfiles_repo
         
         These commands will link to the repo, and make ready to go, before proceeding
         further, you must either backup all your existing dotfiles or remove the dotfiles
         atleast which are listed in the .gitignore file
         
         $ git checkout -b dotfiles dotfiles_repo/master
         $ source ~/.bashrc

    That's it you are Done !
