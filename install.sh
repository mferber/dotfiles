#!/usr/bin/env bash

function main {
    echo "Installing dotfiles..."
    install gitconfig ~/dotfilestest/gitconfig
    install zshrc ~/dotfilestest/zshrc
    echo
}

function install {
    DOTFILES_DIR="$(resolve_script_dir)/"
    SRC="${DOTFILES_DIR}src/$1"
    red="\033[0;91m"
    green="\033[0;92m"
    reset="\033[0m"

    if [ -L $2 ]; then
        if [ "$SRC" = $(readlink $2) ]; then
            echo -e "${green}✓ $2:${reset} symlink verified -> $SRC"
        else
            echo -e "${red}𐄂 $2:${reset} already symlinked -> $(readlink $2)"
        fi
    elif [ -e $2 ]; then
        echo -e "${red}𐄂 $2:${reset} file exists at this location"
    else
        ln -s "$SRC" "$2"
        if [ "$?" = "0" ]; then
            echo -e "${green}✓ $2:${reset} installed symlink -> $SRC"
        else
            echo -e "${red}𐄂 $2:${reset} could not create symlink at $2"
        fi
    fi
}

# From: https://stackoverflow.com/a/246128
function resolve_script_dir {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        
        # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" 
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
}

main
