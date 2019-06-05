
# What is this file?

This file is a list of notes I've compiled on various issues that I have encountered either on
my personal machines (most of which use Ubuntu) or on other computing resources available to me.
The general goal is that, after a new installation of the OS,
if I encounter an issue that I know I have encountered before,
then I can look in here (searching for a couple of keywords that I think I might have used)
to find out what I did.

It also has various random other nonsense.

<!------------------------------->
# Words I keep forgetting

- **2017-08-14:** pathological

<!------------------------------->
# Critical things to do after installing Ubuntu

**Last update: 2016-08-11**

This section is a laundry list of tasks that should be done ASAP after installing,
because the repercussions of not doing so can be painful.

All of these already have sections in the text below,
so I'll just put down enough info to locate those sections via search.

 * Re-enable REISUB!!!! (this already has a section below; search for REISUB)
 * Make sure Ctrl+Alt+F2 works (if not there is a section on nomodeset...)
 * Disable useless splash screens that obscure useful info on boot/shutdown.
    - /etc/default/grub, get rid of "quiet splash", `sudo update-grub`.
 * Install massive dependency trees ahead of time:
    - must first edit /etc/apt/sources.list and uncomment the deb-src lines
    - texlive (and texlive-latex-extra, and texlive-math-extra...)
    - KDE libraries (try kate or kdiff3)
    - 32bit libraries (try wine, maybe, though the version available might be kinda old;
                        unfortunately "build-dep wine" isn't enough :/)
    - pip(3,) install pylab (includes just about every python package and its mother)
    - libgtk2.0-dev
    - npm and node.js

## Other essential packages to grab

Varous things you need in order to help get the rest of the things you need

    vim  python-pip  python3-pip  git
    (from website, not repo)  google chrome

NOTICE: the pip from the canonical repos now installs to user folders (no sudo!)

## Awkward build deps

Build dependencies that are either very painful to miss the first time around
(because lots of stuff must be rebuilt due to e.g. poor build process),
or that only count as warnings when they are missing (when they should probably be more)

 * pylab
   This one is funny because `pip install pylab` automatically includes `pillow`... but pylab
    apparently doesn't *depend* on `pillow`, because pylab installs successfully even if pillow
    doesn't.  But I'd rather not take my chances
   - libjpeg-dev
   (added August 11 2016; even a pip install requires these):
   - libpng<VER>-dev
   - libfreetype<VER>-dev

 * matplotlib
   - `sudo apt-get install libffi-dev`
   - `sudo pip install cairocffi`
   - `sudo pip3 install cairocffi`


 * wine
   - `sudo apt-get build-dep wine`
   - `sudo apt-get install libgstreamer-plugins-base1.0-dev`
   - When running wine's 'configure', you should see messages near the end like

       configure: pcap development files not found, wpcap won't be supported.
       configure: libhal development files not found, no legacy dynamic device support.

       configure: Finished. Do 'make' to compile Wine.

   - If you see anything more serious that is missing, consider getting that dep, too.

libgstreamer-plugins-base0.10-dev
(FIXME I forget why I wrote that here, but notice the version differs subtly
 from the above apt-get command, so it was probably about some mistake that's easy to make)

<!------------------------------->
# It's lxc, dude

> Ohhhhh what was the name of that thing I used to use when I was
  trying to build 32-bit executables for wine and Dwarf Therapist

It's lxc.

```sh
sudo lxc-create -t ubuntu -n my32bitbox -- --bindhome $LOGNAME -a i386 --release trusty
```

<!------------------------------->
# CTAGS and the tagbar

**Installing CTAGS:** get package `exuberant-ctags`

**Installing TagBar:**

    cd downloads
    vim tagbar.vba
    :so %
    :q

**Setting up keybind, move to left side, disable sorting:**

Add to '~/.vimrc':

```vim
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_sort = 0
```

<!------------------------------->
# Backups

(**As of 2016-08-11**)

There's a readme in `~/scripts/other/backup` but it has a lot of text,
and seems to be geared more towards configuring it for a new setup
(rather than recovering my old setup)

I think in summary:

```sh
# NOTE: must symlink; I was dumb when I wrote it and it does
#       a "readlink" to find its true directory.
ln -s ~/scripts/other/backup/bin/back-me-up ~/bin
cd ~/scripts/other/backup
yes | sudo apt-get install rsnapshot rsync anacron
sudo mkdir -p /etc/cron.{monthly,weekly}
sudo cp etc/cron.monthly/* /etc/cron.monthly
sudo cp etc/cron.weekly/* /etc/cron.weekly

# compare and "pull" upstream changes before overwriting!
vimdiff {/,}etc/rsnapshot.conf
```

Here's a bit of text to stand stand as a barrier against blind
copying-and-pasting, yay!

```
sudo cp {,/}etc/rsnapshot.conf
```

**!!! IMPORTANT !!!**

If you just reinstalled the OS then MAKE YOUR FINAL BACKUP PERMANENT!
(otherwise you can't trust it to survive even to a "weekly")

This capability is NOT provided by my script (or rsnapshot in general).
Best solution I can think of is to make a hard-link copy manually with
the following command: (assuming daily.0 is the most recent backup)

```
sudo rsync -a --link-dest=../daily.0 daily.0/ eternal.USEFUL-NAME-HERE
```

(note: locations of trailing slashes very important. Also, for some absolutely
 bizarre fucking reason, --link-dest is relative to the destination)

<!------------------------------->
# flashplugin installer

(**As of 2016-08-11**)

In brief:

 * You USED to use a PPA with a package called `flashplugin-installer`.
   This was because there was no official 64-bit package at the time.
 * Now, an official package DOES exist; you now use `adobe-flashplugin`,
   from the `partner` repo.

<!------------------------------->
# Other vim plugins and config (OUTDATED)

(**As of 2014-09-30**)

**NOTE 2016-08-11: DON'T BOTHER WITH THIS ANY MORE**

Actually, since Ubuntu has no ~/.vimrc by default, you can easily
just symlink the version saved here in the scripts directory.

*.vim files can be found in the 'downloads' subfolder and symlinked
into ~/.vim/plugin

To symlink all of the .vim files:

```sh
ln -s -t ~/.vim/plugin/ ~/scripts/setup-notes/downloads/*.vim
```

<!------------------------------->
# RPI VPN

**packages:** `openconnect vpnc-scripts`

Check old `~/bin` folder for script.
If missing, the following should do:

```sh
#!/bin/bash
sudo openconnect vpn.net.rpi.edu
```

NOTE: An older version of the script included a --script option:

```sh
sudo openconnect --script=/etc/vpnc/vpnc-script vpn.net.rpi.edu
```

This script does not appear to exist at this location in Ubuntu,
and specifying its location no longer appears necessary.

<!------------------------------->
# Deleting to trash

**packages:** `trash-cli`

Aliases are defined in my shell dotfiles.

# Thinkpad not entering sleep mode

There is an issue with the Intel e1000e driver not enjoying being suspended when it
is already suspended (or something like that).

Create a symlink to `scripts/data/50_E1000E_FIX` in `/etc/pm`.

<!------------------------------->
# 32-bit and 64-bit libs

(2014-12)

When manually compiling an application and building separate libs for 32 bit and 64 bit, you can't put them both in /usr/local/lib.  Instead, make some directories for this purpose: /usr/local/lib32 and /usr/local/lib64.

Messing around with the `hello` package, I think I found the most important options to pass to ./configure:

```sh
# 32-bit
./configure --libdir=/usr/local/lib32 "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
# 64-bit
./configure --libdir=/usr/local/lib64
```

A lot of sources mention using the --build flag, but I'm not quite sure what that does.
It had no visible impact on the results of `make`.

To make the system search these directories for libraries at linking and runtime, add a file to /etc/ld.so.conf.d.

**`/etc/ld.so.conf.d/CUSTOM_local_biarch`**

```
# Biarch directories for manually built libraries
/usr/local/lib32
/usr/local/lib64
```

<!------------------------------->
# Building GLC

(**section added Dec 2014**)

GLC is a program for capturing game video and audio.  I had trouble getting the install script [https://github.com/nullkey/glc/raw/master/scripts/glc-build.sh] to find my 32 bit libraries, so here is how I built it manually.

UPDATE:  So it turns out glc can be built in 64 bit perfectly fine.  I had feared it wouldn't since glc-build.sh always does a 32-bit build.  Of course, for that very reason, you can't use the script to do it, and so you still need to build it manually.  You may skip the commands tagged "(32-bit build only)".

* Since I don't know much about cmake, I use some hacky tricks to do things that would typically be accomplished by passing flags to ./configure.  I use the CFLAGS environment variable to get elfhacks built in 32-bit:

  ```sh
  # (32-bit build only)
  export CFLAGS=-m32
  ```

* Get elfhacks and build:

  ```sh
  git clone https://github.com/nullkey/elfhacks.git
  cd elfhacks
  cmake . && make
  ``

* Note you can verify that the library is 32-bit or 64-bit with the file command:

  ```sh
  file src/libelfhacks.so.0.4.1
  ```

* Another dependency, `packetstream`, is built the same way.

  ```sh
  cd ..
  git clone https://github.com/nullkey/packetstream.git
  cd packetstream
  cmake . && make
  cd ..
  ```

* There is yet another dependency, `glc-support`, but this one is meant to be symlinked into - and built as part of - `glc`.  Get both `glc-support` and `glc`:

  ```sh
  git clone https://github.com/nullkey/glc.git
  git clone https://github.com/nullkey/glc-support.git
  cd glc && ln -sf ../glc-support ./support && cd ..
  ```

* It will require zconf.h to build.  zconf.h is in an architecture-qualified directory, but currently Ubuntu has no i386 version for for it.  The x86_64 version seems to work fine.

  ```sh
  # (32-bit build only)
  ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include
  ```

* I don't use `make install` because IIRC that will put things in `/usr/local/lib`, ignoring the architecture.
* We can manually install the libs by copying the files and links.

  ```sh
  # (32-bit build only)
  export GLC_LIB_DIR=/usr/local/lib32/
  mkdir -p $GLC_LIB_DIR
  cp -Pit $GLC_LIB_DIR elfhacks/src/libelfhacks.so* packetstream/src/libpacketstream.so*

  # (64-bit build only)
  export GLC_LIB_DIR=/usr/local/lib64/
  mkdir -p $GLC_LIB_DIR
  cp -Pit $GLC_LIB_DIR elfhacks/src/libelfhacks.so* packetstream/src/libpacketstream.so*
  ```

* Some symlinks (namely, ones with no version number) are oddly missing from the 32-bit versions of the multiarch libs.  Make symlinks to mirror the x86_64 ones:

  ```sh
  # (32-bit only)
  pushd /usr/lib/i386-linux-gnu
  sudo ln -s libpng12.so.0 libpng12.so
  sudo ln -s libpng12.so libpng.so
  sudo ln -s mesa/libGL.so.1 mesa/libGL.so
  sudo ln -s libXxf86vm.so.1 libXxf86vm.so
  sudo ln -s libX11.so.6 libX11.so
  sudo ln -s libasound.so.2 libasound.so
  popd
  ```

* It also won't find libGL due to being in a subfolder.  We can modify ld.so.conf to include it, or we can symlink the library in a path that's already searched.  My preference:

  ```sh
  # (32-bit only)
  sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so /usr/local/lib32/libGL.so
  ```

* Now we may build.

  ```sh
  cd glc
  cmake -DELFHACKS_LIBRARY=$GLC_LIB_DIR/libelfhacks.so -DPACKETSTREAM_LIBRARY=$GLC_LIB_DIR/libpacketstream.so -DELFHACKS_INCLUDE_DIR=../elfhacks/src -DPACKETSTREAM_INCLUDE_DIR=../packetstream/src .
  make
  ```

* Manually install libs and binaries

  ```sh
  # (32-bit)
  sudo cp -Pit $GLC_LIB_DIR src/glc/lib*.so* src/hook/lib*.so*
  sudo cp -i src/glc-capture /usr/local/bin/glc-capture32

  # (64-bit)
  sudo cp -Pit $GLC_LIB_DIR src/glc/lib*.so* src/hook/lib*.so*
  sudo cp -i src/glc-capture /usr/local/bin/glc-capture64
  sudo cp -i src/glc-play /usr/local/bin/glc-play
  ```

  (I don't think there's any reason to keep around an x86 version of glc-play,
    hence why the instructions above don't install it.
   glc-capture is another story, since it hooks directly into your game, and
    so you must use the version corresponding to the game's architecture)

<!------------------------------->
# trying to get smooth video

**(2015-01-13)**

(tl;dr:  video issues? try a different driver)

Wanted to play Touhou but was devastated by 'microstuttering'.  The game
would run perfectly except for an *almost imperceptible jump* that would
occur about once or twice per second.  It's the kind of situation that
can make one go mad, wondering if things *really are* off or if maybe
you've just convinced yourself they are.

(good test animations for stuttering can be found at http://testufo.com .
 Comparing this site on linux to windows made the stuttering very obvious)

## **Some things I tried that DID NOT WORK:**
 - Using xrandr to switch to resolutions with refresh rates closer to 60.
   (frustratingly, this did have *some* effect, but not enough!)
 - Disabled ccsm > OpenGL > Sync To VBlank
 - `dconf write /org/compiz/profiles/unity/plugins/composite/refresh-rate "60"`
 - Enabled ccsm > Workarounds > Legacy Fullscreen Support
 - Tried GNOME Fallback with Metacity (No Compiz).  No dice.

## Actual success
 - **_Uninstalling `nvidia-331` and using `nouveau` fixed the issue!_**

 - One thing to note: When I uninstalled nvidia-331, nouveau was already
   installed, so I logged out, and instead of lightdm, I was greeted with
   some menu for troubleshooting video problems in a low graphics mode.
   I selected an option that purportedly "recovered" some config files and
   was dropped into blank terminal, from which I switched to tty2, logged in,
   and rebooted.  LightDM worked on the next boot.
   Thus, it could also be these "recovered" config files that solved the
   issue.  Not sure, don't really care.

<!------------------------------->
# (`unity`) Disable overlay scrollbar

- This disables the overlay scrollbar from popping up
  (and making window resizing difficult),
  while retaining its visual appearance.

  This makes the scrollbar unusable, but it's not like I ever used it anyways.
  Mousewheel, page up/page down, and trackpoint scrolling all still work.

```sh
gsettings set com.canonical.desktop.interface scrollbar-mode 'overlay-touch'
```

<!------------------------------->
# Re-enabling sysreq stuff (reisub, etc.)

Edit `/etc/sysctl.d/10-magic-sysrq.conf`. Instructions are there.

I chose the value 502 to enable all but memory dumps.

<!------------------------------->
# Downmixing stereo to mono (pulseaudio)

To prevent myself from going insane from listening to recordings with no right channel, or where everything is panned 100% to different sides for some ungodly reason. (I'm looking at you, 419 Eater).  (no, really, what do you think this is, the freakin nineties?)
This can be done in pulse audio by adding a sink that mixes the channels together.

From StackOverflow: (with some edits)

- Find the name of your audio sink by running `pacmd list-sinks | grep name:`.
- Then run this command:

  ```sh
  pacmd load-module module-remap-sink sink_name=mono master=$NAME_OF_AUDIO_SINK channels=2 channel_map=mono,mono
  ```

  or add the argument to pacmd to `/etc/pulse/default.pa` (NOTE: "argument to pacmd" as in "everything after pacmd in the command"), to have it run at startup. Then in Sound Preferences choose "Mono" as the output but remember to reduce volumes by half, since two channels are getting mixed into one, or else you'll have distortion. To test, run : `speaker-test -c 2 -t sine`.

<!------------------------------->
# Attempt to disable vsync

Latest attempt to disable vsync

 * added /etc/X11/xorg.conf
   (this was automatically moved to /etc/X11/xorg.conf.02042015 after the
    incident with Optimus detailed below)
 * ccsm >> OpenGL >> Sync to Vblank off
   (this has been reverted)
 * (reboot)

Still no effect even when running vpatch.exe

 * In addition, went into BIOS and disabled Optimus and OS Detection for Optimus

This caused my actual refresh rate to drop to 30, even though
xrandr and Test UFO reported 60. (note: game reported 30)

After entering sleep mode and waking, Xorg hung. (no ctrl alt f2 even)
Computer had to be hard reset.

Balls to it.

<!------------------------------->
# Running `pcsx2`

* Found it easier to just download the prebuilt binary than to
  deal with i386 dev packages.

* On attempt to run, many "modules" will fail to load, listing
  their requirements. (you need 32-bit versions)

* There were a couple for which I had trouble locating the correct package:

      libCg.so
      libCgGL.so

  To remedy this, I borrowed them from Steam.

* An apparent runtime dependency...?:

       libcanberra-gtk-module

  (when not installed, it produces a message in the console output, though
   the program still appears to run.  Meh.)

* At this point, running the `launch_pcsx2_linux.sh` script brings up a
  configuration window, and so I'm calling it a night.

  (so I technically haven't confirmed it can play!)

<!------------------------------->
# (OUTDATED) Installing numpy and scipy

## Symptom

After setting the BLAS and LAPACK environment variables to point to the
 appropriate libxxx.so (or .a) files, running

    pip3 install scipy

may cause the system to appear to hang.

## Resolution

Wait 10 minutes.  No really.  It *is* compiling, and it *will* finish eventually.

If you're not convinced, run `top` and look carefully at the PID of the
install process, and notice how it keeps changing (presumably as each
individual file is compiled).

**NOTE:** For some reason it was ignoring the BLAS and LAPACK variables
on my ubuntu system

<!------------------------------->
# Installing numpy and scipy on matisse CORRECTLY!!

**(2015-05-27)**

When I actually tried running a sparse matrix linear solver
(scipy.sparse.linalg.factorized) with the above described setup
on matisse (RPI supercomputer) it ground to a halt.

I took a closer look at the directions in the example-site.cfg provided
in numpy's source, and figured out a way to link the (extremely effective)
atlas libs.

1. DO NOT bother setting any blas/atlas/lapack-related environment variables.
   DO NOT bother loading any modules.

2. DO bother finding out where libatlas' libraries are installed.  On matisse,
   I found them in /usr/lib64/atlas, but they didn't have any versionless
   symlinks (all were `.so.3` or `.so.3.0`, but the linker will only look
   for `.so`) so I had to make my own personal set of links to them without
   version numbers.

3. Make a file ~/.numpy-site.cfg.  The only lines I needed were

   ```ini
   [blas_opt]
   library_dirs = /home/lampam/data/local-install/lib
   libraries = ptf77blas, ptcblas, atlas

   [lapack_opt]
   library_dirs = /home/lampam/data/local-install/lib
   libraries = lapack, ptf77blas, ptcblas, atlas
   ```

   (`/home/lampam/data/local-install/lib`, of course, being the location of
   the linked `.so` files without version numbers)

4. Now you can use pip!

    pip install numpy

5. Before installing scipy (that takes forever), verify that numpy
    was able to find and link them correctly:

    ```text
    $ python3
    Python 3.4.3 (default, Apr  8 2015, 10:26:55)
    [GCC 4.8.1] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import numpy
    >>> numpy.__config__.show()
    atlas_threads_info:
        library_dirs = ['/data/lampam/local-install/lib']
        language = f77
        define_macros = [('ATLAS_INFO', '"\\"3.8.4\\""')]
        libraries = ['lapack', 'ptf77blas', 'ptcblas', 'atlas']

    [ ... snip ... ]

    blas_opt_info:
        library_dirs = ['/data/lampam/local-install/lib']
        language = c
        define_macros = [('ATLAS_INFO', '"\\"3.8.4\\""')]
        libraries = ['ptf77blas', 'ptcblas', 'atlas']
    atlas_blas_threads_info:
        library_dirs = ['/data/lampam/local-install/lib']
        language = c
        define_macros = [('ATLAS_INFO', '"\\"3.8.4\\""')]
        libraries = ['ptf77blas', 'ptcblas', 'atlas']
    lapack_mkl_info:
      NOT AVAILABLE
    ```

## Update 2015-09-15

If I ever want to make a full guide for building from scratch, it
is necessary to include how to build python.  Here's a start.

    MY_PREFIX=/data/$USER/anywhere-u-like

(and add that-path/bin to your PATH)
Download python source from website.

    tar -xzf Python-2.7.10.tgz
    cd Python-2.7.10
    ./configure --prefix=$MY_PREFIX
    make && make install

To install packages easily you want `pip`.
Python3 will automatically install it.
Python2 on the other hand appears to *include* it, but does not automatically install it.
To install pip after installing Python2.7 (from the command line):

    python -m ensurepip

## Update 2018-01-21: Python 3.7 trickiness

**Further updated 2018-08-13 due to even more insanity.**

### `libffi` trickiness
Building python on systems with custom install locations is now a bit trickier than before
now that cpython no longer bundles libffi as of 3.7.

#### Symptoms

`make` appears to succeed, but `make install` fails while trying to install pip:

```text
Traceback (most recent call last):
  File "/data/lampam/asd/clone/cpython/Lib/runpy.py", line 193, in _run_module_as_main
    "__main__", mod_spec)
  File "/data/lampam/asd/clone/cpython/Lib/runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File "/data/lampam/asd/clone/cpython/Lib/ensurepip/__main__.py", line 5, in <module>
    sys.exit(ensurepip._main())
  File "/data/lampam/asd/clone/cpython/Lib/ensurepip/__init__.py", line 204, in _main
    default_pip=args.default_pip,
  File "/data/lampam/asd/clone/cpython/Lib/ensurepip/__init__.py", line 117, in _bootstrap
    return _run_pip(args + [p[0] for p in _PROJECTS], additional_paths)
  File "/data/lampam/asd/clone/cpython/Lib/ensurepip/__init__.py", line 27, in _run_pip
    import pip
  File "/tmp/tmppxo4cj6h/pip-9.0.1-py2.py3-none-any.whl/pip/__init__.py", line 28, in <module>
  File "/tmp/tmppxo4cj6h/pip-9.0.1-py2.py3-none-any.whl/pip/vcs/mercurial.py", line 9, in <module>
  File "/tmp/tmppxo4cj6h/pip-9.0.1-py2.py3-none-any.whl/pip/download.py", line 36, in <module>
  File "/tmp/tmppxo4cj6h/pip-9.0.1-py2.py3-none-any.whl/pip/utils/glibc.py", line 4, in <module>
  File "/data/lampam/asd/clone/cpython/Lib/ctypes/__init__.py", line 7, in <module>
    from _ctypes import Union, Structure, Array
ModuleNotFoundError: No module named '_ctypes'
make: *** [install] Error 1
```

Searching the stdout and stderr of `make` reveals nothing unusual aside from this:

```text
INFO: Could not locate ffi libs and/or headers

Python build finished successfully!
The necessary bits to build these optional modules were not found:
_lzma                 _tkinter
To find the necessary bits, look in setup.py in detect_modules() for the module's name.


The following modules found by detect_modules() in setup.py, have been
built by the Makefile instead, as configured by the Setup files:
atexit                pwd                   time


Failed to build these modules:
_ctypes

running build_scripts
```

#### Explanation

The issue is threefold:

* `_ctypes` is not considered to be a critical component of cpython.
  This is why `make` reports success.
* Building `_ctypes` depends on libffi. (`ffi.h` and `libffi.so`)
* Even once libffi is installed,
  cpython's setup.py uses **unconventional means** to search for libffi,
  which will fail if you have it installed to a custom prefix.
  **`CPATH` and `{LD_,}LIBRARY_PATH` are not enough.**
  Instead:
  * When I initially wrote this section (which was probably on an unreleased
    3.7 alpha?), it looked at **`LDFLAGS` and `LIBFFI_INCLUDEDIR`** (see below).
  * **(update)** In a later attempt to build from the 3.7 release commit,
    I found that it no longer cares about env vars; it NEEDS them to be in the Makefile.

#### Resolution


##### Build and Install libffi
*Don't bother with the github repo* unless you know you have recent-ish autotools,
because the git-hosted source does not include the `configure` script.
Instead, download it from http://sourceware.org/libffi/ .

<!-- Maybe don't do this?

**Manually install libffi's binary (?):**
libffi's `make install` does not install the `libtool` binary,
which will have been written to a directory named after your target triple.
*I'm not sure if this is required,* but I manually installed this to preempt
any possible version mismatch issues caused by the existing libtool in /usr/bin.
-->

<!-- No longer applicable. (initial instructions (2018-01-21))

##### Set the specific env vars that `cpython` is looking for:

cpython's setup.py manually searches for libffi,
and *does not care about the typical environment vars!*
Instead, you must do the following:

```bash
# (note: this can all be done after ./configure)

# notice libffi doesn't put the header under PREFIX/include, but rather under PREFIX/lib
# where it is versioned.
export LIBFFI_INCLUDEDIR="/path/to/install-dir/lib/libffi-3.2.1/include"

# DO NOT PUT A SPACE AFTER -L.
# SETUP.PY ACTUALLY PARSES THIS.
export LDFLAGS="-L/path/to/install-dir/lib64 $LDFLAGS"
```
-->

##### Build cpython

To build the 3.7 release, you need to make sure that the Makefile definition
for `LDFLAGS` includes the right -L flag for libffi, and that `LIBFFI_INCLUDEDIR`
is properly defined.

These are accomplished by supplying the following variables to `configure`.

```sh
./configure --enable-optimizations --prefix=$HOME/local-install \
    CPPFLAGS="-I $HOME/local-install/lib/libffi-3.2.1/include" \
    LDFLAGS="-L$HOME/local-install/lib64"

make -j4 && make install
```

### `openssl`

If the python build fails due to an out-of-date OpenSSL, don't worry, it's easy to build.

**Git repo:** https://github.com/openssl/openssl

#### Versioning

Their versioning scheme is weird; instead of a patch number, they have a patch letter.
This means that `1.1.0h` is more recent than `1.1.0`.

**On komodo:** I deliberately built an outdated `1.0.2o` release to avoid having to update Perl.

#### Building it shared

The default is to build a static lib, but that gave me the following when I tried to build cpython:

```
gcc -pthread -fPIC -Wsign-compare -DNDEBUG -g -fwrapv -O3 -Wall -std=c99 -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Werror=implicit-function-declaration -fprofile-use -fprofile-correction -DMODULE_NAME="sqlite3" -DSQLITE_OMIT_LOAD_EXTENSION=1 -IModules/_sqlite -I/usr/include -I./Include -I/home/lampam/local-install/include -I. -I/home/lampam/local-install/lib/libffi-3.2.1/include -I/usr/local/include -I/data/lampam/build/cpython/Include -I/data/lampam/build/cpython -c /data/lampam/build/cpython/Modules/_sqlite/connection.c -o build/temp.linux-x86_64-3.7/data/lampam/build/cpython/Modules/_sqlite/connection.o
/data/lampam/build/cpython/Modules/_sqlite/connection.c: In function ‘_pysqlite_connection_begin’:
/data/lampam/build/cpython/Modules/_sqlite/connection.c:387: error: implicit declaration of function ‘sqlite3_prepare_v2’
/data/lampam/build/cpython/Modules/_ssl.c: In function ‘PySSL_get_context’:
/data/lampam/build/cpython/Modules/_ssl.c:6024: note: file /home/lampam/build/cpython/build/temp.linux-x86_64-3.7/data/lampam/build/cpython/Modules/_ssl.gcda not found, execution counts estimated
gcc -pthread -shared -L/home/lampam/local-install/lib64 build/temp.linux-x86_64-3.7/data/lampam/build/cpython/Modules/_ssl.o -L/usr/kerberos/lib64 -L/home/lampam/local-install/lib -L/home/lampam/local-install/lib64 -L/usr/local/lib -lssl -lcrypto -ldl -lz -o build/lib.linux-x86_64-3.7/_ssl.cpython-37m-x86_64-linux-gnu.so
/usr/bin/ld: /home/lampam/local-install/lib64/libssl.a(s3_meth.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
/home/lampam/local-install/lib64/libssl.a: could not read symbols: Bad value
```

To resolve this, two flags should be added to the config script.

```
./config -fPIC shared --prefix=$HOME/local-install
```

### cython trickiness

#### Symptom

`pip install numpy` fails with

```
numpy/random/mtrand/mtrand.c:45541:22: error: ‘PyThreadState’ has no member named ‘exc_type’
     tmp_type = tstate->exc_type;
                      ^
numpy/random/mtrand/mtrand.c:45542:23: error: ‘PyThreadState’ has no member named ‘exc_value’
     tmp_value = tstate->exc_value;
                       ^
numpy/random/mtrand/mtrand.c:45543:20: error: ‘PyThreadState’ has no member named ‘exc_traceback’
     tmp_tb = tstate->exc_traceback;
                    ^
numpy/random/mtrand/mtrand.c:45544:11: error: ‘PyThreadState’ has no member named ‘exc_type’
     tstate->exc_type = local_type;
           ^
numpy/random/mtrand/mtrand.c:45545:11: error: ‘PyThreadState’ has no member named ‘exc_value’
     tstate->exc_value = local_value;
           ^
numpy/random/mtrand/mtrand.c:45546:11: error: ‘PyThreadState’ has no member named ‘exc_traceback’
     tstate->exc_traceback = local_tb;
           ^
error: Command "gcc -pthread -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes -fPIC -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE=1 -D_LARGEFILE64_SOURCE=1 -Inumpy/core/include -Ibuild/src.linux-x86_64-3.7/numpy/core/include/numpy -Inumpy/core/src/private -Inumpy/core/src -Inumpy/core -Inumpy/core/src/npymath -Inumpy/core/src/multiarray -Inumpy/core/src/umath -Inumpy/core/src/npysort -I/home/lampam/data/local-install/include/python3.7m -Ibuild/src.linux-x86_64-3.7/numpy/core/src/private -Ibuild/src.linux-x86_64-3.7/numpy/core/src/npymath -Ibuild/src.linux-x86_64-3.7/numpy/core/src/private -Ibuild/src.linux-x86_64-3.7/numpy/core/src/npymath -Ibuild/src.linux-x86_64-3.7/numpy/core/src/private -Ibuild/src.linux-x86_64-3.7/numpy/core/src/npymath -c numpy/random/mtrand/mtrand.c -o build/temp.linux-x86_64-3.7/numpy/random/mtrand/mtrand.o -MMD -MF build/temp.linux-x86_64-3.7/numpy/random/mtrand/mtrand.o.d" failed with exit status 1
```

#### Explanation

Python 3.7 removed some private data members, and code generated by cython 0.26 tries to access them.

This is fixed on the cython master branch.

#### Resolution

By the next time I read this text, the fix will probably already be released.

But in case it still isn't:

- You could install python 3.6 instead.

- What I did was keep the bad installation dir from pip,
and regenerate the offending C file with cython built from master.

```sh
TMPDIR=./tmp pip3 install numpy --no-clean
cd tmp/pip-build-thzr3yxe/numpy

# regenerate using cython built from git master
cython --version # make sure it's 0.28a or later
rm numpy/random/mtrand/mtrand.c
cython numpy/random/mtrand/mtrand.pyx

# install numpy with this correction
pip3 install . --upgrade
```

Scipy will have a similar problem with many files.

```sh
TMPDIR=./tmp pip3 install scipy --no-clean
cd tmp/pip-build-dr5ywmqe/scipy

# cythonize will refuse to regenerate some files until you delete this
rm cythonize.dat

pip3 install Tempita
python3 tools/cythonize.py  # regen everything with the correct flags
pip3 install . --upgrade
```

### `openssl` certification problems when using `pip` on komodo (2018-08-13)

```
Collecting bottleneck
  Downloading https://files.pythonhosted.org/packages/05/ae/cedf5323f398ab4e4ff92d6c431a3e1c6a186f9b41ab3e8258dff786a290/Bottleneck-1.2.1.tar.gz (105kB)
    100% |████████████████████████████████| 112kB 3.0MB/s 
    Complete output from command python setup.py egg_info:
    Download error on https://pypi.python.org/simple/numpy/: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1045) -- Some packages may not be found!
    Couldn't find index page for 'numpy' (maybe misspelled?)
    Download error on https://pypi.python.org/simple/: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1045) -- Some packages may not be found!
    No local packages or working download links found for numpy
```

...*Sigh.* Yeah, looks like my method of building/installing libssl was not quite right?

Things I tried:

* Making doubly-damn sure my newly built `libssl` was linked right (checking cpython build output for -L flags, checking `LIBRARY_PATH/LD_LIBRARY_PATH`, etc.)
* Adding `--trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org` to the pip call
* Copying over files that appeared to be missing from `<ssl-install-prefix>/ssl`. (the contents of `ssl/certs`, and `ssl/cert.pem`.  I used `rsync -Lr` to resolve symlinks when copying from my Arch Linux's `/etc/ssl`)
* Doing the above, and additionally supplying `--cert $HOME/local-install/ssl/cert.pem` to pip.
* Triple checking the location of every single executable involved in the invocation of pip

None of it appeared to have any effect at all; I still have the exact same error message.  So I'm just going to have to copy over individual packages and install them manually.  Ho, hum.

(These kind of twilight zone issues where nothing ever changes are usually a sign of serious PEBKAC... but merely knowing it's probably my fault isn't enough to help me find it!)

### 'h5py' trickiness

attempt to install `h5py` ends with

```
      File "/home/lampam/data/local-install/lib/python3.7/site-packages/setuptools/command/bdist_egg.py", line 355, in analyze_egg
        safe = scan_module(egg_dir, base, name, stubs) and safe
      File "/home/lampam/data/local-install/lib/python3.7/site-packages/setuptools/command/bdist_egg.py", line 395, in scan_module
        symbols = dict.fromkeys(iter_symbols(code))
      File "/home/lampam/data/local-install/lib/python3.7/site-packages/setuptools/command/bdist_egg.py", line 414, in iter_symbols
        for name in code.co_names:
    AttributeError: 'bool' object has no attribute 'co_names'
```

and it is at this point I said "fuck it"

<!------------------------------->
# VIM CommandT plugin

For searching files

(get pathogen first; it lets you install vim plugins by cloning
 an appropriately-structured repo into .vim)

```sh
sudo apt-get install rake ruby-dev

cd ~/.vim/bundle
git clone https://github.com/wincent/command-t.git

cd command-t
git submodule init
git submodule update

make

cd ruby/command-t
ruby extconf.rb
make
```

I also had trouble with another plugin (TaskList) stealing the `<Leader>t`
keybind.  The solution was to explicitly map something to `<Plug>TaskList`
in `~/.vimrc` (`:TaskList<CR>` won't do), as `TaskList` only sets its own
default keybinds when the user hasn't set one.

<!------------------------------->
# INPUT/OUTPUT ERROR (bad blocks)

(**2015-05-24**)

The night before finishing my backup scripts (the irony), my laptop incurred
a small fall, and a couple of files on my SSD had become compromised by bad
blocks (whether or not these two events are actually related is anyone's
guess!).  This caused a number of tools to spit out the phrase "Input/output
error" when attempting to read certain files, including `rsnapshot` (which
ran the day prior with zero errors).

(note this was from a 1 foot drop onto a carpeted floor. Clearly I should
 have dropped it from a 3rd story building instead!
 https://youtu.be/j4cK0L__B9U )

Here is how I identified and dealt with them.

## Identifying bad blocks

Bad blocks can be identified with the tool `badblocks`. The affected drive
must be unmounted (this means booting via a live USB if the affected
filesystem is /).

You must supply `badblocks` with an appropriate block size (or prepared to
convert the numbers it gives you!)  To determine your drive's block size:

```text
# tune2fs -l /dev/sdXY | grep Block
Block count:              61035008
Block size:               4096
Blocks per group:         32768
```

Supply it with the `-b` option to `badblocks`:

```sh
badblocks -vs -b 4096 -o badblocks.log /dev/sdXY
```

(`-s` gives a progress meter, `-v` is verbose)

## Identifying owners of bad blocks

(it is okay for the drive to be mounted during this)

THE FOLLOWING IS FOR ext2/ext3/ext4 FILESYSTEMS ONLY.
You can find the corresponding inodes and files via `debugfs`, which works
like an interpreter.  The command `icheck` maps blocks to the inodes that
own them, while `ncheck` maps inodes to files.

```text
# debugfs
debugfs 1.41.3 (12-Oct-2008)
debugfs:  open /dev/sdc1
debugfs:  icheck 15757325 15757340 15765044 15765082 15765209 16093175
Block	Inode number
15757325	3542957
15757340	3542957
15765044	3934205
15765082	3934229
15765209	3934333
16093175	3156031
debugfs:  ncheck 3542957 3542957 3934205 3934229 3934333 3156031
Inode	Pathname
3156031	/usr/lib/llvm-3.4/lib/libLLVMAnalysis.a
3542957	/usr/local/lib/python2.7/dist-packages/numpy/core/multiarray.so
3542957	/usr/local/lib/python2.7/dist-packages/numpy/core/multiarray.so
3934205	/usr/share/doc/mousetweaks/NEWS.gz
3934229	/usr/share/doc/nano/faq.html
3934333	/usr/share/doc/openssh-client/faq.html
```

## Resolving the badblocks

In my case, all the bad blocks above are in files that belong to programs
which could be reinstalled, so I reinstalled them
(`sudo apt-get install --reinstall`, `sudo pip2 install --force --upgrade`),
causing new versions to be written into healthy blocks.

I checked `debugfs` to watch the blocks become unused.  To my surprise, a
couple were re-used by the "updated" files.  I'm not too sure how to
interpret this; perhaps those blocks may have been healthy after all (they
just needed to be written to again).  Or maybe the device remapped them to
safe blocks at an even lower level than is visible in these tools.  I'm
not sure how it all works. :P

(I plan to check by running badblocks again, but I can't promise I'll
 come back to update this)

## UPDATE 2016-05-01

Something kind of funny:  Take a look at this failed file list:

```text
ERROR: home/lampam/Dropbox/ARTZ/FMBA/[LonE]_Nakagawa_Shoko_-_Fullmetal_Alchemist_Brotherhood_ED5_Single_-_RAY_OF_LIGHT_[w_scans]_(FLAC)/Scans/05.jpg failed verification -- update discarded.
ERROR: home/lampam/dd-vaspruns/true-relax/WHAT-IS-WRONG/All-0.1-1e-5-1e-4-5/1.27/stubborn-workdir/WAVECAR failed verification -- update discarded.
ERROR: home/lampam/dd-vaspruns/true-relax/WHAT-IS-WRONG/Damped-0.4-1e-5-1e-4-0/1.27/stubborn-workdir/WAVECAR failed verification -- update discarded.
```

Interesting how two of the paths are so similar.  Not sure what to make of it... pure coincidence?

<!------------------------------->
# Installing git on komodo

(**2015-05-26**)

**(FAILED ATTEMPT - KEPT FOR HISTORICAL PURPOSES ONLY)**

A naive build from source with no special flags resulted in this:

    [lampam@komodo build]$ git clone https://github.com/ExpHP/circuit.git
    Cloning into 'circuit'...
    fatal: Unable to find remote helper for 'https'

Had to build libcurl.

## building `libcurl`

**HUGE P.S.:** I just now noticed `/usr/local` on matisse doesn't have anything
in it, so the ssl flag below only enabled ssl (without correctly specifying
which copy to link).  I *intended* to set `--with-ssl=/usr`, as that appeared
to be the newest copy.

Configured curl with the following:
(not sure if `ssl` was required for `git`.
 The `./buildconf` instruction is mentioned in a file called `GIT-INFO`)

    # after unpacking a source archive from https://github.com/bagder/curl
    cd curl-master
    ./buildconf
    ./configure --prefix=/home/lampam/data/local-install --with-ssl=/usr/local

Building eventually resulted in this error:

    gcc -DHAVE_CONFIG_H -I../include/curl -I../include -I../include -I../lib -I../lib -DBUILDING_LIBCURL -DCURL_HIDDEN_SYMBOLS -I/usr/kerberos/include -fvisibility=hidden -O2 -Wno-system-headers -MT libcurl_la-openssl.lo -MD -MP -MF .deps/libcurl_la-openssl.Tpo -c vtls/openssl.c  -fPIC -DPIC -o .libs/libcurl_la-openssl.o
    vtls/openssl.c: In function 'ssl_msg_type':
    vtls/openssl.c:1490: error: 'SSL3_MT_NEWSESSION_TICKET' undeclared (first use in this function)
    vtls/openssl.c:1490: error: (Each undeclared identifier is reported only once
    vtls/openssl.c:1490: error: for each function it appears in.)

RESOLUTION was -- and I kid you not -- opening `vtls/openssl.c`, finding the
 line for `#include <openssl/ssl.h>` and adding `#include <openssl/ssl3.h>`
 under it.  (apparently, some versions of the `ssl` library include `ssl3.h`
 from `ssl.h`.  This one evidentally doesn't.)

## building `git`

If you have already built a (non-working) version of `git`, you MUST `make clean` before continuing:

    make clean

    # in an unpacked source archive from https://github.com/git/git
    ./configure --prefix=/home/lampam/data/local-install --with-curl=/home/lampam/data/local-install
    make && make install

(NOTICE: I spotted the following warnings during the build.  Probably something easily addressed, but
 I'm not too worried as git seems to be working fine regardless)

    /usr/bin/ld: warning: libssl.so.1.0.0, needed by /home/lampam/data/local-install/lib/libcurl.so, may conflict with libssl.so.6
    /usr/bin/ld: warning: libcrypto.so.1.0.0, needed by /home/lampam/data/local-install/lib/libcurl.so, may conflict with libcrypto.so.6

Using `git` afterwards required this:

    LD_LIBRARY_PATH=/cm/local/apps/openssl/lib64/

**Update:** It doesn't work.
`git clone` says it is cloning but then simply does nothing and returns.

The version of ssl in `/usr` is actually not the most recent. (`ssl3.h` for
that version lacks `SSL3_MT_NEWSESSION_TICKET`!!!).  So you do want to link
against the one in `/cm/local/apps/openssl/lib64/` from the start.

But even with that modification, the steps above still don't produce
a working copy of `git`.  I give up.

<!------------------------------->
# Laptop not entering sleep mode

**(2015-06-11)**

some tags: sleep, ThinkPad

Finally found it!!!!!!!!!!!!!

The issue is with the module `e1000e` (for the networking card).
I found it is sufficient to simply restart it.  I.e.

    sudo rmmod e1000e
    sudo modprobe e1000e

**EDIT:** oops, looks like I already found this out (it's one of the first entries in this file!)

**NOTE TO SELF:** Don't just write documentation.  **_Use it!!!_**

<!------------------------------->
# `unison` version antics

**(2015-08-03)**

Because unison versions on both hosts must match (and putting it on the
remote servers involves laboriously compiling it on every machine), I
marked the `unison` and `unison-gtk` packages as held at version 2.40.102.

## Additional notes (2015-08-15)

Not only must the version of `unison` match, but they must be built
against the same version of `ocaml` as well!

**On remote computer:**
 - Go check what versions of ocaml/unison are available on the repos for your own computer first to make
   life easier; Building the gtk client on your own is unfun.
 - ocaml: go to https://ocaml.org/releases/, pick a version, page has direct link to a source tarball.
   ```sh
   ./configure -prefix /where/to/install
   make world.opt
   make world      # added 28 Jan 2016; see note below
   make install
   ```
   (NOTE: according to the ocaml docs, world.opt is intended to be equivalent to
    "make world opt opt.opt"

 - unison: go to http://www.cis.upenn.edu/~bcpierce/unison/download.html, the buttons underneath
   "official releases" point to file-serving pages from which a tarball is available.
   ```sh
   make UISTYLE=text
   ```

**On own computer:**
 - If at all possible, get from the repos instead (but ocaml/unison versions MUST match the servers).
   But if you must build it, you need...

 - ocaml: see above for On Server

 - camlp4: https://github.com/ocaml/camlp4
    need to checkout a branch corresponding to ocaml version
       make all
       make install

 - lablgtk2: http://lablgtk.forge.ocamlcore.org/
  I think lablgtk2 is sensitive to ocaml version as well, but so far as I can tell the only way to
  figure out the right version is to scour the changelog (linked underneath the latest source download).
  You're on your own here. When I built 2.14 with ocaml 4.02, there was no indication of any issue at
  all until I finished compiling unison and ran it (at which point it segfaulted)
    `make` target is `world`

    * NOTE: I needed libgtk2.0-dev (NOT libgtk-3-dev)
    * NOTE: (28 Jan 2016) When I tried following these notes, I got
        configure: error: Cannot find camlp4o
      and saw that /usr/local/camlp4o.opt exists but not /usr/local/camlp4o .
      * No, you can't fix this with a symlink. (camlp4o "doesn't know what to do with xxx.cmo")
      * The following did work for me:
           - go to ocaml build dir, 'make world' and 'make install'
           - go to camlp4 build dir, './configure', 'make', 'make install'
        After which /usr/local/camlp4o exists.
      * So contrary to what the ocaml docs say, I do not believe 'make world.opt' includes
         'world' (and if you look at the Makefile, it doesn't; at least not directly...)

 - unison: `make`
    The very first line it prints will be `UISTYLE = gtk2` if the right dependencies were met,
    or `UISTYLE = text` otherwise.
   (if you build it yourself like this, the binary will be `unison`, not `unison-gtk`)
   * DON'T BE ROOT for `make install` as it defaults to $HOME/bin, surprisingly


## Update 2016-01-28
On my desktop PC I had to move the unison binaries afterwards from ~/bin to
/usr/local/bin, because otherwise I would get 'bash: unison: command not found' when
attempting to connect to the PC remotely with unison. I haven't the slightest idea why,
though, because it works just fine on the supercomputers (maybe they have a setting that
causes .bashrc to get sourced whereas my desktop pc doesnt?)

<!------------------------------->
# ssh hosts

**(2015-08-03)**

Host aliases for ssh go in `.ssh/config`, which I keep in the data dir here.

## Update (2016-01-20)

For reliably connecting to computers on the local network, give them static IPs. See below.
(while you CAN just use their hostnames under certain (unknown) conditions, I found that it is
 possible for the hostname to instead resolve to the router's outward, internet-facing IP)

<!------------------------------->
# Setting a static IP

**(2016-01-20)**

**Update:** The section on DHCP reservation may be a better alternative.

**Note added 2018:** Take this section and the DHCP section with a grain of salt.
I recall that I never got this to work satisfactorily.

Static IPs and DHCP can in fact coexist!  This is because DHCP only assigns from a limited range.
You can safely choose any address in the local subnet except for the following:

    192.168.1.0      - This identifies the subnet as a whole
    192.168.1.100-49 - These are the DHCP addresses
    192.168.1.255    - Broadcast address

In the Edit Connection dialog for your SSID, under the "IPV4 Settings" tab, set Method = Manual,
and address to whatever you want (given the restrictions above).
Netmask is the subnet mask (255.255.255.0).
Gateway is the router's local IP (at least, that's what I used and it works...).

There's a confusing checkbox on the page about forcing IPv4 (the label and the hover tooltip seem
to give contradictory descriptions). I left it in its default state (which was unchecked).

NOTE: Even using DHCP, websites that test IPv6 connectivity report that I am unable to use IPV6,
regardless of the state of this checkbox. No idea what's up with that.

<!------------------------------->
# Static IPs through DHCP

**(2016-02-01)**

On some routers it is in fact possible to assign a static IP through DHCP.  This is
known as a "DHCP reservation".  This causes the router to assign a fixed IP to a single
device by MAC address.  Compared to static IPs, this obviously has the advantage that
the router is actually involved in the process.

On the FiOS ActionTec router, one can configure a static connection through DHCP by going to

1. Connect the device to the router normally using DHCP.
2. Go to the router config page
3. Advanced >> Routing >> IP Address Distribution >> Connection List
4. Click the edit button on the right next to your device.
5. Check the box labeled "Static Lease Type", hit Apply. (if you want a different IP
   other than the one currently active, hit Apply anyways then click the Edit button
   again; after doing so, it will be possible to edit the IP field)

<!------------------------------->
# DNS notes

**(2015-09-05)**

Editing `/etc/resolvconf/resolv.conf.d/base` did not work for me.

I decided to do it in the Edit Connections window.  Edit the connection
for your SSID, go to IPv4, change mode to "DHCP (Addresses only)", and
set DNS servers "8.8.8.8,4.4.4.4".

<!------------------------------->
# Passwordless login to servers

**(2015-09-10)**

```sh
ssh-keygen
ssh-copy-id user@server
```

Greatest thing ever.

**NOTE:** This works for github as well.
Just make sure your remotes use "ssh://git@github.com" instead of "https://github.com".

<!------------------------------->
# Hibernation

**(2015-09-23)**

keywords: ubuntu, hibernation, thinkpad

To my understanding, hibernation is only enabled by default for a whitelist
of laptops which are known to not have trouble waking from hibernation.
It must be explicitly reenabled on others.

The method to reenable it seems to keep changing between versions of Ubuntu,
so I won't mention anything here.

Also, for some versions of ubuntu, the battery level defined as "critical" is
REDICULOUSLY LOW; it only starts trying to hibernate/shutdown at about 2%
battery (which typically doesn't end well).  In 14.04, this can be adjusted
via `dconf-editor` under `org.gnome.settings-daemon.plugins.power`.

## Addendum 2015-10-07

ALSO ALSO ALSO!!!
At the bottom of that same page,
note that there is 'use-time-for-policy' which defaults to ON.
When it is ON, it ignores 'percentage-action' and uses 'time-action' instead.

# vim and python 3

**(2015-10-16)**

**TODO:** FINISH!!!!!!!

    git clone https://github.com/b4winckler/vim
    ./configure \\
      --enable-perlinterp \\
      --enable-rubyinterp \\
      --enable-cscope \\
      --enable-gui=auto \\
      --enable-gtk2-check \\
      --enable-gnome-check \\
      --with-features=huge \\
      --enable-multibyte \\
      --with-x \\
      --with-compiledby="xorpd" \\
      --enable-python3interp \\
      --enable-luainterp \\
      --enable-tclinterp \\
      --with-python3-config-dir="$(python3-config --configdir)" \\
      --prefix=/opt/vim-py3
    sudo update-alternatives --install /usr/bin/vim vim /opt/vim-py3/bin/vim 100

<!------------------------------->
# Compiling vasp: BGQ edition

**(2015-10-30)**

I used Makefiles provided by Neerav;  (**TODO:** put in files)

The necessary compilers on BGQ are provided by the `xl` module, but there
are two options: standard `xl`, and a 'thread safe' version `xl_r` required
for parallel code ('r' stands for reentrant).

For building `vasp.5.lib`, used `module load xl`.
(this is what Neerav said he used as well)
Neither him nor I have tried building exclusively with the `xl_r` module.

On first compilation attempt for the libs, I got this:

    $ make
    cpp -P -C   preclib.F >preclib.f90
    mpixlf90   -O3 -qstrict -qfree=f90 -qhot -qarch=qp -qtune=qp   -c -o preclib.o preclib.f
    "preclib.f", line 8.6: 1514-220 (S) Module symbol file for module preclib.mod is in a format not recognized by this compiler. Please compile the module with this compiler.
    ** preclib   === End of Compilation 1 ===
    1501-511  Compilation failed for file preclib.f.
    make: *** [preclib.o] Error 1

When building the libs, `make` produced an error about `preclib.mod` having
an unrecognized format. This appears to be because I grabbed the source from
code previously built elsewhere (and `make clean` doesn't remove this file).
*Simply renaming `preclib.mod` resolved the error.* (and yes, a new one was
generated during compilation)

Don't need to do anything with the built libs other than have `vasp.5.3.3/`
and `vasp.5.lib/` in the same directory; the vasp5.3 Makefile uses relative paths
for locating the libs, and links them statically. I think.

Before building vasp, `module unload xl` and `module load xl_r`

There are, in fact, syntax errors in the source files which may need to be
corrected. Perhaps these go uncaught due to 'quirks' which differ between our compiler
and the ones used by the vasp crew. (makes me just a bit worried about how many
such quirks cause changes in behavior which DO get compiled...)

(November 13: 2015:  em, looks like I got interrupted there...  In any case, the modifications
 that need to be made to the source files are not that hard to figure out.  Also, IIRC there is
 a step near the end where xl_r causes problems again and you can do the rest with xl.  But I
 might be getting it confused with the vasp 5.4 build process...)

<!------------------------------->
# Interactive plots in matplotlib

**(2015-09-13)**

a.k.a. HOLY SHIT THEY EXIST (and they have for a... long time)

But not without a little bit of work, first (at least for python3 users).

```python
import matplotlib.pyplot as plt
plt.ion()
fig,ax = plt.subplots()
```

After this, *a figure window should now be open*.
Of course, I found that while it worked fine on Python2, *it did not work for me on Python 3*.

Insofar as I can tell, this is because `matplotlib` was set up to use `tk` bindings in Python 2,
but to use `gtk3` bindings in Python 3.

To resolve this issue, install the header files for `tk`, and build `matplotlib` from source.

```sh
sudo apt-get install tk-dev
git clone https://github.com/matplotlib/matplotlib
cd matplotlib
sudo python3 setup.py install
```

After doing so, I found that `matplotlib` still defaults to `gtk3` in Python 3... fixing this
requires either invoking `plt.switch_backend('TkAgg')`, or, even better, you can use `ipython`:

    $ ipython3
    In [1]: %matplotlib tk
    In [2]: import matplotlib.pyplot as plt
    In [3]: fig,ax = plt.subplots()

and there's probably a config file somewhere you can modify to change the default but who cares.
...scratch that, I do care, so I found this (your path may vary):

    /usr/local/lib/python3.4/dist-packages/matplotlib-1.5.0_342.g5ac32f3-py3.4-linux-x86_64.egg/matplotlib/mpl-data/matplotlibrc

Copy it to `~/.config/matplotlib/matplotlibrc`, fix the backend line to TkAgg, done.

<!------------------------------->
# Vesta crashes on poscar file

**(2015-10-22)**

**keywords:** vesta, hang, locks up, disk thrashing, poscar

If your file extension is ".poscar", change it to ".vasp".
This is for two reasons:
 * vesta crashes whenever an invalid file extension contains "sca", instead of
   erroring on an unknown extension
   (I can only imagine that this has to do with the fact that it supports a
    filetype with extensions ".sca" and ".scat", and probably does a substring
    search for "sca" to catch both)
 * it wouldn't recognize ".poscar" as an extension anyways, even if it didn't
    crash!

For now I have a wrapper script for vesta which checks for this mistake and
refuses to run.

<!------------------------------->
# aptitude flat list

**(2016-01-14)**

One of the things that always bothered me about aptitude was how packages can be
listed in more than one section, causing them to appear multiple times (which can
easily throw you off while searching by making you think you've already looped
through the whole list).

Just today I realized that there is a setting under `Options >> Preferences`
 labeled `Display flat view instead of default view on startup`.

Greatest thing ever.

<!------------------------------->
# My desktop PC and langauge packs

**(2016-01-18)**

So today I finally decided to re-look into the issue of why my Windows 7
desktop computer is stuck in Japanese, because I had forgotten the details.
This time, I'll record my findings:

* The reason I cannot find language packs in Windows Update is because the
  PC has Windows 7 Professional Edition.  Language packs require
  Windows 7 Ultimate Edition.
  (this is, of course, also the reason Microsoft does not provide a download
   for the English language pack on their website)

* How did I get it into Japanese in the first place?  To be honest...
  I have no clue!  I can only imagine that it must've involved reinstalling
  the OS...!

* In other words, my computer is stuck in Japanese pending me finding the
  installation disk and reinstalling the OS in English.  Fun.

<!------------------------------->
# Fuck multiarch on ubuntu

**(2016-01-19)**

The title was "fuck wine", but I think we all know the true cause of my pain here...

This is my... what is it now, 5th attempt to build wine from source on a 64-bit system?
As always, it ends in tragedy.

Found this: https://wiki.winehq.org/Building_Biarch_Wine_On_Ubuntu

Followed it more or less to the letter, dependencies aside.  That is:

```sh
# assuming all the build-deps for wine are installed on both your system, as
#  well as a 32-bit lxc named my32bitbox:
# PART 1:  Setup and building 64 bit
cd ~/build
mkdir wine
git clone git://source.winehq.org/git/wine.git wine-src
mkdir build-wine64
mkdir build-wine32-tools
mkdir build-wine32-combo
cd build-wine64
../wine-src/configure --enable-win64
make -j9

# PART 2:  Working inside the LXC
sudo lxc-start -nmy32bitbox

cd build/wine/build-wine32-tools
../wine-src/configure
make -j9

cd ../build-wine32-combo
../wine-src/configure --with-wine64=../build-wine64 --with-wine-tools=../build-wine32-tools
make -j9
sudo make install      # to force some additional bits of compilation

sudo shutdown -h now   # to exit the lxc
```

At this point, the guides say it is time to `make install` on your real system,
first in `build-wine32-combo`, then in `build-wine64`.
This may have been true at some point in time, but it is no longer.

If you try to do `make install` on wine32-combo,
then a command in the makefile will automatically regenerate a single source file,
`lib/wine/version.c`, causing a recompilation of `version.o` (in 64 bit!),
and re-linkage of linwine.so (which now complains very loudly about how we are
mixing 64 bit and 32 bit!!).

Thus, we must prevent the extraneous update to version.c.

```sh
# PART 3:  Additional hack number 1
cd ~/build/wine/build-wine32-combo
cp libs/wine/Makefile{,.bak}  # make a backup
vim libs/wine/Makefile
# find the line
#    version.c: dummy
# and change it to
#    version.c:
```

You may want to revert this change after you install it successfully.
But we're not done yet!  If you try to install it now, it still dies on the following command:


    ./../build-wine32-tools/tools/winebuild/winebuild  -w --def -o dlls/dinput/libdinput.def --export ../wine-src/dlls/dinput/dinput.spec

with a 'command not found' error.  This is because './../build-wine32-tools/tools/winebuild/winebuild'
is an ELF32 executable.  Certainly however this line already served its purpose when we built and
installed inside the LXC, so we can simply prevent this line from running as well.

... but because I'm not sure precisely WHY it's running, we'll just comment it out.

```sh
# PART 4:  Additional hack number 2
$ vim Makefile
# Search for 'libdinput.def'
# Find the matching line that begins with $(WINEBUILD)
# Insert a hash ('#') between the tab and the $.

# PART 5:  The true installation
# Do 32-bit first:
cd ~/build/wine/build-wine32-combo
sudo make install
cd ../build-wine64
sudo make install
```

One more thing... we need the 32 bit libraries that wine depends on in 64bit!

If you have previously installed wine from the repos, you will already have them.  If not,
here's a moderately easy yet moderately tedious way to get them:

(FIXME: actually I could've sworn there's a one-liner for doing this)

0. sudo apt-get update && sudo apt-get upgrade  (to avoid encountering extraneous conflicts)
1. sudo aptitude
2. select wine
4. hit 'g'
5. deselect the things with 'wine' in the name at the end of the list
6. now manually go back up the list and reselect all the things that don't have 'wine' in the name.

(amusingly, when I did this, I left out step 0, and encountered a conflict when selecting wine.
 The first suggestion involved uninstalling 10 packages, including linear algebra packages that
   my research depends heavily on.
 The second suggestion was to install 1 update.)

**...Alas, this build is still not 100% successful!!!**

I tested it on Remar's Herocore.

**The game was capable of:**

* Producing a window (this alone is an achievement well beyond any of my previous builds)
* Displaying a splash image on load
* Capturing the mouse
* Going fullscreen
* Setting the titlebar text
* Responding to keyboard input (F4 toggles fullscreen, F12 closes)

**It was not capable of:**
* Displaying any graphics.  (the entire window was black)
* Producing any audio.  (Nor could Wine itself, when clicking the Test button in winecfg)

So while the game did appear to be, for all intents and purposes, *ACTUALLY RUNNING!!!!*...
it was completely unplayable.

...back to Windows it is, I suppose...

<!------------------------------->
# GRUB CONFIGURATION FROZE, AAHHHHHHH!!!!

**(2016-01-25)**

Here's some nightmare fuel for you:

* Picture that, one day, you run a routine apt-get upgrade (or Update Manager),
  and you notice that things are taking a while.  The last messages you see are

  ```
  ...
  Generating grub configuration file ...
  Found memtest86+ image: /boot/memtest86+.elf
  Found memtest86+ image: /boot/memtest86+.bin
  Found Windows 7 (loader) on /dev/sda1
  Found MS-DOS 5.x/6.x/Win3.1 on /dev/sdb1
  █
  ```

  where the '█' indicates a blinking cursor that is quite emphatically *not* proceeded
  by a bash prompt.

* When you are done screaming and running around in circles, check if you have a USB flash drive
  inserted; perhaps some terrible one you got from an event, which has an awful, indestructible
  partition hidden on it which is supposed to open a website when you insert the drive in Windows.
  (man, screw those people)
* Unmount said drive and remove it. (also burn it)
* Hopefully, the configuration should have now finished.  If not... good luck.

For future reference, here is how I determined that the flash drive was the issue:

```sh
ps faux
```

The 'f' flag is something wonderful I never knew about; it prints a process FOREST!
With this, I was able to locate the guilty processes: (edited for width)

```
root  23395  | \_ run-parts --verbose --exit-on-error --arg=3.16.0-59-generic --arg=/boot/vml
root  25685  |     \_ /bin/sh /usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg
root  26710  |         \_ /bin/sh /etc/grub.d/30_os-prober
root  26714  |             \_ /bin/sh /etc/grub.d/30_os-prober
root  26715  |                  \_ /bin/sh /usr/bin/os-prober
root  27292  |                 |   \_ /bin/sh /usr/lib/os-probes/50mounted-tests /dev/sdc1
root  27373  |                 |       \_ grub-mount /dev/sdc1 /var/lib/os-prober/mount
root  26716  |                 \_ tr   ^
root  26717  |                 \_ paste -s -d
```

The line which should stand out here is the one ending in 'sdc1'.
A quick `ls -l /dev/disk/by-id` revealed that /dev/sdc is the flash drive.

...Unfortunately, this was only after I had already killed several update-related processes
in an attempt to make it possible to unlock the dpkg lock file so I could follow
the steps here: (DON'T!!!)

[Don't follow these steps](http://askubuntu.com/questions/703590/got-stuck-when-updating-from-15-04-to-15-10-generating-grub-config-file).

My discovery of the 'ps f' flag was because I wanted some sort of idea with regards to which
of the processes involved would be safest to kill.

If you want to test your grub configuration after all is done, you can try this:

```sh
sudo apt-get install grub-emu
grub-emu
```

This will at least let you see the list.  Fair warning: I personally found that I was unable
to use the keyboard in grub-emu, which sucks because AFAICT the only proper way to exit it is
to 'c' for a command line and type 'reboot'.  It also is unresponsive to SIGTERM, so I had to
`kill -9` it.  Ick...

<!------------------------------->
# SSHD more securely

**(2016-01-28)**

There are a number of things you can do to make port forwarding to SSH safer, but
after thinking through a few (and trying them out), this one wins by far:

First, set up passwordless authentication through `ssh-copy-id`.

Then edit `/etc/ssh/sshd_config` and add the lines:

    PasswordAuthentication no
    ChallengeResponseAuthentication no

Now no other devices than yours can ssh in, even if the password is known.

<!------------------------------->
# Notes on actiontec config

**(2016-02-01)**

Because Dad is paranoid that I did something to slow down our internet connection
a couple days ago, I'll try to sort out all of the things I've done here.

* Around **20 Jan,** I set a static IP but did not change the DHCP address range.
  (so my "fixed" IP was still considered a DHCP address).
  I cannot think of any config changes I made on this date.
* **28 Jan:** Modified DHCP address range to a smaller window. (reverted 1 February)
* **28 Jan:** Enabled IPv6.  (reverted 1 February)
* **1 Feb:** Set a static lease through DHCP for my PC.  (still in effect)
* **10 Feb:** Changed the DNS servers to ones that do not hijack results
  with Verizon SearchAssist.
  (this is under My Network >> Network Connections >> Broadband Connection (Ethernet/Coax).
   Where the default DNS addresses are x.y.z.12, the searchassist-free ones are x.y.z.14)

If our internet connection suddenly improves from this day onward, we'll know I was at fault.
(in hindsight... why in heaven's name did I think enabling ipv6 would be without consequence?
 In this day and age, the only reason I can think of that a feature like IPv6 would be disabled
 by default would be because they're still working out the bugs!)

<!------------------------------->
# desmume

**(2016-02-09)**

So the desmume gtk port has some pretty terrible performance.

Some flags to try are `--advanced-timing=0` and `--cpu-mode=1`.
However, another thing to try is this:

    desmume-glade

I found this alone (no extra cli options, no settings in .config) improved
performance of Nine Persons, Nine Hours, Nine Doors to a satisfactory level.
I also tried New SMB; FPS started out at a solid 30 (the window bar reports
60fps; it also LIES), then started to slow down as I played through level 1.
Eh.

desmume-glade is restricted to integer multiple window sizes, which made me
really happy until I realized that the only rescaling mode it supports is
linear.  So I hope you like your games fuzzy.

also,

> OOOOOOWWWCHGODDAMNIT! Gah! What the hell!?

**NOTE:** Even better:

    desmume --num-cores=4

This also lets you use nearest pixel (though I can't find a way to save it
so you have to clickity click click, every time; and make sure to do it BEFORE
OPENING THE ROM!). Unfortunately I also cannot find a way to force integer
sizes, but maximizing the window makes it verrrrrrry close to 2x on this 900px
tall monitor. (note: maximizing, not fullscreen).

The GTK port doesn't seem to have the ability to set the sound buffer size.
On 'Nine Persons, Nine Hours, Nine Doors', here's what I noticed
(during cutscene after first escape):
- **SPU Mode: Asynchronous:** lots of crackling.  When frame rate slows, pi
- **SPU Mode: Synchronous (N):** no crackling in BGM, but crackling during "the wave".
- **SPU Mode: Synchronous (Z):** zero crackling. Smooth. But speeds up and slows down and
  can lag quite a bit behind.  The pitch changes with the speed.
  Very bizarre experience overall!
- **SPU Mode: Synchronous (P):** less crackling. Audio stutters during screen transitions.
resulted in less crackling.

## UPDATE

**BEST SOLUTION OF ALL:**

Build Desmume. Just do it. Source is on SourceForge.
Current version fixes pretty much all complaints:
* Settings are remembered.
* There are integer window sizes in View >> Window Size.
* Nine Persons, Nine Hours, Nine Doors runs at a perfect 60 FPS consistently,
  where previously large character sprites would cause it to grind down to
  20-30. Have not tested other games.

Remaining issues:
* Sound still crackles; it depends on the audio track playing.
 (even though the crackling sounds like what you would hear from a short
  sound buffer, this is NOT the cause; I tried modifying the source code to
  use a larger buffer, and while it caused sound effects to be delayed,
  it did NOT fix the crackling one bit)
* There are screenshots, but the automatic naming is terrible.  Basically,
  every time you start Desmume, the first screenshot will be saved to
  ~/Pictures/desmume-screenshot-0.png, (then -1.png and so on), **overwriting
  any existing snapshots with those numbers from previous runs.**

<!------------------------------->
# ??? (something about cross compilation) ???

Wasn't sure what to do with this terribly formatted section
during the MD conversion, so I just blockcoded it.

I think it's useless garbage about a failed attempt to do something
but my eyes just glaze over when I try to look at it.

```
    export CFG_DISABLE_MANAGE_SUBMODULES=1
    module load gnu-4.7.2

    http://preshing.com/20141119/how-to-build-a-gcc-cross-compiler/
    page is pretty recent
    I got https://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.32.tar.xz instead
     to match BG kernel

    In step 2, the relevant edits are:
    make ARCH=powerpc INSTALL_HDR_PATH=/opt/cross/powerpc64-linux headers_install

 !!! there was no /opt/cross/$TARGET/include/gnu; had to mkdir it


  !!!    configure: error: cannot find sources (move-if-change) in ../binutils-2.24 or ..
      If this occurs I think it is a result of hitting Ctrl+C during download.
      (when you do this, curl will leave the incomplete file there, and next time
       you try it will see that a file is already there and won't redownload it)

 !!! Saw this during 5. Compiler Support Library

 In file included from ../../../gcc-4.9.2/libgcc/gthr.h:148:0,
                 from ../../../gcc-4.9.2/libgcc/libgcov-interface.c:27:
./gthr-default.h:35:21: fatal error: pthread.h: No such file or directory
 #include <pthread.h>
                     ^

     Seems that this is because '-pthread' is not among the flags passed to 'xgcc'
     but I have no clue why.  My best guess is that it may have to do with the unset
     statement but that seems silly.

     UPDATE: I now believe that when I got this specific error I had accidentally installed
     the linux headers under the wrong location.

 !!! before building GCC, got an error about some unknown variable (something like
     SIZELONG_INT) and a post on StackOverflow said to

         unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE LD_LIBRARY_PATH

     which I guess seems kind of reasonable?
     NOTICE:  Not 100% sure (I could be fooling myself) but it appears that these
     really need to be **unset**;  When I don't unset them I run smack into an
     issue about some invalid syntax "%{%:sanitize(stuff):".
     One of the many things I tried here was to
         echo $LIBRARY_PATH $CPATH $C_INCLUDE_PATH $PKG_CONFIG_PATH $CPLUS_INCLUDE_PATH $INCLUDE $LD_LIBRARY_PATH
     just to see if any were set, and the output was blank.  Further attempts to 'make' would fail
     at the same spot.
     On the last failure before I got things working, two things occurred:
         1. I tried the unset, even though all the variables appeared blank
         2. I remembered that the correct command at this point is 'make all-gcc'
            (keep in mind that this IS the target which is in the process of being built
             when the error ocurs for the first time; it is only on subsequent manual
             runs that I would accidentally use 'make')
     And after doing both of these it finished.  I then added the 'unset' line to the script
     right before 'make all-gcc', and it ran from the very beginning to... the next error.
     Who knows what would've happened had I simply run 'make all-gcc' without doing step 1?


 !!! /home/lampam/build/holy-crap/build-cross/build-glibc/resolv/libresolv_pic.a(res_query.os):(.toc+0x0): undefined reference to `__stack_chk_guard'
     /home/lampam/build/holy-crap/build-cross/build-glibc/resolv/libresolv_pic.a(ns_samedomain.os):(.toc+0x0): undefined reference to `__stack_chk_guard'
     /home/lampam/build/holy-crap/build-cross/build-glibc/resolv/libresolv_pic.a(ns_print.os):(.toc+0x0): undefined reference to `__stack_chk_guard'

     Didn't worry about these as there are already what appear to be functional-looking
     c/c++ compilers cross-compilers in /opt/cross.  Trying them out on rust now.

     ...and rust says that my cross-compiler "cannot produce binaries".
     ...when I attempt to use gcc directly I get:

         /home/lampam/build/holy-crap/build-cross/glibc-2.20/csu/../sysdeps/powerpc/powerpc64/start.S:80: undefined reference to `__libc_start_main'

     ...and the c++ compiler complains about not being able to find -lstdc++
     (and rightfully so; we never cross compiled the c++ std libraries)
```

<!------------------------------->
# cmake not finding FFTW3F

**TODO:** quote error message

This is an issue Andrew had when trying to build QSTEM, which uses cmake.
When I try building it on Ubuntu I also get the error, despite seemingly having
my bases covered in terms of fftw3-related packages.

Various attempts were made to e.g. set variables to help cmake find the existing
libraries. All failed

Andrew says that after building his own copy of fftw3 manually (and, presumably,
installing it to his home directory), cmake found it just fine.

<!------------------------------->
# ibus misbehaving

**(2016-05-25)**

Today when attempting to Ctrl+D close a terminal window, the machine appeared to
grind to a halt as the CPU fan audibly sped up.
Somehow, the "magic" Alt+F2 still worked, and the virtual terminal was very
responsive in contrast to the desktop.  I was able to find that "ibus-daemon"
was using ~190% CPU.

Killing it was no use as it would come back immediately upon hitting Alt+F7
and return to >100% CPU usage.

I found this page: https://bugs.launchpad.net/ubuntu/+source/ibus/+bug/1276186

While the bug is still open, there is the following workaround:

    gsettings set org.gnome.desktop.background show-desktop-icons true

<!------------------------------->
# `rpi_wpa2` certificate authority trouble

**(2016-06-14)**

Been having trouble connecting to wifi.
Today after an odd turn of events it is working under what would appear to be identical
to its intial settings.

There are some excerpts from /var/log/syslog in ~/scripts/setup-notes/files/2016-06-14-ssl

More or less what happened:

* Had trouble connecting to rpi_wpa2 at union.
  Saw certificate-authority-related errors in /var/log/syslog.
  Tried to look into things:
    - RPI's SSL cert is issued by Internet2 according to some whois site.
    - It expires August 2016: Two months from now.
    - Nothing recent on the RPI site mentions anything about this changing.
    - Various sources (links on RPI site, searches related to Internet2) all lead to the
      same certificate file: the "AddTrust External Root Certificate", which begins with
      MIIENjCCAx6gAwIBAgIBATANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJTRTEU
* Tried using that certificate specifically (default is a generic 'ca-certificates.crt'). Nothing.
* Tried Tunneled TLS. Nothing.
* Went to office.  Still nothing on wifi.  (first excerpt from syslog was around this time)
* Switched to LEAP authentication.  All of a sudden, wifi. (second excerpt)
* Tried switching back to PEAP and set all the settings back.
  Oddly enough... still have wifi! (third excerpt)

UPDATE: Yeah that didn't last long.
  Back to no wifi under PEAP when I returned to the union.
  Using LEAP from now on because it works.

<!------------------------------->
# Compiling GHC

**(2016-07-05)**

## Cloning the repo

Instructions here:  https://github.com/ghc/ghc  (DO NOT clone from this URL)

Notable deviations from standard building procedure:

1. You don't clone the github repo, but rather the Glasklow repo:

    git clone --recursive git://git.haskell.org/ghc.git

2. Before `./configure` you must run `./boot`.

## Bootstrapping Issues

Compiling GHC may require a higher version of GHC than is available through the
canonical repos.

One can add this repo:

    sudo apt-add-repository ppa:hvr/ghc
    sudo apt-get update

UNINSTALL any preexisting versions of these packages, and install ones with
version numbers in the name (from the hvr/ghc repo)

    ghc{,-*}
    cabal-install
    happy
    alex

And then --- oh hey, now we have GHC and don't have to build anything, right?

Well... kinda.
The problem with the hvr/ghc repository is that it doesn't actually install anything.
It just dumps a bunch of stuff into `/opt/`.
You can manually edit `PATH` to include all the `various/opt/PROGRAM/VERSION/bin` folders
it creates, but eh.

## Further Issues

`make` failed for me with

    collect2: error: ld returned 1 exit status
    `gcc' failed in phase `Linker'. (Exit code: 1)

which appeared to occur during the creation of
`compiler/stage2/build/libHSghc-8.1-ghc8.1.20160705.so`

At this point I just gave up and added the hvr bin directories to `PATH`.

<!------------------------------->
# Compiling rust for musl

**(2016-08-10)**

musl would allow static linking of libc in rust so I can build crap for matisse.

I get an error during make:

    compile: x86_64-unknown-linux-musl/rt/compiler-rt/absvdi2.o
    as: unrecognized option '-mrelax-relocations=no'

Looks like my binutils is too old (have 2.24, need 2.26).
Time to update to the new LTS 16.04.
Feels like the last time I did that was just yesterday...

https://gist.github.com/ExpHP/f2aad25aa885988a9245759d9d70f318

<!------------------------------->
# Color/font settings

**(2016-08-13)**

After the Ubuntu reinstall I had a very bumpy ride trying to recover
all of my terminal settings for vim, gnome-terminal, etc....

Insofar as I can tell:

* I use the Tango theme in `gnome-terminal`.
* The colors I am used to in vim are the background=light colors
  for ":colorscheme default"---even though I use a dark background.
* That colorscheme pulls (mostly) from the 16 configured terminal colors.
* I decided to make my own variant with brighter colors:
  https://github.com/ExpHP/brighter.vim
* The font I use is "Ubuntu Mono derivative Powerline Regular 12".

So that I don't ever have to worry about losing the Tango colors,
I shall immortalize them here in this text dump of the
dconf key `org.gnome.terminal.legacy.profiles:.:<UUID>.palette`:

    ['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)',
     'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)',
     'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)',
     'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)',
     'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']

<!------------------------------->
# latexmk bugs

**(2016-08-17)**

Q: HEEEELP LATEXMK IS FORK-BOMBING ME WHEN I RUN IT FROM INSIDE
   ANOTHER SHELL SCRIPT

A: latexmk 4.41 is broken. Upgrade it. (4.45 is good)


Q: LATEXMK IS DROPPING JUNK ALL OVER THIS DIRECTORY DESPITE
   ME USING THE -cd OPTION

A: I said latexmk 4.41 is broken!!! Upgrade it, already!

<!------------------------------->
# Missing Linux Terminal

**(2016-08-17)**

After the upgrade to 16.04 LTS I would find that Ctrl+Alt+F2
would sometimes not present a login (just a blinking cursor).

The following links to a VERY BAD SOLUTION, DO NOT DO:
http://askubuntu.com/questions/162535/why-does-switching-to-the-tty-give-me-a-blank-screen

(adding `nomodeset` to my /boot/grub/grub.cfg not only caused my FPS to
 drop to shit, but my screen would not turn on after awakening from sleep
 mode either!)

A small amount of research indicates that `nomodeset` has to do
with a recent change to how video drivers interact with the kernel.
Could this recent change have perhaps caused the tables to turn between
nouveau and proprietary drivers?

I should try installing nvidia drivers again (without nomodeset) and see.

<!------------------------------->
# Installing Mathematica

**(2016-08-22)**

You need the install "script" Mathematica_X.X.X_LINUX.sh,
which is several GB large.

1. For the love of god, CLOSE CHROME.  (you need memory)
2. Run the installer as root.
3. It asks for an install path (you'll want to change this since the default
    is `/usr/local/Wolfram/...` O_o)
4. No need to babysit as it installs since the only remaining step is brief.
5. When done it will ask where to put binaries.
   For reference, this will produce the following symlinks:

       math  mathematica  Mathematica  MathematicaScript  MathKernel  mcc

   Update: Mathematica 10.4 further adds some "wolfram" executables

       math         Mathematica        MathKernel  wolfram        WolframScript
       mathematica  MathematicaScript  mcc         WolframKernel

6. Note that in addition to the directories you specified it will also
   have put some stuff in /usr/share/Mathematica.

<!------------------------------->
# That emulator chip was using

**(2016-11-21)**

ChipCheezum used a multiplatform emulator called "RetroArch"
in the Gextra Life stream which looked cool, want to try it.

(technically, the emulator is just a frontend for the "libretro" API,
 which is basically a middleware layer between frontends and emulator
 cores)

He was using it with Mednafen as the core, which sounds like a
nice idea, as I don't recall Mednafen having much in the way of
a frontend on linux.

<!------------------------------->
# leanemacs

**(2016-10-16)**

After building lean and trying to run leanemacs, I discovered that there
were some packages it depends on.  Some of these are on the melpa repository
which is not avaliable by default.  I had to add this to ~/.emacs:

```elisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
```

The package list must be explicitly updated before they can be installed:

    M-x package-refresh-contents [RET]
    M-x package-install [RET] dash [RET]
    M-x package-install [RET] dash-functional [RET]
    M-x package-install [RET] f [RET]
    M-x package-install [RET] s [RET]

After this it is probably worth actually, you know, READING the README:
https://github.com/leanprover/lean/tree/master/src/emacs
In particular I needed to add all of this to .emacs:

(notice that lean-rootdir is the *install directory of Lean*,
 as opposed to something like GOPATH)

```elisp
(package-initialize)

;; Install required/optional packages for lean-mode
(defvar lean-mode-required-packages
  '(company dash dash-functional flycheck f
            fill-column-indicator s))
(let ((need-to-refresh t))
  (dolist (p lean-mode-required-packages)
    (when (not (package-installed-p p))
      (when need-to-refresh
        (package-refresh-contents)
        (setq need-to-refresh nil))
      (package-install p))))

;; Set up lean-root path
(setq lean-rootdir "/usr/local")
(setq-local lean-emacs-path "/usr/local/share/emacs/site-lisp/lean")
(add-to-list 'load-path (expand-file-name lean-emacs-path))
(require 'lean-mode)
```

It was also necessary to install ninja (`sudo apt install ninja`)
and copy the binary from `/usr/sbin` to `/usr/local/bin`

<!------------------------------->
# Mendeley

**(2016-10-24)**

Huh, don't recall having much trouble with the install the first time,
but this reinstall is proving to be a hassle.

Note: It installs itself on first run.  The "installer" there is just
for the mendeley: protocol, ignore it.

Some notes:

* **Unpack Mendeley where you want it to live _forever._**
  It will install symlinks which point into that directory.
  (this is in spite of the fact that it also makes hard copies of
   a bunch of other very large files >_>)

* **Don't run with an active `ulimit -r`!!**
  Because mendeley thinks it is entitled to everything.

Also, beware that it puts files in several places.
I found and deleted stuff at `./local/share/{data,Mendeley\ Ltd.}`

That said, it looks like the devs had a bit of fun with writing
messages for consecutive crashes. (Note: tracked in
"~/.config/Mendeley Ltd./Mendeley Desktop.conf":)

    [CrashReport]
    consecutiveCrashCount=6
    lastRunExitedCleanly=false
    lastRunVersion=1.17.1
    lastStartTime=1477329538

<!------------------------------->
# WiFi issues after suspend

After the 16.04 update I frequently find my laptop shows the icon for
a wired connection in the notification area after awakening from suspend,
and refuses to display or connect to any wifi networks.

On this thread:
http://askubuntu.com/questions/761180/wifi-doesnt-work-after-suspend-after-16-04-upgrade

the asker claims that this command reproduces the issue

    sudo service network-manager restart

Although for me, said command resolves it.

To prevent the issue from recurring,
I created the service script given in the top answer;
if this section doesn't get updated, then it probably worked.

<!------------------------------->
# Linux kernel 4.8.0

**(2016-12-12)**

Currently the generic linux image metapackage on Xenial points to 4.4.0,
but 4.8.0 kernels are available.

These are needed for the perf tool to display annotations from rust source code.

However, it also seems to be causing terrible framerate issues, so I don't think
I'll be sticking with it for too long...

(search tag: FPS)

<!------------------------------->
# WiFi on desktop in arch

**(2017-02-26)**

How I got wifi working on the Arch Linux Live USB, on the desktop (which uses
the Netgear N150 Wireless USB Adapter WNA1100):

Mostly followed this:
http://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html

Broad summary:

```
# iw dev
phy#0
        Interface wlp0s18f2u3
        ...
# IF=wlp0s18f2u3

# ip link show $IF
10: wlp0s18f2u3: <BROADCAST,MULTICAST> ...
# ip link set $IF up
# ip link show $IF
10: wlp0s18f2u3: <NO-CARRIER,BROADCAST,MULTICAST,UP> ...

# iw dev $IF link
Not connected.
# iw dev $IF scan
    ...
    SSID=FiOS-KM0UW
    ...
# SSID=FiOS-KM0UW
# CONF=/etc/wpa_supplicant/${SSID}.conf
# wpa_passphrase $SSID "the-network-password" >$CONF
# wpa_supplicant -B -i$IF -Dnl80211 -c$CONF
# iw dev $IF link
Connected to my:ma:ca:dd:re:ss (on wlp0s18f2u3)
...

# ping google.com
ping: google.com: Name or service not known.
# dhclient $IF
# ping google.com
PING google.com (172.217.4.78) 56(84) bytes of data.
...
```

`/etc/wpa_supplicant.conf` is instead an empty directory `/etc/wpa_supplicant`;
you can just create any file there (it is arbitrary anyways since we manually
specify the path later).

In `wpa_supplicant`, I needed to swap `-Dwext` out for `-Dnl80211`.

Clean up old `wpa_supplicant` processes after a failed attempt (they will cause an
otherwise perfectly valid configuration to appear to fail)

***VERY IMPORTANT***

At some point while following the ArchLinux install guide (https://wiki.archlinux.org/index.php/installation_guide)
you chroot into your soon-to-be-root directory and have the opportunity to
use `pacman` install various things.

INSTALL ALL OF THE WIFI TOOLS!!!!

    pacman -S iw wpa_supplicant dhclient

<!------------------------------->
# ARCH SETUP TODO LIST

**(2017-02-27)**

Various steps one should not forget while installing Arch:

### During the installation guide:

#### Obvious advice

MAKE DOUBLY SURE YOU DON'T MISS ANY STEPS!

#### pacstrap:

instead of just base, do:  base base-devel

#### grub:

The following installs grub to the MBR, and boots an operating system
in legacy (BIOS) mode (a.k.a. "not EFI mode"):

    pacman -S grub os-prober
    # NOTE: don't worry about the x86 target;
    #       32-bit Grub can boot into a 64-bit operating system.
    grub-install --target=i386-pc /dev/sdx
    grub-mkconfig -o /boot/grub/grub.cfg


Forgot where you put grub?

    sudo dd if=/dev/sdx bs=512 count=1 2>/dev/null | strings

##### on the T430s...

Setting up the T430s involved quite a bit of running around in circles,
but ultimately the outcome was this:

* The preinstalled Windows 7 boots through UEFI.  This can be confirmed
  beyond a shadow of a doubt by booting into windows and searching
  "C:\Windows\Panther\setupact.log" for "Detected boot".
  (I found "Detected boot environment: EFI";
   for Legacy mode it would say "BIOS")

* The Arch Linux Live USB was not booting through UEFI, as made clear by
  the lack of `/sys/firmware/efi`

* The latter could be fixed in the BIOS settings, by changing "Legacy first"
  to "EFI first" (or "UEFI First", don't remember the precise name).

Unlike legacy-mode bootloaders, EFI bootloaders must match the architecture:

    # inside the chroot...
    # (note: incidentally, my /boot is also a separate drive (in hindsight
    #  I'm not entirely sure what prompted me to do that), so after this
    #  the path /mnt/boot/efi was literally 3 recursively nested mounts :P)
    mount /dev/sdx1 /boot/efi
    pacman -S efibootmgr
    grub-install  # no args necessary; it will see /boot/efi
                  #   and do the needful
    grub-mkconfig -o/boot/grub/grub.cfg

If, upon reboot, you see this: (pay special attention to the UUID!)

    error: no such device: ad4103fa-d940-47ca-8506-301d8071d467
    Loading Linux core repo kernel ...
    error: no such partition.
    Loading initial ramdisk ...
    error: you need to load the kernel first.

then you forgot to do grub-mkconfig. (The 'ad4103fa' UUID will bring up
many google results if you search for it, because it is specified
in the default `/boot/grub/grub.cfg`.)

##### /etc/wpa-supplicant/:

Copy your conf file to the chroot!!!
And please please please `pacman -S iw dhclient wpa_supplicant`!

### rankmirrors:

Be sure to do this before installing lots of packages.
(the rankmirrors script is part of the base install, so feel free to
 wait until after the reboot)

The default `/etc/pacman.d/mirrorlist` is in a format that is easily
filtered by region. DO THIS! (don't worry, there's an entire 40 mirrors
in the US alone!)

(rankmirrors will mess up the comments that make this filtering
 possible, so keep the original, too!)

```
cp /etc/pacman.d/mirrorlist{,.bak}
grep --no-group-separator -A1 'United States' /etc/pacman.d/mirrorlist.bak >/etc/pacman.d/mirrorlist.us
rankmirrors -v /etc/pacman.d/mirrorlist.us >/etc/pacman.d/mirrorlist
```

### User account:

After the installation guide:

    # (warning: this is from memory)
    useradd -G wheel -c /bin/bash exp -m
    visudo           # ... uncomment the line for the wheel group
    sudo passwd exp  # ... set the password
    sudo su exp      # try it out
    sudo su          # (and make sure the new user can 'sudo'!)

### Packages:

These can be installed after chroot to `/mnt` in the installation guide,
or after booting into the new OS:

```sh
pacman -S iw dhclient wpa_supplicant networkmanager
pacman -S wifi-menu dialog
pacman -S git cmake
pacman -S vim emacs
pacman -S python{,2}{,-pip} ruby rustup
# pacman -S ghc ghc-mod cabal-install   # UPDATE: don't do this, see below
pacman -S nodejs npm
pacman -S pass gnupg pwgen
pacman -S xorg-xinit       # has startx; not part of the 'xorg' group
pacman -S rustup           # NOTE: don't run as root
pacman -S lsof mlocate tree
pacman -S zsh bash-completion zsh-completions
pacman -S ssh
pacman -S jq
pacman -S openmpi boost openmp  # don't get blas/lapack yet!

# can't go without the AUR
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si   # NOTE: this asks for a password
              #       even if you are root
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

# don't ever install anything from AUR with `haskell-*` dependencies
# (see entry in notes.org from November 1 2017 about linker errors)
pacman -S ghc ghc-static
git clone https://github.com/haskell/cabal
git clone https://github.com/commercialhaskell/stack
(cd cabal/cabal-install && ./bootstrap.sh)
(cd stack && cabal install)

# some odds and ends that can otherwise put a hiccup in your morning
pacman -S ntfs-3g      # the standard ntfs driver is read-only
pacman -S exfat-utils  # for formatting flash drives as exFAT
# pacman -S dosfsutils   # for formatting flash drives as FAT32.
#                        # or perhaps don't; FAT32 sucks, and having it might tempt
#                        # you to pick it from gparted's list.

# Make numpy faster; openblas beats the crap outta cblas
pacman -S openmp
yaourt openblas-lapack
  # choose to edit the config file
  # in the _config= string, change to USE_OPENMP=1

# pip will by default install to /usr (not /usr/local), potentially
# making life miserable if you later want to install things through
# pacman.  Here's some packages known to be on the arch repo.
#
# If it's too late and you've already installed stuff from pip
# that is blocking pacman, be aware of the following command:
#
#     pip freeze
#
# which lists all installed packages and might help you find the
#  right name to give "pip uninstall". (which does NOT necessarily
#  match the name of the subdirectory inside site-packages)
#
# (half of these were found just by looking at the optional deps
#  of python-pandas)
arr=()
arr+=(jupyter jupyter-notebook)
arr+=(python-networkx python2-networkx)
arr+=(python-nose python2-nose)
arr+=(python-scipy python2-scipy)
arr+=(python-numexpr python2-numexpr)
arr+=(python-bottleneck python2-bottleneck)
arr+=(python-matplotlib python2-matplotlib)
arr+=(python-pandas python2-pandas)
pacman -S "${arr[@]}"
```

**(NOTE 2017-11-17):**
 For reasons unbeknowest to me, it appears that some time
 after I wrote the above I decided to install jupyter-notebook through pip.
 Since I didn't document why, I can only assume it was due to a temporary lapse in judgement.
 If I some day later find that I have made this same mistake, here's a list of all the
 things I had to uninstall this time:

    sudo pip uninstall pygments wcwidth ipython pyzmq
    sudo pip uninstall jupyter-core jupyter-console jupyter-client jupyter-notebook
    sudo pip uninstall pexpect pickleshare nbformat jsonschema
    sudo pip uninstall traitlets ipython_genutils terminado tornado ptyprocess decorator
    sudo pip uninstall jinja2 markupsafe


don't forget drivers!

    THINKPAD:      xf86-input-synaptics
    NVIDIA CARDS:  xf86-video-nouveau  OR  nvidia

### Laptop battery state

    pacman -S acpi
    modprobe ac    # note: many other drivers exist too (e.g. for temperature)
    acpi -d

### Dear god that text is so tiny

Try this:

    pacman -S terminus-font
    setfont ter-132n

See /usr/share/kbd/consolefonts for a list of available fonts.

To make it persistent, add "FONT=ter-132n" to "/etc/vconsole.conf".

### Passwords:

If not done already:

    pacman -S pass gnupg pwgen git

Do NOT do `pass init` (you'll see).
Also, add this to .bashrc: (assuming this is still the key I use)

    export GPGKEY=6FB78008

(to be honest, I'm not sure if exporting it makes any difference, because
 I'm not sure if any programs look at this envar; but at the very least,
 it is useful in some expansions)

#### Transfer `gnupg` keys

**On an old system,** export your gnupg private key (the public key
is included with it):

    gpg --export-secret-key $GPGKEY >priv.keys

**On the new system:**

Attempt to import the keys.  **This will likely fail;** the point is to make
gpg automatically create .gnupg with the right set of permissions it wants.

    # NOTE: Expected to fail with "problem with the agent: No pinentry".
    # or "problem with the agent: (something along the lines of File not Found)"
    # The purpose for now is to make gpg generate ~/.gnupg.
    gpg --import priv.keys

The reason it fails is because by default, the gpg-agent tries to start
some GUI prompt for a password. Let's fix that:

    echo 'pinentry-program /usr/bin/pinentry-tty' >>~/.gnupg/gpg-agent.conf
    pkill gpg               # kill any broken agents that are still running.
    gpg --import priv.keys  # this should succeed now.

**NOTE 2018-02-24:** I have a new pinentry program in dotfiles/bin which is more versatile than `pinentry-tty`.

Oddly, this is enough to let you decode messages with the key, but not
to encode them with the public key.  For that, you need to "trust" it:

    gpg --edit-key $GPGKEY
    gpg> trust
    (give yourself a trust level of 5 and confirm)

That should be it for `gpg`. (for now)

#### Clone the `pass` storage

A bare clone of .password-store is on the external 3.0 TB HDD.
Mount it to a path that you're comfortable sticking to.

    git clone /mnt/ext4-backup/password-store.git/ ~/.password-store

`pass` should now be fully functional.

...unfortunately, it's a bit tough to use without X window system

#### Let `git` know about the GPG key

If you want, you can sign commits with the GPG key.
(unfortunately, this will NOT let you bypass the password prompt;
 you need an SSH key for that)

See this: https://help.github.com/articles/telling-git-about-your-gpg-key/
and also do this:

    git config --global commit.gpgsign true

#### Once you have a desktop

    sudo pacman -S chromium firefox flashplugin

#### Fonts

The "infinality-bundle" package recommended in various places
is down and the maintainer is out. Lookee here instead.

    https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671

Seems overall though that font-bundling packages are very ephemeral.
The above link will probably far outdated by the next time I read this.

#### CRUCIAL THINGS TO DO AFTER INSTALLING ANY DESKTOP ENVIRONMENT

Replace the 'vim' package with 'gvim', because that package includes a CLI
version of vim that is compiled with '+clipboard' and '+xterm_clipboard'.

    sudo pacman -R vim
    sudo pacman -S gvim


#### CRUCIAL THINGS TO DO AFTER INSTALLING KDE

Open the dash and type "Global shortcuts".
Look under "kmserver".
Observe these lovely keybindings:

    Ctrl+Alt+Shift+PgDn : Halt without confirmation
    Ctrl+Alt+Shift+PgUp : Reboot without confirmation

Burn them with fire.

#### THINGS I DID ON THE LAPTOP WHILE TRYING TO GET A WORKING DESKTOP, BUT I DON'T UNDERSTAND HOW THE THING I DID THAT MADE IT WORK ACTUALLY MADE IT WORK

This is largely narrative written after the fact.  There are probably factual
errors and inconsistencies;  I tried my best to reconstruct this from my bash
history, but that history doesn't include e.g. the error messages I saw!

Okay, so: I tried installing 'i3' (a tiling window manager) and put this in
`.xinitrc`:

    exec i3

However, inside `i3` I observed the following:

* Super+d just gave a permanent 'wait' cursor (it is supposedly supposed to
  open a menu)
* Super+Enter complained that there were no terminals.  After installing
  `gnome-terminal`, it just gave a permanent 'wait' cursor.
* Super+Shift+e opened a "are you sure you want to leave"-sort of box at
  the top.  Clicking "Yes" did nothing. Clicking "Yes" a second time dismissed
  the bar (but did not exit i3).

Ctrl+Alt+Fing to a new terminal I saw various scary-looking errors from nouveau.
So I installed the nouveau drivers: (strangely not a dependency of nouveau?)

    sudo pacman -S xf86-video-nouveau
    sudo reboot

However this did not remove the errors or improve my experience with `i3` (and
if anything, it just made more errors appear on boot!).  One of those errors
mentioned IBUS so I decided "hey let's install ibus because why not"

    sudo pacman -S ibus dbus
    sudo reboot
    # Nope, still have all these lousy errors

Googling one of the errors led to a forum post where some guy supposedly
solved all his issues by installing bumblebee. After reading up on:

https://wiki.archlinux.org/index.php/NVIDIA
https://wiki.archlinux.org/index.php/NVIDIA_Optimus
https://wiki.archlinux.org/index.php/bumblebee

and knowing that the laptop has Nvidia OPTIMUS, I figured "well gee, what the
hey" and decided to install bumblebee and the nvidia drivers.

    # (NOTE: there are also nvidia-340xx and nvidia-304xx for legacy drivers;
    #  to determine what you need, `lspci -nn` to get the pci id numbers
    #  and search for them here: http://www.nvidia.com/object/IO_32667.html)
    sudo pacman -S nvidia
    sudo pacman -S bumblebee mesa-demos
    sudo gpasswd -a exp bumblebee
    sudo systemctl enable bumblebeed
    sudo reboot now

This cleared the nouveau errors, but I think that's mostly just because
installing nvidia disables nouveau. :P
I was unable to run the `optirun` tests on the bumblebee page because they
apparently required a running x session, and `i3` was still unusable.

    lsmod | grep nvidia  # hmm, nothing
    nvidia-modprobe
    lsmod | grep nvidia  # okay there's something, but was that necessary?
    startx               # gah, still sucks

Then I installed `plasma` (the full KDE5 desktop environment),
and enabled `sddm` (the DM that comes with plasma):

    sudo pacman -S plasma
    systemctl enable sddm.service
    sudo reboot

On reboot, SDDM was set to load `i3` by default; it loads i3 (without
visually clearing the login screen), and i3 is now able to open terminals
(and it uses gnome-terminal) and be quit out of.  I'm not entirely sure
why installing a DM would fix that, but then again I'm not entirely sure
that I've gotten all the details right!

So there ye have it.

...by the way, it turns out KDE actually kicks ass,
so let's forget about `i3` for now. :3

#### Automatic Wifi and ethernet

once you're bored of using wpa_supplicant manually, enable some services:

    sudo ip link  # to figure out device names
    sudo systemctl enable dhclient@enp0s25.service
    sudo systemctl enable dhclient@wlp3s0.service
    sudo systemctl enable NetworkManager
    sudo reboot

and then e.g. Plasma already has a network management widget that should
appear in the tray.

<!------------------------------->
# LaTeX on arch

**(2017-05-16)**

    sudo pacman -S texlive-most

Note that this doesn't install the "fourier" package correctly.

```text
(/usr/share/texmf-dist/tex/latex/fourier/fmlfutmi.fd)
(/usr/share/texmf-dist/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-dist/tex/latex/amsfonts/umsb.fd) [1{/home/lampam/.texlive/texmf-var/fonts/map/pdftex/updmap/pdftex.map}] (./projections.aux)
kpathsea: Running mktexpk --mfmode / --bdpi 600 --mag 0+458/600 --dpi 458 futr8rmktexpk: don't know how to create bitmap font for futr8r.
mktexpk: perhaps futr8r is missing from the map file.
kpathsea: Appending font creation commands to missfont.log.
)
!pdfTeX error: pdflatex (file futr8r): Font futr8r at 458 not found
==> Fatal error occurred, no output PDF file produced!
```

This can be solved with manual intervention:

Do ONE of the following. I'm not sure which is better.
(try the -sys one.  Once you do the non-sys one, you effectively detach
 yourself from the system config, and you're stuck with the consequences until...
 well, I guess until you find the user-local config files and delete them)

```
updmap --enable Map fourier.map
sudo updmap-sys --enable Map fourier.map
```

<!------------------------------->
# nolimit on arch

**(2017-04-21)**

I now set memory limits in /etc/security/limits.conf instead of bashrc.

    lampam           hard    as              8000000

With this, bypassing ulimit---for as infrequently as I need to do it---
can be easily accomplished with a series of `su`s:

    $ sudo su
    # ulimit -v unlimited
    # sudo su lampam
    $ ulimit -v
    unlimited

> It's login shells all the way down, son!

<!------------------------------->
# Android Development and debugging

**(2017-07-03)**

 - Follow: https://wiki.archlinux.org/index.php/android
 - ...with these modifications/notes:

   - Here are the "setup steps" that accumulate over time for any new terminals
     you open until you reboot:

     ```
     $ source /etc/profile
     $ bash  # give me back my prompt! >:3
     $ newgrp sdkusers
     $ newgrp adbusers
     ```

   - Ignore "Adding udev Rules".  Don't worry about vendor ids.
     - Instead, load dotfiles/stow/android-adb-usb .

   - On the next step ('adb devices'), if you see 'unauthorized' instead
     of 'device', check the phone screen. (It might be asking to authorize
     the host key)

   - You can ignore "Building Android" and onwards if you're just using
     android-studio and adb.

<!------------------------------->
# Windows 7 os-prober troubles

Three words.
MOUNT. THE. DRIVE.

THEN you can run 'update-grub' or 'grub-mkconfig -o /boot/grub/grub.cfg' as normal.
You will see it print "Found Windows 7 on /dev/sda1" as one of its lines when
  the os-prober rule runs.
(you do not need to run 'os-prober' manually)

Specifically *mount the one with the bootloader!*  On my desktop it's called
"System Reserved" and if you mount it you might find a file "/bootmgr".

<!------------------------------->
# Can't create ExFAT in gparted

**(2017-07-27)**

**Answer:** That is correct.
[You can't.](http://gparted.org/features.php)
Just use mkfs.exfat instead.

<!------------------------------->
# Can't log into CCI

**(2017-07-05)**

  Aparently password IS correct;
  Tried using the password update form and it reported that the password was updated.
  If a BS password is given it errors with "Current password does not match".

  Colin cannot log in either, and also got success with the PW change form.

  Stopped receiving Maintenance emails at the end of March.

Resolution: After emailing support, the account was reactivated.
            It was disabled due to inactivity.

<!------------------------------->
# Colin's IDE

**(2017-07-10)**

It's 'clion' from AUR.
On startup, choose "Custom cmake: /usr/bin/cmake".
(note: when not doing this, I got a segfault in the middle of some
random looking rule for building lammps)

<!------------------------------->
# Note on the laptop SSD remounting as read-only

**(2017-08-27)**

 is on the T430s, which has an SSD that uses mSATA (that's the one
that has the exact same form factor as PCIe)

Today, I received an overwhelmingly clear message about what it is I'm doing
that causes this issue to arise:

- Beyond a shadow of a doubt, the issue occurs when pressure is applied to
  a certain area on the underside of the laptop.
  (this area is at the center horiziontally, and just behind the center vertically
   (as in, it is closer to the monitor than to me))

  Unfortunately for me, I have a very strong tendency to hold it there (either on my
  knee when I'm sitting or on the palm of my hand when standing) since it tends to
  coincide with the laptop's center of gravity.

  If memory serves me right, this also happens to be the precise location
  where the SSD is installed.

- When the pressure is applied enough to cause problems, there is a noise (!!!).
  When I finally discovered this, I gave myself two seconds to "play with fire"
   and deliberately invoke the noise, trying to understand when exactly it sounds,
   and burning the tone into memory.
  - It sounds like a saw wave playing at a constant frequency near... 1700 Hz?
    http://onlinetonegenerator.com/
  - It begins to sound the moment the pressure applied crosses a certain threshold,
    and cuts off as soon as the pressure decreases back below that threshold.
  - It is very quiet.  My face must be right next to the system to hear it.
    I've never even noticed it until now.

<!------------------------------->
# Cabal linker errors

**(2017-09-01)**

Suddenly one day, after not using Haskell for a while:

```sh
$ cabal test
Preprocessing library arithmoi-0.5.0.1...
Preprocessing test suite 'spec' for arithmoi-0.5.0.1...
Linking dist/build/spec/spec ...
/usr/bin/ld: cannot find -lHStagged-0.8.5-DG0qxw3gXxx4NfDcDx4Iai
/usr/bin/ld: cannot find -lHSregex-tdfa-1.2.2-JFeutuWiS2vGBM4qXQlqio
/usr/bin/ld: cannot find -lHSregex-base-0.93.2-AYjYAsBidAc8f5XNm9b2Aa
/usr/bin/ld: cannot find -lHSparsec-3.1.11-1CA7c0vSU7tJHGhveOjoXR
/usr/bin/ld: cannot find -lHStext-1.2.2.2-3ENqlljngKa6xj1Go2fVWq
/usr/bin/ld: cannot find -lHSbinary-0.8.3.0
/usr/bin/ld: cannot find -lHSoptparse-applicative-0.13.2.0-J9tSV1D1M11JWNEbVQPonU
/usr/bin/ld: cannot find -lHStransformers-compat-0.5.1.4-IuFogs8HAVUJBWVNMhtssu
/usr/bin/ld: cannot find -lHSprocess-1.4.3.0
/usr/bin/ld: cannot find -lHSdirectory-1.3.0.0
/usr/bin/ld: cannot find -lHSunix-2.7.2.1
/usr/bin/ld: cannot find -lHSbytestring-0.10.8.1
/usr/bin/ld: cannot find -lHSfilepath-1.4.1.1
/usr/bin/ld: cannot find -lHSansi-wl-pprint-0.6.8.1-E76ARGam2soH7nnUTX5qkH
/usr/bin/ld: cannot find -lHSclock-0.7.2-6ZjQ4liQAtMEQ8sxJKD0xY
/usr/bin/ld: cannot find -lHSasync-2.1.1.1-2GwQEYzLBsdIBCHbNA3HGy
/usr/bin/ld: cannot find -lHSstm-2.4.4.1-iSYwp3RMY11sHCifJ3gtR
/usr/bin/ld: cannot find -lHSansi-terminal-0.6.3.1-59sjf9WqHYuFAo9gQw9Bhp
/usr/bin/ld: cannot find -lHSsmallcheck-1.1.2-LDYrF813cXx9pXAB4DnM94
/usr/bin/ld: cannot find -lHSlogict-0.6.0.2-IvIE0u44i1X7ob5HesINuT
/usr/bin/ld: cannot find -lHSmtl-2.2.1-BLKBelFsPB3BoFeSWSOYj6
/usr/bin/ld: cannot find -lHSinteger-logarithms-1.0.2-IDuUvOgHWcrIzD9yrr4lsA
/usr/bin/ld: cannot find -lHSQuickCheck-2.10.0.1-ALuGysu7txTB2VnkPyDuTq
/usr/bin/ld: cannot find -lHStf-random-0.5-CJZw1ZWS5MOJlR60HqKEZL
/usr/bin/ld: cannot find -lHSprimitive-0.6.2.0-4578caNkWQ54Gt1mxLF2Yh
/usr/bin/ld: cannot find -lHStransformers-0.5.2.0
/usr/bin/ld: cannot find -lHStemplate-haskell-2.11.1.0
/usr/bin/ld: cannot find -lHSpretty-1.1.3.3
/usr/bin/ld: cannot find -lHSghc-boot-th-8.0.2
/usr/bin/ld: cannot find -lHSrandom-1.1-9tceXaeYIMZ4JrKq20Egog
/usr/bin/ld: cannot find -lHStime-1.6.0.1
/usr/bin/ld: cannot find -lHScontainers-0.5.7.1
/usr/bin/ld: cannot find -lHSdeepseq-1.4.2.0
/usr/bin/ld: cannot find -lHSarray-0.5.1.1
/usr/bin/ld: cannot find -lHSbase-4.9.1.0
/usr/bin/ld: cannot find -lHSinteger-gmp-1.0.0.1
/usr/bin/ld: cannot find -lHSghc-prim-0.5.0.0
/usr/bin/ld: cannot find -lHSrts
collect2: error: ld returned 1 exit status
`gcc' failed in phase `Linker'. (Exit code: 1)
```

**From the Arch wiki:**

> GHC uses static linking by default and the -dynamic flag is needed to select dynamic linking. Since version 8.0.2-1, the Arch ghc package no longer contains static versions of the GHC boot libraries by default, nor do any of the `haskell-*` packages . Static versions of the GHC boot libraries may be installed separately through the ghc-static package, but no such equivalent exists for the `haskell-*` packages. Therefore, without -dynamic Haskell code and packages will generally fail to link unless the program depends only on boot packages and locally installed packages and ghc-static is installed.
>
> This also causes issues with Cabal trying to use the default static linking. To force dynamic linking in Cabal, edit `~/.cabal/config` and add the line `executable-dynamic: True`.
>
> Dynamic linking is used for most Haskell modules packaged through pacman and is common for packages in the AUR. Since GHC provides no ABI compatibility between compiler releases, static linking is often the preferred option for local development outside of the package system.


Even with `executable-dynamic: True` and all Arch packages uninstalled except `ghc` and `cabal-install`, I would get linker errors if I tried to upgrade from cabal 1.24 to 2.0 via `cabal install cabal-install` (with or without `--enable-shared`).

The final solution was to revert back to static:  If you uninstall all haskell packages except `ghc` and then install `ghc-static`, this will remove all dynamic libraries.  (confirm by checking `sudo updatedb && locate libHS`)

To find out what Haskell packages I had to uninstall, I did:

```sh
pacman -Qsq '^haskell' | sudo pacman -R -
```

which didn't actually work (it just gave a bunch of errors about dependencies I would break),
but the packages on the left-hand side of those broken dependencies
tells you which packages were manually installed.

```sh
sudo pacman -R --recursive ghc cabal-install xmonad stack idris hlint ghc-mod cabal-helper
sudo updatedb && locate libHS  # good, nothing.
sudo pacman -S ghc ghc-static
sudo updatedb && locate libHS  # good, still nothing.
(cd ~/asd/clone/cabal && rm -rf * && git reset --hard && cd cabal-install && ./bootstrap.sh)
cabal update
cd ~/asd/clone/arithmoi
cabal new-test  # :D
```

Note to self in case I get errors later from pacman:
I disabled some files that have no business existing:

    /usr/share/applications/org.bunkus.mkvinfo.desktop
    /usr/share/applications/org.bunkus.mkvtoolnix-gui.desktop

I renamed their extensions from `.desktop` to `.fucking-retarded`.

<!------------------------------->
# Rust on blue gene Q

**(2017-09-14)**

I've finally gotten rust working on blue gene.
Notes are in this markdown file:

https://gist.github.com/ExpHP/930578ff5735b3efa6b3e3cd966d0be3

In short:
Rust-lang supports the powerpc64-unknown-linux-gnu target triple,
and a subcommand 'cargo vendor' exists to help manage dependencies.

Tags: BGQ

<!------------------------------->
# lammps-sys crate on matisse

**(2018-01-19)**

When compiling rsp2 on matisse, I got strange "undefined symbol" errors
even though the library was clearly linked properly and had the listed symbols.

Looking at the .rcgu0 file and liblammps.so in objdump and nm both showed names
like `lammps_has_error`... however, `readelf -Ws` on the .rcgu0 finally revealed
something peculiar.  There were names like `_ZN16lammps_has_error`.

Looking at the generated bindings.rs revealed that erroneous `#[link_name]`
attributes were being added to the file on matisse.

It appears this is because the version of libclang available to me was old.
bindgen has a workaround for this (`trust_clang_mangling(false)`).
I added this to `lammps_sys`.

<!------------------------------->
# building lammps with kolmogorov-crespi-z

**(2018-01-26)**

There is a `make` target you should make before the main build, which moves the appropriate cpp file (and some others) into the source directory.

```sh
# THIS is the one you need to use
make yes-user-misc

# DO NOT DO ANY OF THESE
exit 1 # (copy-pasta guard)
make user-misc  # WRONG! this is invalid, the lammps docs are lying to you
make yes-user   # WRONG! that will get ALL the user packages, which will require ALL the libs
make yes-lib    # WRONG! that way lies sorrow, much much sorrow, death is inevitable
```

<!------------------------------->
# adaptive PGP pinentry

**(2018-02-24)**

`dotfiles/bin` now has an adaptive pinentry that appears in the console
when possible and in a gui when necessary.

It needs to be manually set up:

```
echo 'pinentry-program /home/exp/dotfiles/bin/pinentry-exphp' >>~/.gnupg/gpg-agent.conf
```

<!------------------------------->
# HP 2055dn printer

**(2018-04-25)**

In short, I still haven't gotten this to work

## Definitely true things:

* You should install `hplip` so that the right model shows up under Model in CUPS.

## Other notes

* To get the CUPS administration page to actually present a password prompt, I need to use Firefox (not Chromium).  Why? Idunno.
* Colin was able to connect with a socket URL and IP: `socket://128.113.x.y`.  Note: He used the KDE tools instead of the CUPS administration page.
* For some reason right now my machine can resolve an IP for the address `icmp2055dn.phys.rpi.edu` but I was unable to use it in a socket URL.

<!------------------------------->
# Transferring files to/from Android

**(2018-04-28)**

*Sooooo...*

Turns out MTP on Linux is a nightmare.

Here's what to do about it:

1. **REBOOT YOUR PHONE.** The MTP file scanner on the device itself may not run very frequently. And when it doesn't run, the phone communicates old filesystem information to the computer. So if the filesystem you see after step 2 does not reflect the current state of the filesystem on the phone, it's because you **need to reboot it.**
2. Don't trust KDE's device popup. (if you click it, it will give a "path does not exist error"). Instead, manually mount it with a tool called "simple-mtpfs"

   ```
   sudo pikaur -S simple-mtpfs
   sudo reboot -h now # always reboot after installing MTP related stuff.
                      # MTP is terrible.
   simple-mtpfs --device 1 ~/mnt
   ```

<!------------------------------->
# GIMX

**(2018-06-03)**

GIMX is a tool for allowing a PC to spoof a PlayStation 3 controller.

## Building

The README doesn't mention this (or anything about how to build), but there's submodules.

```sh
git submodule init
git submodule update
make -kj4    # -k to 'keep going' on error
```

I got this error:

```
display.c:11:10: fatal error: ncursesw/ncurses.h: No such file or directory
 #include <ncursesw/ncurses.h>
          ^~~~~~~~~~~~~~~~~~~~
```

And fixed it by following a suggestion on Reddit to `#include <curses.h>` instead.

(**note:** on my system, there is a file called `cursesw.h`, which by name would appear to be the more correct choice; but when I tried it there were a bunch of syntax errors, and I haven't felt the need to look further into it since `curses.h` seems to work)

Then there is the matter of installation.

## Installation

**Hooooooo boy.**

This is a goddamn mess of epic proportions.

### Installing to a custom prefix

**Do not run `sudo make install`.**

* `make install` wants to install everything to `/usr`.  **I wouldn't.**  The installation includes unrelated files, including a copy of `bdaddr` from the `bluez-utils` package, which will inevitably cause pacman conflicts.
* Their makefiles defines the installation prefix in an... unorthodox manner:
  ```Makefile
  # (unfortunately this appears in many, many files due to recursive make)
  prefix=$(DESTDIR)/usr
  ```
  I honestly can't imagine what they were going for.

I highly recommend **giving it its own dedicated install directory,** so that some bullshit can be addressed later.

```
sudo DESTDIR=/opt/GIMX make install
sudo tee -a /opt/GIMX/env <<'HERE'
export PATH=/opt/GIMX/usr/bin:$PATH
export LD_LIBRARY_PATH=/opt/GIMX/usr/lib:$LD_LIBRARY_PATH
HERE
sudo chmod +x /opt/GIMX/env
```

and source `/opt/GIMX/env` in `.bashrc`.

### Unsetting the SETUID bits

After installing it, I noticed something strange.  `ldd` would report that all libraries could be successfully found, yet `gimx` would still fail with linker errors.

```
$ gimx
gimx: error while loading shared libraries: libgimxlog.so: cannot open shared object file: No such file or directory
$ ldd $(which gimx) | grep libgimx
        libgimxlog.so => /opt/GIMX/usr/lib/libgimxlog.so (0x00007f468fd9b000)
        libgimxhid.so => /opt/GIMX/usr/lib/libgimxhid.so (0x00007f468fb94000)
        libgimxgpp.so => /opt/GIMX/usr/lib/libgimxgpp.so (0x00007f468f990000)
        libgimxcontroller.so => /opt/GIMX/usr/lib/libgimxcontroller.so (0x00007f468f781000)
        libgimxinput.so => /opt/GIMX/usr/lib/libgimxinput.so (0x00007f468f56b000)
        libgimxuhid.so => /opt/GIMX/usr/lib/libgimxuhid.so (0x00007f468f367000)
        libgimxpoll.so => /opt/GIMX/usr/lib/libgimxpoll.so (0x00007f468f164000)
        libgimxprio.so => /opt/GIMX/usr/lib/libgimxprio.so (0x00007f468ef62000)
        libgimxserial.so => /opt/GIMX/usr/lib/libgimxserial.so (0x00007f468ed5e000)
        libgimxtimer.so => /opt/GIMX/usr/lib/libgimxtimer.so (0x00007f468eb5b000)
        libgimxusb.so => /opt/GIMX/usr/lib/libgimxusb.so (0x00007f468e954000)
```

The explanation lies in the file permissions.

```
$ ls -l /opt/GIMX/usr/bin
total 1920
-rwsr-sr-x 1 root root  19288 Jun  3 12:39 bdaddr
-rwsr-sr-x 1 root root  13752 Jun  3 12:39 ds4tool
-rwsr-sr-x 1 root root 267584 Jun  3 12:39 gimx
-rwxr-xr-x 1 root root 631496 Jun  3 12:39 gimx-config
-rwxr-xr-x 1 root root 407024 Jun  3 12:39 gimx-fpsconfig
-rwxr-xr-x 1 root root 408576 Jun  3 12:39 gimx-launcher
-rwxr-xr-x 1 root root 168272 Jun  3 12:39 gimx-loader
-rwsr-sr-x 1 root root  13136 Jun  3 12:39 hcirevision
-rwsr-sr-x 1 root root  13008 Jun  3 12:39 sixaddr
```

Notice the 's' flags on many of the binaries.  This is the SETUID flag.

> Ahhh, so *that's* why they include `bdaddr`.  **Wait, what the fuck!??**

Clean up this egregious safety issue:

```
sudo chmod ug-s /opt/GIMX/usr/bin/*
```

Unfortunately, after having done this, you will find that Matheiu had reasons (not good reasons, but reasons nonetheless) for doing this.  Notice that four of the commands are not +s (e.g. `gimx-config`). These are meant to be userspace. They use config files and logs in your own user directory, and then call `gimx`.  (apparently it used to use `gksu`, but there were no doubt setups in which this method was not available)

I don't actually know what the solution to this problem is.

<!------------------------------->
# Building old rust versions

**(2018-06-13)**

When I tried to build rust from a commit circa December 2016, bootstrapping failed trying to download the `stage0` compiler from a dead amazonaws URL.  Solution:

* Create the `build/TARGET-TRIPLE/stage0` directory and put symlinks to the system `rustc` and `cargo` there (the ones provided by rustup).
* Comment out the part of `src/bootstrap/bootstrap.py` that downloads rustc.
* Try building (`x.py build`).  Probably it will die quickly due to the use of a now-removed nightly feature.  Try installing old rust stable versions and setting them as overrides until it works.
* If you still have no luck, `cargo-rustc-bisect` is capable of downloading even old nightlies that `rustup` somehow refuses to. In the `cargo-rustc-bisect` repo:
  ```rustc
  cargo new lol   # cargo-rustc-bisect demands a test-dir, whether it uses it or not
  cargo run -- --install 2016-12-23 --test-dir lol
  ```
  and it will appear in the `rustup` toolchain list.

<!------------------------------->
# Simulating a slow hard drive

**(2018-06-14)**

http://planet.jboss.org/post/debugging_tip_how_to_simulate_a_slow_hardisk

In summary

```sh
# as root
"cat > /etc/nbd-server/config" <<EOF
[generic]
[test]
    exportname = /home/lampam/test_nbd
    copyonwrite = false
EOF

# make blank test file
dd if=/dev/zero of=/home/lampam/test_nbd bs=1G count=1

sudo systemctl start nbd
# monitor with
journalctl -f --unit nbd

# newer versions don't accept a port number
sudo nbd-client -N test  127.0.0.1   /dev/nbd0

# connect and format
sudo mkfs /dev/nbd0 
sudo mkdir /mnt/nbd
# sync option is important to not allow the kernel to cheat!
sudo mount -o sync /dev/nbd0 /mnt/nbd
sudo chmod a+rwx /mnt/nbd
# disconnect
sudo umount /mnt/nbd
sudo nbd-client -d /dev/nbd0
sudo systemctl stop nbd

# connect through trickle, throttled to 20kbps
trickle -d 20 -u 20 -v nbd-server -d
sudo nbd-client -N test  127.0.0.1 /dev/nbd0
sudo mount -o sync /dev/nbd0 /mnt/nbd
```

<!------------------------------->
# When I open my laptop and see a blank screen

**(2018-07-19)**

I finally figured it out.  This happens occassionally after the following sequence of events:

- I close the lid with a monitor attached.  (the machine will not suspend)
- The machine does not suspend due to the monitor. Oops.
- I open the lid, wait for everything to show up, detach the monitor, wait for visual feedback (screen should flicker once), and close the lid again.
- Machine suspends.

Next time I open the lid, my system resumes from suspend but the screen might appear to remain off (not even backlit).
I can move to another tty using Ctrl+Alt+Fn, and those show up fine, but the screen turns back off if I return to the tty hosting X.

The solution is actually embarrasingly simple:

**Hit the projector key.** (`XF86Display`)

I guess the above sequence of events confuses plasma into using an incorrect monitor setup.

I saw messages in journalctl from kscreen about not using a configuration because "this is not what the user wants!", but did not have the presence of mind to record them.

**(2018-09-12)**

OH FFS WHY WOULD THEY DO THIS

...so...today I tried this and it didn't work.  After rebooting and trying the projector key, the reason is obvious: Now when you hit the key it opens a small overlay in the CENTER OF THE GODDAMN SCREEN that you have to interact with WITH YOUR MOUSE.  No keyboard keys appear to do anything to it (including repeated presses of the projector)

**What imbicile designed a Switch Displays menu that requires a working display!?!**

To future me, when this happens again:  **Good luck.**

...

And maybe try this: (I don't know if it will work!) **(Update 2018-10-11: IT WORKS!!!!!)**

```
xrandr --output LVDS-1 --auto
```

I suggest typing that into the Ctrl+Alt+F2 Linux console where you can see it, then Ctrl+Alt+F1 and blindly log in, open a new Konsole, do an Up-Enter, and pray.

<!-- ----------------------------->
# Building RSP2 on Komodo

**(2018-08-15)**

So many things have needed to be done for this.  Unfortunately I did not record most error messages:

* Python 3.7 required by `rsp2`
* newer versions of OpenSSL and libffi required by Python 3.7
* newer version of `cython` required by pip3
    * ...but I could never get pip3 to actually download anything.  SSL errors.
* `scipy` required by `rsp2`
* `spglib` required by `rsp2`
* a newer `binutils` because... hell if I remember.  I think it was because at some point I tried replacing `netlib` with a different LAPACK implementation and encountered a bug in `ld` (but after building `binutils` I soon ran into another error that I can't remember and went back to `netlib`).
* Newer `cmake` (`2.8.12.2 -> 3.12.1`) required by `netlib-src`
* autotools more recent than the system version required by the `libffi-sys` crate.
    * I did not do this and instead patched the crate to bring back `pkg-config`-based searching for shared libraries. (because I mean, c'mon, I just built libffi myself!!)
* `libclang` required by the `bindgen` crate
* `llvm` required by `clang`
* Newer `gcc` (`4.9.0 -> 8.2.0`) required to build `llvm`, as 4.9 had a bug
* Newer OpenMPI (`1.4.2 -> 3.1.1`) because rsmpi uses constants and types that are not available in version 1.x of the spec.

And some miscellaneous other things:

* The `make` automatic environment vars `CC`, `FC`, `CXX`, `LD`, `AR`, and `AS` should be set for a variety of reasons.
  I adjusted the `~/apps/gcc/*/env` scripts to do this.
* Sometimes object files appear in the `vendor/` source for one of the crates related to `openblas`, because they are for some reason written to the cached source in `.cargo`. These can make `cargo` mad at you when it sees them change.  If you see them, delete the offending source from `.cargo` and `vendor` on your local machine and rerun `cargo vendor`
* The modulefile on komodo for `mkl/10.3.5` points to nonexistent paths; I made a new one with correct paths.

Here's logs of what error messages I had the presence of mind to record:

**`gcc` bug encountered while building `llvm`** (fixed by updating from GCC 4.9.0 to GCC 7.2.0)
```
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp: In constructor ‘{anonymous}::ClobberWalker::generic_def_path_iterator<T, Walker>::generic_def_path_iterator() [with T = {anonymous}::ClobberWalker::DefPath; Walker = {anonymous}::ClobberWalker]’:
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp:594:5: error: conversion from ‘const llvm::NoneType’ to non-scalar type ‘llvm::Optional<unsigned int>’ requested
     generic_def_path_iterator() = default;
     ^
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp: In member function ‘llvm::iterator_range<{anonymous}::ClobberWalker::generic_def_path_iterator<{anonymous}::ClobberWalker::DefPath, {anonymous}::ClobberWalker> > {anonymous}::ClobberWalker::def_path({anonymous}::ClobberWalker::ListIndex)’:
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp:622:72: note: synthesized method ‘{anonymous}::ClobberWalker::generic_def_path_iterator<T, Walker>::generic_def_path_iterator() [with T = {anonymous}::ClobberWalker::DefPath; Walker = {anonymous}::ClobberWalker]’ first required here 
     return make_range(def_path_iterator(this, From), def_path_iterator());
                                                                        ^
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp: In constructor ‘{anonymous}::ClobberWalker::generic_def_path_iterator<T, Walker>::generic_def_path_iterator() [with T = const {anonymous}::ClobberWalker::DefPath; Walker = const {anonymous}::ClobberWalker]’:
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp:594:5: error: conversion from ‘const llvm::NoneType’ to non-scalar type ‘llvm::Optional<unsigned int>’ requested
     generic_def_path_iterator() = default;
     ^
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp: In member function ‘llvm::iterator_range<{anonymous}::ClobberWalker::generic_def_path_iterator<const {anonymous}::ClobberWalker::DefPath, const {anonymous}::ClobberWalker> > {anonymous}::ClobberWalker::const_def_path({anonymous}::ClobberWalker::ListIndex) const’:
/home/lampam/build/llvm/lib/Analysis/MemorySSA.cpp:627:47: note: synthesized method ‘{anonymous}::ClobberWalker::generic_def_path_iterator<T, Walker>::generic_def_path_iterator() [with T = const {anonymous}::ClobberWalker::DefPath; Walker = const {anonymous}::ClobberWalker]’ first required here 
                       const_def_path_iterator());
                                               ^
```

**`automake 1.16` needs a newer perl** (resolved by building automake 1.12 instead)
```
help2man: can't get `--help' info from automake-1.16
Try `--no-discard-stderr' if option outputs to stderr
make: *** [doc/automake-1.16.1] Error 2
```

<!------------------------------->
# Building gcc

**(2018-08-18)**

### The dependencies

IMPORTANT!!!!

When you try to configure gcc it will spit out errors about needing MPFR, MPC, etc.
**The version numbers listed in this error message are wrong for GCC 7.2.0.**

But fear not:

* **There is a script at `contrib/download_dependencies`.**
* It will download the correct versions, unzip them, and make symlinks in locations that are checked by GCC's build system.
* As long as those symlinks exist **you do not need to build them yourself.  They will be built when you build GCC.**  This should make things many times easier.

```
DEST=$HOME/apps/gcc/8.2.0

contrib/download_dependencies
./configure --prefix=$DEST --enable-languages=c,c++,fortran && make && make install
```

**NOTE:** On my first attempt I ran with `--enable-languages=all` and had `make -j4`.  This gave a weird error about "no rule for `(something-i-forget).h.in`" which persisted on repeated attempts to run `make`, even without `-j4`.  So I wiped everything clean (`rm -rf` all but `.git` and `git reset --hard`) and used the command written above.  I decided to ctrl-C and add back the `-j4` after a couple of minutes when it looked like the dependencies were all done being built.


<!------------------------------->
# debugging on komodo (or: why you can't just yet)

(2018-08-23)

* The latest gdb 0.8.1 doesn't support python 3.7 yet due to improper use of cpython internal APIs.
* when I tried to build gdb from master, perl (still komodo's old version) segfaulted.
  Sigh... one of these days I'll have no choice but to build perl.
* lldb 6.0.0 requires libedit.  Okay, taken care of.
* lldb 6.0.0 requires a version of Python2 with support for `except Type as ident:` syntax.
  (komodo's 2.4 predates this).
* I've built Python3 3 times on this machine, and don't particularly feel like building Python2
  right now.

<!------------------------------->
# lockfiles and slurm

(2018-08-24)

**The idea:** Have multiple independent slurm jobs (each using -N1) picking inputs from a single source.  Each input should only be computed once.

**The problem:** This requires claiming a directory somehow in a way not subject to race conditions.

## Things that didn't work

There is a utility called `flock` which atomically aquires a lockfile.  Luckily it is avaiable on Komodo.

However.... thankfully, I had the presence of mind to test it before using it.

**test-lockfile**
```bash
#!/usr/bin/env bash
# spawn several processes simultaneously
for p in $(seq 1 1 5); do (
    # iterate through inputs in a fixed sequence
    # (highly likely to create race conditions)
    for i in $(seq 1 1 300); do
        echo "$$.$p: check $i"
        output=lockfile-test-out/$i
        lock=$output/lock
        winner=$output/winner
        mkdir -p $output

        # zip forward to maximize race potential
        [[ -e $winner ]] && continue

        ( # Lock without race conditions
            flock -nx 200 || exit 1   # -x: exclusive (write) lock
                                      # -n: nonblocking
                                      # exit only exits the subshell
            [[ ! -e $winner ]] && {
                # (redundant, but not unreasonable, mkdir that nonetheless
                #  amplifies race conditions due to the time spent)
                mkdir -p $output
                echo $$.$p >>$winner
            }
            # lock is released when subshell exits
        ) 200>$lock
    done
)&
done
wait # otherwise slurm will kill the children
```

When working properly, every `winner` file should end up with one line (for 300 lines total). You can see that `flock` works fine for competition between processes on the same node (or at least, for children of the same process):

```sh
$ vim ./test-lockfiles # comment out the flock line
$ rm -rf lockfile-test-out && sbatch -N1 ./test-lockfiles
$ cat lockfile-test-out/*/winner | wc -l
1415
$ vim ./test-lockfiles # restore the flock line
$ rm -rf lockfile-test-out && sbatch -N1 ./test-lockfiles
$ cat lockfile-test-out/*/winner | wc -l
300
```

Unfortunately, **flock is insufficient for dealing with processes on multiple nodes.**

```sh
$ rm -rf lockfile-test-out && sbatch -N1 ./test-lockfiles && sbatch -N1 ./test-lockfiles && sbatch -N1 ./test-lockfiles
$ cat lockfile-test-out/*/winner | wc -l
616
```

When that failed I tried dumb hacks like this:

```sh
lock() {
    me=$1 # identifier for this process
    pidfile=$2 # lockfile

    # make a pidfile in a manner that presents an extremely small, but not
    # necessarily zero, window where multiple processes may enter a race.
    [[ -e "$pidfile" ]] && return 1
    echo $me >>$pidfile

    # At this point, processes on different compute nodes may momentarily
    # see different contents in $pidfile. Let's give the networked
    # filesystem some time to resolve these inconsistencies.
    #
    # Unfortunately even 1 whole second is not enough.
    sync # <-- done on a whim; not sure if it even makes a difference
    sleep 5

    # winner takes all
    [[ "$(head -n1 "$pidfile")" == "$me" ]]
}
```

but still ended up with 1% of race conditions going through.  I don't know how to force the filesystem to syncronize all updates to a given file across all nodes before reading from it.

## Things that do work

**`xargs`'s `--max-procs` (`-P`) option**

```
echo "${inputs[@]}" | xargs -n1 -P3 -- bash -c 'some-script $0'
```

This option of `xargs` can be used to simulate a semaphore, and it works far more effectively than gnu parallel's semaphore ever has.  With this, you can have a single slurm job that gives a dedicated node to each of three processes, by having `some-script` call `srun -N1` to allocate a job step using one process.

Newer versions of `xargs` also have `--process-slot-var=VARNAME` which will assign unique integers to a variable for each of the running commands

<!------------------------------->
# `no space left on device` while building scipy

**(2018-08-26)**

**Wow.** I've never seen anything like this before.

On my system, the tempfs filesystem at `/tmp` is ~8GB large.  This might have something to do with my use of `ulimit -v`.  I am not sure.  But in any case, **building and installing `scipy` now requires more than 8GB of space in `/tmp`.**  If you get this error, you'll need to remount the tempfs.

```
sudo mount -o remount,size=16G /tmp
```

**_Wow._**

...

oh, and also.  I highly doubt I'll ever run into this again, but:

```
    scipy/cluster/_vq.c:9862:13: error: ‘PyThreadState’ {aka ‘struct _ts’} has no member named ‘exc_value’; did you mean ‘curexc_value’?
         tstate->exc_value = local_value;
                 ^~~~~~~~~
                 curexc_value
    scipy/cluster/_vq.c:9863:13: error: ‘PyThreadState’ {aka ‘struct _ts’} has no member named ‘exc_traceback’; did you mean ‘curexc_traceback’?
         tstate->exc_traceback = local_tb;
                 ^~~~~~~~~~~~~
                 curexc_traceback
```

apparently the cython on Arch does not yet have the fix for 3.7 compatibility? (cython 28.5).  I decided to just install scipy directly through `pacman` instead.

<!------------------------------->
# Bash 4.x on komodo

I built it, but don't know what to do with it.

### Difficulty changing the default shell.

I can't use `chsh`.
Initially to get around this I tried some trick where `.bash_profile` did something like this:

```bash
module use $HOME/apps/bash/4.4
module load bash
exec $BASH --rcfile $HOME/.bashrc.for-reals
```

and this seemed to work, but...

### My built `bash` binary segfaults

```
$ ls **/*.so
Segmentation fault
```

...so making it the default shell seems like a bad idea.

(oddly, `make check` in the bash source tree succeeds just fine)

### Trouble with slurm when calling it from `$PATH`

After the prior discovery I tried a more conservative approach:

* Load the `bash` module in `.bashrc`
* When I want to use bash-4.x features, I can just call `bash` to start a nested shell

I tried this, but discovered that my `sbatch` scripts no longer knew about the `module` function.

### In summary

Just don't.  I moved the module to a `DO-NOT-USE` directory.

<!------------------------------->
# clion "Mark Directory as..." workaround

**Problem:** Rust projects in clion lack a "Mark Directory as..." option because they aren't CMake projects.  This leads clion to, of course, assume that EVERYTHING is project source files, and so it indexes way more than it needs to.

**Solution:** Add a single line to `.idea/misc.xml` to trick CLion into believing the project is a CMake project.

**`misc.xml`**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <!-- vvv this line !!!!! vvv -->
  <component name="CMakeWorkspace" PROJECT_DIR="$PROJECT_DIR$" />
  <component name="CargoProjects">
    <cargoProject FILE="$PROJECT_DIR$/Cargo.toml" />
  </component>
  ...
```

And there you go; right clicking on the directory tree in clion should now have a "Mark Directory as..." option.

(note: when you next start clion, it will make a cmake-build-debug folder; open Settings and go to "Build, Execution, and Deployment > CMake" to disable rid of that.)



<!------------------------------->
# More garbage with komodo

(2018-09-21)

You can't do `srun -N1 some-mpi-app` on komodo where `some-mpi-app` was built against my `openmpi` 3.x build, because it requires pmi support from slurm.  I cannot build `openmpi` 3.x against slurm's PMI because `pmi.h` is nowhere to be found. `apps/slurm/2.2.4/` doesn't even have an `include` dir! (it does have a `libpmi.so`, though...)

I'm now working around this with an `sstep` helper script that runs an sbatch script as a job step synchronously, something that cannot easily be done in Slurm 2.2.4 which lacks `sbatch --wait`.

<!------------------------------->

# `vagrant` test cluster for `slurm`

The `archlinux/archlinux` vagrant box has two providers: `libvirt` and `virtualbox`.

The `virtualbox` package in the arch repo seems horribly broken as of August 2018 (I got errors about nonexistent kernel modules), so go with `libvirt`.

```
sudo pacman -S libvirt qemu dnsmasq vagrant # necessary
sudo pacman -S virt-manager virt-viewer # good debugging tools
```

* Verify hardware support for KVM: https://wiki.archlinux.org/index.php/KVM#Checking_support_for_KVM

* Check that vendor-appropriate KVM module is loaded

```
lsmod | grep kvm
```

If you see `kvm` but do not see either `kvm_intel` or `kvm_amd` (and attempting to `modprobe kvm-intel` gives "Operation not supported"), check that virtualization is not disabled in your BIOS settings.

* Install vagrant plugins

```
vagrant box add archlinux/archlinux
# choose libvirt at the interactive prompt

vagrant plugin install pkg-config  # the other plugin fails to install without this
vagrant plugin install vagrant-libvirt
```

### Debugging tips

**Find state and names of all libvirt domains:**

```
sudo virsh list
```

If `vagrant ssh` or `vagrant up` blocks forever, try **viewing the primary monitor.** This will let you see e.g. the BIOS screen on a domain that refuses to boot.

```
sudo virt-viewer --connect qemu:///session cluster_server1
```

For **broadly useful info on an image file:** (format, size...)

```
$ sudo qemu-img info /var/lib/libvirt/images/cluster-fast_vagrant_box_image_0.img
image: /var/lib/libvirt/images/cluster-fast_vagrant_box_image_0.img
file format: qcow2
virtual size: 20G (21474836480 bytes)
disk size: 3.3G
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
```

If you want to **check the filesystem directly on an image file,** try `guestfish`.

```
sudo guestfish /var/lib/libvirt/images/cluster-fast_vagrant_box_image_0.img

><fs> run
><fs> mount /dev/sda2 /
><fs> ls /etc
```

### libguestfs/`guestfish`

(**Note:** This no longer fully applies as, in the end, I came upon a solution which does not rely on that script. However, I'll keep it here because `guestfish` is useful for debugging images that you are trying to package for vagrant)

One optional script I use (for saving a prebuilt image) requires libguestfs for its `guestfish` command.

```
sudo pikaur -S libguestfs
```

If one of its AUR dependencies, `hivex`, dies during its configure script with:

```
checking for mmap... (cached) yes
checking for bindtextdomain... yes
checking for pod2man... no
configure: error: pod2man must be installed
==> ERROR: A failure occurred in build().
    Aborting...
```

...sigh.  I don't really know what to say here. So, here's the thing.

* The binaries it wants are in `/usr/bin/core_perl`.
* You'd think that adding this to your `PATH` would resolve the error.  For some reason, however... it does not.  Yes, I verified that the variable is exported.  Yes, I verified that the binary can be found by `which`.  There are forces at work here beyond my understanding. :/
* Adding symlinks to `/usr/bin` DOES resolve the error.

It only needs them to make documentation, so... let's do this quickly, quietly, and get it over with.

```sh
# ew ew gross ewww
sudo ln -s core_perl/pod2man /usr/bin
sudo ln -s core_perl/pod2text /usr/bin

pikaur -S libguestfs

# THIS NEVER HAPPENED
sudo rm /usr/bin/pod2man
sudo rm /usr/bin/pod2text
```

### Fixing issues while packaging boxes

Packaging a libvirt box is NOT easy.  Even beginning with a valid box, you cannot just `halt` it and package it.  In the final steps of your provisioning script, you need to burn bridges and basically *undo* a bunch of changes that took place inside the box during `vagrant up`.

If you run into problems, you're unlikely to find much help by searching the symptoms.  Almos all of the fixes I had to make felt completely esoteric and took hours to figure out.

The best thing to do is **find code that makes `libvirt` packages.** Look at all of the unsightly hacks therein, and figure out which ones apply to your system.

E.g.:

* https://github.com/cgwalters/qcow2-to-vagrant/blob/master/qcow2-to-vagrant
* https://github.com/jakobadam/packer-qemu-templates  (look in the various `scripts` subfolders)

One other thing:  You can't just pack a `qcow2` image directly from `/var/lib/libvirt/images`, because it is stored as a diff against another image.  (check `qemu-img info`, you'll see what I mean).  **Use `qemu-img convert` to convert it into `raw` format, then back into `qcow2` to normalize it.**

<!------------------------------->

# CLion not finding python modules nested under subdir

(2019-01-23)

In rsp2 I have this sort of directory structure:

```
rsp2
└── src
    ├── io
    ├── python
    │   └── rsp2
    ├── structure
    └── tasks
```

`rsp2/src/python` is both a Cargo package root (it contains a `Cargo.toml`) and a python root (it contains the python package `rsp2`).  When I write other python scripts that try to use this module, I get a "not found" error.

CLion doesn't make it easy to add a path to `PYTHONPATH`.  It can only add source roots and content roots automatically.  Content roots don't even exist in CLion even though the option to add them to `PYTHONPATH` is there (they're a PyCharm thing). So we're stuck with source roots.

What is a source root?  It's a folder "Marked as Source" in the project tree. Unfortunately, you are forbidden from marking a directory as source if it lies within another directory that is already marked as source.  Therefore, you must:

* Unmark `rsp2/src` as source.
* Mark every subdirectory of `rsp2/src` (including `rsp2/src/python`) as source.

<!------------------------------->

# Laptop failing to suspend

(2019-03-28)

After an update to my arch packages, my ThinkPad T430s now sometimes fails to suspend when the lid is closed, going into a state where the power button blinks and fans can be heard spinning.

Things tried:

- Downgrading to `linux-lts` kernel (did not work)
- This: https://bbs.archlinux.org/viewtopic.php?pid=1835891#p1835891

<!------------------------------->

# Environment modules setup

(2019-06-05)

Keywords: cm, modulefiles, apps, cluster, komodo, matisse

Since around 2018, I've been installing my compiled software on komodo to environment modules (i.e. `mod load`, `mod avail`...).

My setup is hosted at [https://github.com/exphp-share/cm-files](https://github.com/exphp-share/cm-files).
