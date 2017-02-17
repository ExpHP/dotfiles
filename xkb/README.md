xkb doesn't seem to have any per-user config files, so this is a bit nasty:

1. Find where the xkb layouts are defined.  In 16.04 LTS this is `/usr/share/X11/xkb`.
2. Make a symlink to `bud.syntax` at `/usr/share/X11/xkb/syntax/bud`. *(note the rename!)*
3. Copy **the textual content** of `bud.evdev`, and open `/usr/share/X11/xkb/rules/evdev.xml`.
   It can be freely placed amongst the other `<layout>...</layout>` blocks in there.
  * I believe this step makes it available for selection in the gtk gui (Text Entry Settings).
    Without it, you can still use `xkbmap bud`
4. `sudo dpkg-reconfigure xkb-data`. (there's also some directory which people
   say should be purged of `*.xkm` files, but I never see anything there.
   Old info, perhaps.)
