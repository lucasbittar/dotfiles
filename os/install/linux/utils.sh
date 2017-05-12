#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_package() {

    declare -r package="$2"
    declare -r PACKAGE_READABLE_NAME="$1"

    if ! package_is_installed "$package"; then

        #checking which helper is installed
        if pacman -Qi packer &> /dev/null; then

          echo "Installing with packer"
          packer -S --noconfirm --noedit  $package

        fi

    else
        print_success "$PACKAGE_READABLE_NAME"
    fi

}

package_is_installed() {
    pacman -Qi "$1" &> /dev/null
}

update() {

    # Resynchronize the package index files from their sources.

    execute \
        "sudo pacman -Syy"

}
