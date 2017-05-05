#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

    declare -a FILES_TO_SYMLINK=(

        "shell/aliases/aliases"
        "shell/bash_profile"
        "shell/bash_prompt"
        "shell/bashrc"

        "zsh/zshrc"

        "git/gitconfig"
        "git/gitignore"
        "git/extras"

        "tmux/tmux.conf"

        "vim/vimrc"

        "os/install/linux/gtkrc-2.0"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local configDir="/home/lucasbittar/Projects/dotfiles/os/install/linux"
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Create symbolic links under .config folder\n\n"

    ln -fs $configDir/.config/i3 /home/lucasbittar/.config/i3-test
    print_success "/home/lucasbittar/.config/i3 → $configDir/.config/i3"

    ln -fs $configDir/.config/polybar /home/lucasbittar/.config/polybar-test
    print_success "/home/lucasbittar/.config/polybar → $configDir/.config/polybar"

    ln -fs $configDir/.config/termite /home/lucasbittar/.config/termite-test
    print_success "/home/lucasbittar/.config/termite → $configDir/.config/termite"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Create symbolic links under .fonts folder\n\n"

    ln -fs $configDir/.fonts /home/lucasbittar/.fonts-test
    print_success "/home/lucasbittar/.fonts → $configDir/.fonts"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Create symbolic default symlinks\n\n"

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ ! -e "$targetFile" ] || $skipQuestions; then

            execute \
                "ln -fs $sourceFile $targetFile" \
                "$targetFile → $sourceFile"

        elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
            print_success "$targetFile → $sourceFile"
        else

            if ! $skipQuestions; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then

                    rm -rf "$targetFile"

                    execute \
                        "ln -fs $sourceFile $targetFile" \
                        "$targetFile → $sourceFile"

                else
                    print_error "$targetFile → $sourceFile"
                fi

            fi

        fi

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n • Create symbolic links\n\n"
    create_symlinks "$@"
}

main "$@"
