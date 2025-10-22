# Mash

(Bangers &) Mash is a Vim plugin that mashes together existing Vim functionality with shell commands.

A couple of general advantages of the Mash approach when compared to other existing solutions to the same problems:

1. **Flexibility:** For example, [`pbpaste`](https://ss64.com/mac/pbpaste.html) on macOS outputs the clipboard contents, so with `:Bgrep pbpaste` Vim will parse `grep` output from the clipboard (e.g., the built-in `:grep` command with the `'grepprg'` variable make this more difficult).
2. **Repeatability:** Since this approach only runs commands with arguments from the command line, like `:Bgrep fd mash`, it's easy to repeat (or refine) previous commands using Vim's command line history by hitting up arrow (e.g., as opposed to fuzzy finders, which present a custom UI, if you want to re-open the same file you have to go through that UI every time).

## The Way of Mash

1. Don't build specific tools into your editor, instead leverage flexible functionality that can work with a myriad of tools.
2. Don't build specific workflows into your editor, instead use efficient functionality that can be composed together to accomplish complex tasks.
3. Minimize editing your config, instead to seek to freeze your config such that it supports our needs today and the needs of tomorrow.

## Cheat Sheet

All the commands start with `B`, the `B` prefix was chosen because the `!` to run a shell command in Vim is called a bang, and it's the same as the first letter of Bash, the most popular shell.

- `Bg rg foo`: Populate the quickfix list from an `rg` search.
- `Ba fd foo`: Populate the argument list from an `fd` search.
- `Bm make`: Run a compile command, populating the quickfix list with any errors.
- `Bn git show`, `Bv git show`, `Btabe git show`: Show the current `git` commit in a horizontal split, a vertical split, or a new tab.

## Notes

Adding a bang (`!`), does the same behavior as the equivalent Vim built-in command (when the internal command supports one). For example, `:Bgrep!` won't automatically jump to the first match, just like `:grep!`. The `Bn[ew]` family of commands implement different bang behavior (because the built-in `:new` does not support a bang).

## `:Ba[rgs][!]`

Wrapper around `:args`.

Populates the argument list with the result of a shell command. Each line is interpreted as a path to a file (a NULL byte terminates input).

### Example

`:Bargs fd mash` uses [`fd`](https://github.com/sharkdp/fd) to populate the argument list with all the files with `mash` in the name (recursively from the current directory, because the way `fd` works by default).

#### Built-In Alternative

<p><code>args `fd mash`</code> (but this won't handle matches with spaces in their filenames properly).</p>

## Grep

### `:Bg[rep][!]`

Run the arguments as a `grep` program, populating the quickfix list with the matching lines. With a bang (`!`), it doesn't automatically jump to the first match.

#### Example

`:Bgrep rg --vimgrep mash` uses [ripgrep](https://github.com/BurntSushi/ripgrep) to populate the quickfix list with all the lines that contain `mash` (recursively from the current directory, because the way `rg` works by default).

#### Built-In Alternative

`:set grepprg=rg\ --vimgrep | grep mash` but that has the side effect of setting `'grepprg'` (which might be desirable! Setting `'grepprg'` to `rg` is a great alternative if the built-in `:grep` behavior isn't useful).

`:cexpr system('rg --vimgrep mash')` will also likely work, although technically this uses `'errorformat'` instead of `'grepformat'` to parse matching lines (note that `%`, which can usually be used on the command line to reference the current file, will not work in this context).

### `:Blg[rep][!]`

The same as `:Bgrep` but populate the location list instead of the quickfix list.

## Make

### `:Bm[ake][!]`

Run the arguments as a `make` program, populating the quickfix list with the lines with errors using `'errorformat'`. With a bang (`!`), it doesn't automatically jump to the first match.

#### Example

`:Bmake clang %` compiles the current file with `clang`.

#### Built-In Alternative

`:set makeprg=clang\ % | make`.

`:cexpr system('clang hello_world.c')` will also work (although `%` to reference the current file will not work in this context).

### `:Blm[ake][!]`

The same as `:Bgrep` but populate the location list instead of the quickfix list.

## New Window

Commands that create a new buffer containing the output of a shell command.

The buffer will be named after the shell command, for example `Bnew git show` will create a buffer named `git show`. With a bang (`!`) the output will be read only (`setlocal buftype=nofile readonly nomodifiable`), won't prompt to save the buffer (e.g., `:qa` without a bang will still quit without saving the buffer) and the same buffer will be re-used for subsequent runs (without a bang, a new buffer will be created appending a number to the end, e.g., `git show 2`). These changes make `:shn!` more appropriate just as *a viewer* of shell output.

### Example

`:Bnew git diff` to create a new diff buffer named `git diff` containing the output of `git diff`.

### Built-In Alternative

`:new | r !git diff` but this adds an extra new line at the top and bottom of the output, and doesn't detect the file type. To solve these issues `:new | 0r !git diff ^J norm Gddgg | filetype detect` should work but doesn't seem to in practice (`^J` means do `CTRL-V_CTRL-J` which is the command separator to use after a `:!` to perform a another Vim command instead of piping to a shell command).

### `:Be[new][!]`

Open a new buffer containing the result of a shell command (like `:enew` this will fail unless unless `'hidden'` is set or `'autowriteall'` is set and the file can be written).

### `:Bn[ew][!]`

Open a new buffer in a new window containing the result of a shell command.

### `:Btabn[ew][!]`, `:Btabe[dit][!]`

Open a new buffer on a new tab page containing the result of a shell command.

### `:Bv[new][!]`

Like `:Bn[ew][!]` but split vertically.

