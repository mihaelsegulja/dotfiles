# dotfiles

My dotfiles and config files

## Usage

### Script

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
