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
