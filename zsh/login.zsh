# login.zsh
# ==============================================================================
# Login shells, after rc.zsh. Background work only; it never delays the prompt.
# ==============================================================================

# Compile the completion dump into a binary .zwc so later shells load it faster.
# This is the ONLY zcompile call in these dotfiles (Prezto itself does not compile).
# Runs only in login shells; iTerm2 and Terminal.app open login shells by default.
{
  for _f in "$XDG_CACHE_HOME/prezto/zcompdump" "$XDG_CACHE_HOME/zplug/zcompdump"; do
    [[ -s $_f && ( ! -s $_f.zwc || $_f -nt $_f.zwc ) ]] && zcompile "$_f"
  done
} &!