# dotfiles

My dotfiles repo.

## How to setup a new machine (MacOS/Ubuntu/Arch)

To set up the `dotfiles` just run the appropriate snippet in the terminal:

(:warning: **DO NOT** run the `setup` snippet if you don't fully
understand [what it does](os/setup.sh). Seriously, **DON'T**!)

| OS | Snippet |
|:---|:---|
| `macOS` | `bash -c "$(curl -LsS https://raw.github.com/lucasbittar/dotfiles/master/os/setup.sh)"` |
| `Arch` | `bash -c "$(wget -qO https://raw.github.com/lucasbittar/dotfiles/master/os/setup-arch.sh)"` |
| `Ubuntu` | `bash -c "$(wget -qO - https://raw.github.com/lucasbittar/dotfiles/master/os/setup.sh)"` |

## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Cătălin Mariș](https://github.com/alrra/dotfiles)


## License

The code is available under the MIT license.
