#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/Projects/dotfiles                    # dotfiles directory
olddir=~/Projects/dotfiles_old             # old dotfiles backup directory
files=(aliases bash_profile bash_prompt bashrc extras gitconfig zshrc)    # list of files/folders to symlink in homedir

##########

########## Helper functions

print_in_yellow() {
    printf "\e[0;33m%b\e[0m" "$1"
}

print_in_green() {
    printf "\e[0;32m%b\e[0m" "$1"
}

print_info() {
    print_in_yellow "\n $1\n\n"
}

print_success() {
    print_in_green "  [✔] $1\n"
}

##########

# create dotfiles_old in homedir
print_info "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
print_success "done"

# change to the dotfiles directory
print_info "Changing to the $dir directory ..."
cd $dir
print_success "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    print_info "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    ln -s $dir/.$file ~/.$file
    print_success "Created symlink to $file in home directory."
done

install_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # Clone my oh-my-zsh repository from GitHub only if it isn't already present
        if [[ ! -d $dir/oh-my-zsh/ ]]; then
            git clone http://github.com/robbyrussell/oh-my-zsh.git
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
            chsh -s $(which zsh)
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt-get to install zsh and then recurse
        if [[ $platform == 'Linux' ]]; then
            if [[ -f /etc/redhat-release ]]; then
                sudo yum install zsh
                install_zsh
            fi
            if [[ -f /etc/debian_version ]]; then
                sudo apt-get install zsh
                install_zsh
            fi
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            echo "Please install zsh, then re-run this script!"
            exit
        fi
    fi
}

install_zsh
