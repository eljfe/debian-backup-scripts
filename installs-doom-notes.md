# doom emacs

## install

Per the [instructions](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

## errors

```bash
eljfe@sherrysmbp ~ ∅ doom doctor                      7:21:50 
The doctor will see you now...

> Checking your Emacs version...
> Checking for Doom's prerequisites...
  x Couldn't find the `rg' binary; this a hard dependecy for Doom, file searches may not work at all
> Checking for Emacs config conflicts...
> Checking for missing Emacs features...
> Checking for private config conflicts...
> Checking for common environmental issues...
> Checking for stale elc files...
> Checking for problematic git global settings...
> Checking Doom Emacs...
  ✓ Initialized Doom Emacs 3.0.0-pre
  ✓ Detected 31 modules
  ✓ Detected 115 packages
  > Checking Doom core for irregularities...
    ! Couldn't find the `fd' binary; project file searches will be slightly slower
    Found font NFM.ttf
  > Checking for stale elc files in your DOOMDIR...
  > Checking your enabled modules...
    Some advanced consult filtering features will not work as a result, see the
    module readme.
    > :completion vertico
      ! The installed ripgrep binary was not built with support for PCRE lookaheads.
    > :lang markdown
      ! Couldn't find a markdown compiler, `markdown-preview' won't work
    > :lang sh
      ! Couldn't find shellcheck. Shell script linting will not work

There are 4 warnings!
There is 1 error!
```

The `rp` fail is solved with,

```bash
sudo apt install ripgrep
```

The `fd` is solved with,

```bash
sudo apt install fd
```

The `shellcheck` error,

```bash
sudo apt install shellcheck
```

See below for the 

### latex

```bash
sudo apt-get install texlive-latex-extra
```
then test with,

```bash
tex --version
```


### pandoc

```bash
sudo apt install pandoc
```

## References

- [official Doom install](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)
- [latex with pandoc](https://pp4rs.github.io/2021-uzh-installation-guide/pandoc/)
- [doom fails reddit](https://www.reddit.com/r/DoomEmacs/comments/jw1wj0/help_a_noob_error_after_install/?rdt=59688)
