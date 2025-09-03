# dotfiles

- distro: `arch linux`
- window manager: `sway`
- bar: `waybar`
- launcher: `fuzzel`
- terminal emulator: `kitty`
- text editor: `neovim`
- file manager: `yazi`

## Installation

I use a modified [dotbot](https://github.com/anishathalye/dotbot) install script to manage my dotfiles. Usage:
```sh
$ install [--theme ashen|ayu-dark|gruvbox-dark] (...dotbot OPTIONS...)
```

Just running `./install` is enough to link all dotfiles from [`home`](home/) and [`config`](config/). But using the `--theme` option will link the files from the respective theme folder. Most applications' configuration files expect one of the available themes to be set.

> [!NOTE]
> The `install` script doesn't install packages, those would have to be installed manually. See [`packages`](packages/).

## Usage

I use the [Berkeley Mono](https://usgraphics.com/products/berkeley-mono) font, which is an amazing font from U.S. Graphics Company. I used the [Nerd Fonts](https://www.nerdfonts.com) patcher script for icons. A few free alternatives that I would use are IosevkaTerm Nerd Font or Noto Nerd Font.

> [!NOTE]
> My `waybar` config is based off an old version of [mechabar](https://github.com/sejjy/mechabar), which uses JetBrainsMono Nerd Font, not Berkeley Mono.

~~I keep a list of packages installed on each rice in `<theme>/.pkglist/`. This method of backing up packages is outlined on the Arch Linux Wiki [here](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages).~~ I used to run a cronjob that used `pacman` to backup all of the packages currently installed to a `.pkglist/` directory. However, I now just manually keep lists of various packages that I use in [`packages`](packages/).

The wallpapers can be found here: [wallpapers](https://github.com/notchum/wallpapers). This repo is cloned to `~/Pictures` with the dotbot install script.

Using a dotbot plugin, I am able to identify my different machines by host name and link different configuration files for each. That is, I am able to use this single repo and single install script to bootstrap my dotfiles for both my KDE Plasma workstation and my Sway laptop.

Themes can be swapped around simply by re-executing the `install` script (i.e. running `./install --theme <name>`). Sway will need to be reloaded after a theme is applied by pressing <kbd>Meta-Shift-c</kbd>.

## Themes

### [`ashen`](https://github.com/ficd0/ashen)

![ashen-screenshot1](images/ashen-screenshot1.png)
![ashen-screenshot2](images/ashen-screenshot2.png)

### [`gruvbox-dark`](https://github.com/morhetz/gruvbox)

![gruvbox-dark-screenshot1](images/gruvbox-dark-screenshot1.png)
![gruvbox-dark-screenshot2](images/gruvbox-dark-screenshot2.png)

### [`catppuccin-mocha`](https://catppuccin.com/)

![catppuccin-mocha-screenshot1](images/catppuccin-mocha-screenshot1.png)
![catppuccin-mocha-screenshot2](images/catppuccin-mocha-screenshot2.png)

## Fetches

- [pfetch](https://github.com/dylanaraps/pfetch) - Fast and pretty fetch tool that can be configured with one line in `.zshrc`/`.bashrc`.
- [nitch](https://github.com/ssleert/nitch) - Very uniquely designed fetch tool that has a great configuration out of the box.
- [macchina](https://github.com/Macchina-CLI/macchina) - Extremely customizable fetch tool with an amazing name. Also written in Rust btw.
- [neofetch](https://github.com/dylanaraps/neofetch) - The king of system info. Holds a special place in my heart.

![fetch](images/fetch.png)
