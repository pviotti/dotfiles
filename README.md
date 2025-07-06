# dotfiles

Configuration files for various tools I use on my Linux machines, for instance:
zsh, neovim, tmux, git, kitty, gpg-agent, yazi and sway.

## Installation

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) for managing dotfiles.
Stow creates symbolic links from your home directory to the configuration files in this repository.

### Prerequisites

Install GNU Stow (in Arch: `sudo pacman -S stow`).

### Installation Steps

1. Clone the repository:
   ```bash
   git clone git@github.com:pviotti/dotfiles.git ~/.config/dotfiles
   cd ~/.config/dotfiles
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. In neovim run `:PlugInstall` to install its plugins.

#### Package management

The dotfiles are organized into packages that can be installed individually,
as per folders in [stow](./stow/).

To install a specific package:
```bash
cd ~/.config/dotfiles/stow
stow -t $HOME <package-name>
```

To uninstall a specific package:
```bash
cd ~/.config/dotfiles/stow
stow -D -t $HOME <package-name>
```

To reinstall a specific package:
```bash
cd ~/.config/dotfiles/stow
stow -R -t $HOME <package-name>
```

To uninstall all packages:
```bash
./uninstall-stow.sh
```

## Other configurations

- Add user to `video` group to allow for [`light`][light] execution
```bash
sudo gpasswd -a <username> video
groups <username> # validation; need to log back in
```
- Firefox: `userChrome.css` for some UI customizations, and some bookmarklets:
```bash
ln -s $(pwd)/firefox/userChrome.css ~/.mozilla/firefox/<profile-folder>/chrome/userChrome.css
```

Some Windows configuration (possibly outdated) is available in [windows](./windows/).


[light]: https://gitlab.com/dpeukert/light