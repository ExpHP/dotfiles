# ExpHP's dotfiles

## Setup

### Shell

Add this to `~/.bashrc`:

```sh
#-----------------------------------------------------
# Make absolutely certain that history is preserved even if we mess up bashrc.
export HISTFILESIZE=

# Stuff specific to this machine
source /home/lampam/dotfiles/shell/machine/matisse.include

# Stuff specifically bash-related (e.g. PS1 prompt)
source /home/lampam/dotfiles/shell/bashrc.include

# Stuff for all shells  (environment vars, aliases...)
source /home/lampam/dotfiles/shell/common.include
```

**Important:** If this machine is accessed remotely, KEEP YOUR TERMINAL OPEN and IMMEDIATELY OPEN ANOTHER to verify that you can still log in through ssh.

The following is the **entirety** of my `~/.zshrc`:

```sh
source /home/lampam/dotfiles/shell/zshrc.include
source /home/lampam/dotfiles/shell/common.include
```

My zsh used a custom theme:

```sh
sudo ln -s dotfiles/symlinks/agnoster-exphp.zsh-theme /usr/local/share/oh-my-zsh/themes
```

Some of the functionality in my shell dotfiles may depend on the rust binaries.

### Vim

~~To set up `~/.vim/`, see [`vim/README.md`](vim).~~

(**Update 5/2025:** It doesn't look like I ever set vim up on WSL Ubuntu 2020.04.  I seem to be living fine without the config.)

If you can't make it work, then *please, please, PLEASE* at the very least add this to `.vimrc` before continuing any further:

```vim
" Remove line limit for yanking between files by redefining viminfo without the '<' option
set viminfo='100,s10,h
```

### Miscellaneous dotfiles

Some symlinks are created by `./do-misc-setup`.  This script will check that certain symlinks exist (or that the files in here are at least mentioned).

This script could probably do more but I keep forgetting that it exists.

### Other things to install

#### Fuzzy finder on Ctrl+R

```sh
mkdir -p ~/.local/opt
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/opt/fzf
yes | ~/.local/opt/fzf/install --xdg

edit .bashrc  # move the fzf stuff to be BEFORE things from ~/dotfiles are sourced
```

### Rust binaries

Get rust.

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

There are some rust binaries to build and install in [`dotfiles/rust-bin`](rust-bin).

### Gnu stow packages

Take a peek in [`dotfiles/stow`](stow) and see if anything there is useful.

### Notes

Most other things in this repo are *probably* documented in [`notes.md`](notes/notes.md) (along with lots of other info for setting up a new machine).

