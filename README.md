# dotfiles

My dotfiles and setup scripts

> [!IMPORTANT]
> This repository is made for my personal use, so I can't guarantee that everything will work properly with your setup. However, feel free to copy or adapt any files to suit your needs.

## Setup

The top-level `bat/`, `btop/`, `nvim/`, `p10k/`, `tmux/`, `vscode/`, `yazi/`, and `zsh/` directories are [GNU Stow](https://www.gnu.org/software/stow/) packages.

From the repository root, install the openSUSE packages and link the dotfiles:

```shell
chmod +x scripts/install_pkgs_opensuse.sh
./scripts/install_pkgs_opensuse.sh
stow -R --target="$HOME" bat btop nvim p10k tmux vscode yazi zsh
```

Remove the links with:

```shell
stow -D --target="$HOME" bat btop nvim p10k tmux vscode yazi zsh
```

### Zsh

[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) requires Zsh, Git, and either curl or wget. These are included in the package script, or can be installed separately:

```shell
sudo zypper install zsh git curl
chsh -s "$(command -v zsh)"
```

Install Oh My Zsh:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install the external plugins and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) used by `.zshrc`:

```shell
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

The shell startup also uses [pokemon-colorscripts](https://gitlab.com/phoneybadger/pokemon-colorscripts):

```shell
git clone --depth=1 https://gitlab.com/phoneybadger/pokemon-colorscripts.git /tmp/pokemon-colorscripts
sudo /tmp/pokemon-colorscripts/install.sh
rm -rf /tmp/pokemon-colorscripts
```

Comment out `pokemon-colorscripts -r` in `.zshrc` if it is not installed or not wanted at shell startup.

### Path

```shell
# Dotnet
export PATH="/usr/share/dotnet/sdk:$PATH"
# Dotnet tools
export PATH="$PATH:$HOME/.dotnet/tools"
```

### Git

```shell
[user]
	name = some-username
	email = some-username@some-domain.net
[credential "https://github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
[core]
	editor = nvim
    compression = 9
[init]
	defaultBranch = main

```

### VS Code extensions

To restore (install) extensions from list:

```shell
xargs -n 1 code --install-extension < vscode/extensions-list.txt
```

To backup current extensions:

```shell
code --list-extensions > vscode/extensions-list.txt
```
