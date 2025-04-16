In archinstall, extra packages:
```
git base-devel
```

Setup network:
```sh
sudo systemctl enable --now iwd.service
```

Install AUR package manager:
```sh
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

Create SSH key for Github account:
```sh
paru -S github-cli
gh auth login
```

Clone dotfiles:
```sh
mkdir -pv ~/repos
git clone git@github.com:notchum/dotfiles.git ~/repos/dotfiles
```

Install dotfiles:
```sh
cd ~/repos/dotfiles
./install --laptop --sway --theme ashen
```

Fix `ly` from messing up path:
```sh
sudo sed -i '/path = /c\path = null' /etc/ly/config.ini
```

Configure `pacman` by uncommenting these lines in `/etc/pacman.conf`:
```
Color
VerbosePkgLists
ILoveCandy      # doesn't exists by default, add it
```

Setup bluetooth:
```sh
sudo systemctl enable --now bluetooth.service
```
