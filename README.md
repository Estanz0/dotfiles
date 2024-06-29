# My dotfiles

- Zsh

GNU stow is used to keep all the dotfiles in one directory, allowing for easier version control, maintenance, and symlinking. 

## Installation

### Prerequisites

Ensure you have the following:

- Git

> [!TIP]
> I designed this repo to be placed in the home (`~/`) directory. If you choose to place it somewhere else, you may have to change some of the configurations. For example, instead of `stow .`, you will need to use the `--dir/-d` flag to point to where you've placed the dotfiles e.g. `stow -d ~/foo/dotfiles -t ~/`.

### Setting Up the Dotfiles

If you do not want to use GNU stow or would like to maintain all of your dotfiles yourself, you can copy whatever files you like from this repository. 

Otherwise, if you'd like to use GNU stow to maintain all of your symlinks for you, you can replace or add any of the files with ones you already have and would like to keep.


You can install GNU stow by running

```
sudo pacman -S stow
```

> [!IMPORTANT]
> Make sure that the file structure of the dotfiles is the same as it would be in the HOME directory. E.g. if you have a dotfile `/home/user/foo/.bar`, make sure that it's placed in `dotfiles/foo/`

To use GNU stow to setup the symlinks, in the dotfiles directory run (assuming it's placed in `~/`)

```
$ stow .
```

That should symlink all the files for you.

> [!NOTE]
> If you have files that already exists in the location that will be overwritten by stow, stow will abort the symlinking process for those files. To instead replace those files with the ones that exist in the dotfiles directory, run the following:
> ```
> stow . --adopt
> git diff
> git reset --hard
> ```

#### Excluding Directories and Files from Stowing
If you'd like to ignore directories or files from being symlinked by stow, you can either delete them or add them into the `.stow-local-ignore` file.


## Usage

- Replace the `.gitconfig` with your config.
- Run `stow .` whenever you want to create or update the symlinks.
- To clean up any symlinks of deleted files, run `stow -R .`

## References

- Idea and methodology is based on Dreams of Autonomy's video [Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs).
