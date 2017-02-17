1. `ln -s $(pwd)/after ~/.vim/after`
2. [Install dein](https://github.com/Shougo/dein.vim).
   When it expects an install path, use `~/.vim/bundle`.
3. Source (or symlink) `vimrc.include` in `~/.vimrc`.
4. Put `clein.sh` in PATH. (or don't. whatever. No script
   needs it, it's just for personal use)

Note: here's the contents of my _actual_ `.vimrc` on this machine,
which includes a system-specific touch.

```vim
" Load system defaults since my custom build does not do this on its own.
" (note: there must be another file elsewhere, too, as I've noticed that the
" 'backspace' setting still doesn't get set automatically)
source /etc/vim/vimrc

source /home/lampam/dotfiles/vim/vimrc.include
```

