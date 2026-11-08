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
      plugins.txt, plugins-late.txt                         Antidote lists (before / after compinit)
      local.zsh                                             per-machine overrides (git-ignored; see local.zsh.example)
      env/      xdg.zsh, tools.zsh, path.zsh                exports only
      rc/       base, plugins, options, completion,         interactive setup, in load order
                plugins-late, keybindings, lazy, prompt, sudo (vendored OMZ)
    aliases/    *.zsh, loaded alphabetically; 00-defaults.zsh sorts first so
                every other file can override it
    functions/  one autoloaded function per file (file name = function name, no extension)
    integrations/  third-party shell integrations (iTerm2, ...)
    archive/    retired files and backups (git-ignored)
    Brewfile, bootstrap.sh   dependencies and new-machine setup

rc.zsh documents the interactive load order:
base -> plugins -> options -> completion (compinit) -> plugins-late -> keybindings -> aliases ->
lazy -> integrations -> local -> prompt.

## Plugins (Antidote)

Two lists name the plugins: zsh/plugins.txt (loaded before compinit, so it can ship
completions) and zsh/plugins-late.txt (loaded after compinit: plugins that bind or wrap
line-editor widgets). rc/plugins.zsh and rc/plugins-late.zsh compile each into a static
bundle in $XDG_CACHE_HOME/zsh/ whenever the list is newer, so a normal startup is a single
`source` per list. Plugins marked `kind:defer` load after the first prompt (romkatv/zsh-defer).
Clones live in $ANTIDOTE_HOME ($XDG_CACHE_HOME/antidote).

    antidote list      # installed plugins
    antidote update    # pull new plugin versions

The single compinit runs in rc/completion.zsh after the early plugins have extended fpath;
the dump is reused for 24 h and rebuilt early when plugins.txt changes or when Homebrew
adds or relinks a completion, so no manual step is needed after `brew install`.

## Install (macOS)

    git clone https://github.com/AnshumanSanghvi/dotfiles.git ~/.mydotfiles
    ~/.mydotfiles/bootstrap.sh
    # open a new terminal; the first start clones the plugins listed in zsh/plugins.txt

bootstrap.sh is safe to re-run. It appends the ZDOTDIR line to /etc/zshenv (sudo), runs
`brew bundle` on the Brewfile (zsh, antidote, eza, fzf, zoxide, ... see the file for the
required and optional tools), makes the Homebrew zsh the login shell (below), and clones the
Jovial prompt into ~/.local/share/jovial.

### Default shell (Homebrew zsh)

The Brewfile installs zsh. bootstrap.sh then registers it in /etc/shells (sudo) and selects it
with chsh (asks for your password). It first checks that the Homebrew zsh reads /etc/zshenv,
and leaves the login shell alone, with a warning, if it does not. The manual equivalent
(Apple Silicon path; Intel Macs use /usr/local/bin/zsh):

    brew install zsh
    grep -qx /opt/homebrew/bin/zsh /etc/shells || echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/zsh

Open a new terminal and verify with `echo $SHELL $ZSH_VERSION $ZDOTDIR`. To undo, run
`chsh -s /bin/zsh`, and do that before any `brew uninstall zsh`, or the login shell points at
a missing binary. iTerm2 profiles using the default "Login shell" command follow the change.

## Checks

    sh scripts/check.sh                    # zsh -n on every file, then a startup smoke test
    git config core.hooksPath .githooks    # run it before each commit (bootstrap.sh sets this)

The smoke test starts an interactive zsh and fails on a nonzero exit status or any output
on stderr. If gitleaks is installed, the script also scans the staged changes and the
committed history for secrets.

## Profiling

    zprofsh     # per-function profile of an interactive startup (zprof)
    timezsh     # wall-clock startup time