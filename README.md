# dotfiles

My dotfiles and setup scripts

> [!IMPORTANT]
> This repository is made for my personal use, so I can't guarantee that everything will work properly with your setup. However, feel free to copy or adapt any files to suit your needs.

## dotfiles

The `dotfiles/` directory contains my dotfiles, which are managed with `stow`.

## scripts

The `scripts/` directory contains all scripts.

In order to use any script:

```shell
cd scripts/

# Add execution permission for the file if needed:
chmod +x ./script_name.sh

# Run the script:
./script_name.sh
```

`stow_dotfiles.sh`

- symlinks all dotfiles from `dotfiles/` using `stow`

`install_packages_arch.sh`

- installs arch and Flatpak packages from lists

## Other

### VSCode extensions

```shell
cd dotfiles/vscode/

# Restore (install) extensions from `extensions-list.txt`
cat extensions-list.txt | xargs -n 1 code --install-extension

# Backup the extension names to `extensions-list.txt`
code --list-extensions > extensions-list.txt
```
