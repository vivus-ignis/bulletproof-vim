# Bulletproof Vim

## What is it?

It is a custom vimrc and a dockerfile to build portable-across-x86-linux-distributions helper tools for vim.
It is a tested and proven setup that I, the author of ["The Art Of The Terminal" Youtube channel](https://www.youtube.com/@TheArtOfTheTerminal), use daily.

The guiding principles are:

- it is my personal configuration where I include that what makes sense for me
- (almost) nothing should happen unless I explicitly want that
- minimal set of plugins
- all plugins are feature-complete
- all plugins are version-pinned down to a git commit
- no external dependencies are needed (vimtools from this repository are absolutely optional)
- remote-vim-session friendly (just copy the .vimrc and -- optionally -- compiled vimtools binaries)
- no nodejs for linters & fixers

## How to install

- clone this repo
- copy `.vimrc` to your `$HOME`
- if you want tested and stable linters & fixers for [ALE](https://github.com/dense-analysis/ale) and you don't want to pollute your system packages, read the next chapter
- install [vim plugin manager](https://github.com/junegunn/vim-plug)

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs ihttps://raw.githubusercontent.com/junegunn/vim-plug/e216852799c98de7f47309cc0a2ac6e294d0999c/plug.vim
```

- install vim plugins: start vim and type `:PlugInstall`

## Vimtools

I like [ALE](https://github.com/dense-analysis/ale) for "code intelligence", but I don't like installing system packages for linters & fixers, especially on remote servers. Instead, I build portable linux binaries using docker and then just `scp` them to where I need them.

The process is simple:

```bash
cd vimtools
docker build --output type=local,dest=./out .
```

Then just copy contents of the `./out` directory to a directory included in `PATH` environment variable. I usually do it like this:

```bash
ssh remote-server mkdir -p ~/.vim/tools
scp ./out/* remote-server:~/.vim/tools/
```

or -- for a local machine:

```bash
mkdir -p ~/.vim/tools
cp ./out/* ~/.vim/tools/
```

Then adjust your `$PATH` by adding `~/.vim/tools` to it.

### WHat about vimtools for python?

Python linters/fixers/LSPs should be installed using a package & virtualenv manager like poetry, so do something like

```bash
poetry add --dev ruff pyright
```

## Copy from vim running in tmux to your local system's clipboard

More often than not I'm working with vim on a remote server, in a tmux session. And sometimes I need to copy a block of text from vim to a desktop application running on my local machine (for example, to a browser). Easier said than done with vanilla vim!

With bulletproof vim it's possible. Just add this to your `.tmux.conf`:

```
set -s set-clipboard on
set -as terminal-features ',screen-256color:clipboard'
```

Restart tmux, run vim, select the portion you want to copy and press `,c`, Now the selection is in your system clipboard.

## New Hotkeys

These are custom hotkeys I've added in my `.vimrc`:

| Hotkey  | What for |
|---------|----------|
| `Tab`   | Switch to another vim window (shortcut for `Ctrl-w + w` |
| `,q`    | Close buffer (won't do if a buffer is modified) |
| `,.`    | Switch to previously opened buffer |
| `mm`    | Set/unset a line bookmark |
| `mn`    | Jump to next line bookmark |
| `mp`    | Jump to previous line bookmark |
| `,ma`   | Show all line bookmarks |
| `Ctrl-k`| Jump to next ALE warning |
| `Ctrl-j`| Jump to previous ALE warning |
| `,fx`   | Enable ALE fixers |
| `Ctrl-/`| Open file manager |
| `,ss`   | Teleport to a buffer location by 2 characters |
| `,ff`   | Find file by name |
| `,fd`   | Find directory by name |
| `,fg`   | Find (grep) *in* files |
| `,fb`   | List of buffers |
| `,fp`   | Reveal previous search results |
