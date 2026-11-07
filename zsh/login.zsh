# login.zsh
# ==============================================================================
# Login shells, after rc.zsh. Background work only; it never delays the prompt.
# ==============================================================================

# Compile the completion dump and the plugin bundle into binary .zwc files. zsh uses a
# .zwc automatically when it is newer than its source; after a rebuild the stale .zwc is
# ignored until this runs again at the next login. This is the ONLY zcompile call in
# these dotfiles. iTerm2 and Terminal.app open login shells by default.
{
  for _f in "$XDG_CACHE_HOME/zsh/zcompdump" "$XDG_CACHE_HOME/zsh/plugins.zsh"; do
    [[ -s $_f && ( ! -s $_f.zwc || $_f -nt $_f.zwc ) ]] && zcompile "$_f"
  done
} &!