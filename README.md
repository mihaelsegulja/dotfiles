# dotfiles

My dotfiles and setup scripts

> [!IMPORTANT]
> This repository is made for my personal use, so I can't guarantee that everything will work properly with your setup. However, feel free to copy or adapt any files to suit your needs.

## Dotfiles

The `dots/` directory contains my dotfiles, which are managed with `stow`.

## Scripts

The `scripts/` directory contains scripts for helping with setting up dotfiles and packages.

In order to use any script:

```shell
cd scripts/

# Add execution permission for the file if needed:
chmod +x ./script_name.sh

# Run the script:
./script_name.sh
```

`post_install.sh`

- An all-in-one solution for making the setup process after a fresh OS install a bit easier

`stow_dotfiles.sh`

- Symlinks all dotfiles from `dots/` using `stow`

- You can also pass the flag `-D` or `--unstow` to unstow dotfiles

`install_pkgs_opensuse.sh`

- Adds repositories and installs packages for OpenSUSE Tumbleweed

## Other

### Oh My Zsh

Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh):

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Path

```shell
# Dotnet
export PATH="/usr/share/dotnet/sdk:$PATH"
# Dotnet tools
export PATH="$PATH:$HOME/.dotnet/tools"
```

### .gitconfig

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

### VSCode extensions

To restore (install) extensions from list:

```shell
cd dots/vscode/

cat extensions-list.txt | xargs -n 1 code --install-extension
```

To backup current extensions:

```shell
code --list-extensions > extensions-list.txt
```
