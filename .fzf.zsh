# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 50% \
--border sharp \
--layout reverse \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒
--preview='cat {}'
--preview-window=right:60%:wrap"