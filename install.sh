#!/usr/bin/env bash

function main {
    echo "Installing dotfiles..."
    install zsh/zshrc ~/.zshrc
    install zsh/dot_zsh ~/.zsh
    install karabiner/karabiner.json ~/.config/karabiner/karabiner.json
    install git/gitconfig ~/.gitconfig
    install git/gitignore_global ~/.gitignore_global
    install vim/vimrc ~/.vimrc
    install vscode/vscode_settings.json ~/Library/'Application Support'/Code/User/settings.json
    install vscode/vscode_settings.json ~/Library/'Application Support'/VSCodium/User/settings.json
    install vscode/vscode_keybindings.json ~/Library/'Application Support'/Code/User/keybindings.json
    install vscode/vscode_keybindings.json ~/Library/'Application Support'/VSCodium/User/keybindings.json
    install vim/ideavimrc ~/.ideavimrc
    install vlc/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
    install hammerspoon/dot_hammerspoon ~/.hammerspoon
    install xh/config.json ~/.config/xh/config.json
    echo
}

function install {
    DOTFILES_DIR="$(resolve_script_dir)/"
    SYMLINK_LOCATION=$2
    SYMLINK_TARGET=${DOTFILES_DIR}src/"$1"
    SYMLINK_LOCATION_DISPLAY=$(shorten_path "$SYMLINK_LOCATION")
    SYMLINK_TARGET_DISPLAY=$(shorten_path "$SYMLINK_TARGET")
    red="\033[0;91m"
    green="\033[0;92m"
    cyan="\033[0;36m"
    reset="\033[0m"

    if [ -L "$SYMLINK_LOCATION" ]; then
        ACTUAL_SYMLINK_TARGET=$(readlink "$SYMLINK_LOCATION")
        if [ "$ACTUAL_SYMLINK_TARGET" = "${SYMLINK_TARGET}" ]; then
            echo -e "${green}✓ $SYMLINK_LOCATION_DISPLAY:${reset} verified symlink -> $SYMLINK_TARGET_DISPLAY"
        else
            echo -e "${red}𐄂 $SYMLINK_LOCATION_DISPLAY:${reset} conflicting symlink exists -> $(shorten_path $ACTUAL_SYMLINK_TARGET)"
        fi
    elif [ -e "$SYMLINK_LOCATION" ]; then
        echo -e "${red}𐄂 $SYMLINK_LOCATION_DISPLAY:${reset} file exists at this location"
    else
        SYMLINK_DIR=`dirname "$SYMLINK_LOCATION"`
        if [ ! -d "$SYMLINK_DIR" ]; then
            mkdir -p "${SYMLINK_DIR}"
            if [ $? -ne 0 ]; then
                echo -e "${red}𐄂 $SYMLINK_LOCATION_DISPLAY:${reset} parent directory ${SYMLINK_DIR} does not exist and could not be created"
            else
                echo -e "${cyan}✓ $SYMLINK_DIR:${reset} created directory"
            fi
        fi
        if [ -d "$SYMLINK_DIR" ]; then
            ln -s "$SYMLINK_TARGET" "$SYMLINK_LOCATION"
            if [ "$?" = "0" ]; then
                echo -e "${green}✓ $SYMLINK_LOCATION_DISPLAY:${reset} installed symlink => $SYMLINK_TARGET_DISPLAY"
            else
                echo -e "${red}𐄂 $SYMLINK_LOCATION_DISPLAY:${reset} could not create symlink at $SYMLINK_LOCATION_DISPLAY"
            fi
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

function shorten_path {
    ESCAPED_HOME_RE=$(echo $HOME | sed -e 's/[]\/$*.^[]/\\&/g');
    echo $1 | sed -e "s/^$ESCAPED_HOME_RE/~/"
}

main
