# dotfiles

My dotfiles and config files

## Usage

### Script

In order to use the script, you have to install `stow`.

Add execution permission for the file if needed:

```bash
chmod +x ./symlink_dotfiles.sh
```

Run the script:

```shell
./symlink_dotfiles.sh
```

### Manually

Just run `stow` and the name of the package(s) you want to symlink, e.g.:

```shell
stow nvim zsh p10k
```

## Other

### VSCode extensions

#### Backup

Backup the extension names to `extensions-list.txt`

```shell
code --list-extensions > extensions-list.txt
```

#### Restore

Restore (install) extensions from `extensions-list.txt`

```shell
cat extensions-list.txt | xargs -n 1 code --install-extension
```
