# mydotfiles

Zsh configuration. ZDOTDIR is ~/.mydotfiles/zsh (set in zsh/env.zsh).

## Load order (macOS, interactive login shell)

| Step | File | Content |
|---|---|---|
| 1 | /etc/zshenv (system) | sets ZDOTDIR for every zsh |
| 2 | zsh/.zshenv -> env.zsh | every shell: dirs, Homebrew, locale, XDG |
| 3 | /etc/zprofile (system) | stock macOS: LANG fallback, path_helper (login only) |
| 4 | zsh/.zprofile -> profile.zsh | login: env/xdg, env/tools, env/path |
| 5 | /etc/zshrc (system) | resets HISTFILE/HISTSIZE/SAVEHIST (why history is set in .zpreztorc) |
| 6 | zsh/.zshrc -> rc.zsh | interactive: rc/*.zsh, aliases/, integrations/ |
| 7 | zsh/.zlogin -> login.zsh | background zcompile of the completion dump |
| 8 | zsh/.zlogout -> logout.zsh | on exit |

Non-login interactive shells run 2 (via the exported ZDOTDIR), 4 and 5. Scripts run only 2.

## Layout
Non-login interactive shells run 2, 5 and 6. Scripts run only 2.” (Steps 1 and 2 apply to all.)