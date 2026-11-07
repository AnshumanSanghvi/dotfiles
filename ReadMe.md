# mydotfiles

Zsh configuration. ZDOTDIR is ~/.mydotfiles/zsh (set by /etc/zshenv, see Install).
Plugins are managed by Antidote; everything else (options, key bindings, completion,
aliases) is plain zsh in this repo.

## Load order (macOS, interactive login shell)

| Step | File | Content |
|---|---|---|
| 1 | /etc/zshenv (system) | sets ZDOTDIR for every zsh |
| 2 | zsh/.zshenv -> env.zsh | every shell: dirs, Homebrew, locale, XDG |
| 3 | /etc/zprofile (system) | stock macOS: LANG fallback, path_helper (login only) |
| 4 | zsh/.zprofile -> profile.zsh | login: env/xdg, env/tools, env/path |
| 5 | /etc/zshrc (system) | resets HISTFILE/HISTSIZE/SAVEHIST (why history is set in rc/options.zsh) |
| 6 | zsh/.zshrc -> rc.zsh | interactive: rc/*.zsh, aliases/, integrations/ |
| 7 | zsh/.zlogin -> login.zsh | background zcompile of the completion dump and plugin bundle |
| 8 | zsh/.zlogout -> logout.zsh | on exit |

Non-login interactive shells run 1, 2, 5 and 6. Scripts run only 1 and 2.

The five dot-named files in zsh/ are one-line stubs (zsh requires those exact names);
all content lives in the matching .zsh files.

## Layout

    zsh/
      env.zsh, profile.zsh, rc.zsh, login.zsh, logout.zsh   one file per startup stage
      plugins.txt                                           Antidote plugin list
      local.zsh                                             per-machine overrides (git-ignored; see local.zsh.example)
      env/      xdg.zsh, tools.zsh, path.zsh                exports only
      rc/       plugins, options, keybindings, completion,  interactive setup, in load order
                lazy, prompt, base, sudo (vendored OMZ)
    aliases/    *.zsh, loaded alphabetically; 00-defaults.zsh sorts first so
                every other file can override it
    functions/  one autoloaded function per file (file name = function name, no extension)
    integrations/  third-party shell integrations (iTerm2, ...)
    archive/    retired files and backups (git-ignored)
    Brewfile, bootstrap.sh   dependencies and new-machine setup

rc.zsh documents the interactive load order:
base -> plugins -> options -> keybindings -> completion -> aliases -> lazy -> integrations -> local -> prompt.

## Plugins (Antidote)

zsh/plugins.txt lists the plugins. rc/plugins.zsh compiles it into a static bundle at
$XDG_CACHE_HOME/zsh/plugins.zsh whenever plugins.txt is newer, so a normal startup is a
single `source`. Plugins marked `kind:defer` load after the first prompt (romkatv/zsh-defer).
Clones live in $ANTIDOTE_HOME ($XDG_CACHE_HOME/antidote).

    antidote list      # installed plugins
    antidote update    # pull new plugin versions

The single compinit runs in rc/completion.zsh after all plugins have extended fpath;
the dump is reused for 24 h and rebuilt early when plugins.txt changes or when Homebrew
adds or relinks a completion, so no manual step is needed after `brew install`.

## Install (macOS)

    git clone https://github.com/AnshumanSanghvi/dotfiles.git ~/.mydotfiles
    ~/.mydotfiles/bootstrap.sh
    # open a new terminal; the first start clones the plugins listed in zsh/plugins.txt

bootstrap.sh is safe to re-run. It appends the ZDOTDIR line to /etc/zshenv (sudo), runs
`brew bundle` on the Brewfile (antidote, eza, fzf, zoxide, ... see the file for the
required and optional tools), and clones the Jovial prompt into ~/.local/share/jovial.

## Checks

    sh scripts/check.sh                    # zsh -n on every file, then a startup smoke test
    git config core.hooksPath .githooks    # run it before each commit (bootstrap.sh sets this)

The smoke test starts an interactive zsh and fails on a nonzero exit status or any output
on stderr.

## Profiling

    zprofsh     # per-function profile of an interactive startup (zprof)
    timezsh     # wall-clock startup time