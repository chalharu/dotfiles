export PATH=$HOME/.local/bin:$HOME/.rbenv/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
alias jhbuild="PERL_MB_OPT= PERL_MM_OPT= PATH=$HOME/.local/bin:$HOME/gtk/inst/bin:/usr/bin:/bin:/usr/sbin:/sbin jhbuild"
# alias rm='rmtrash'
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(plenv init -)"

source dnvm.sh

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.sensitive_profile ]; then
  . ~/.sensitive_profile
fi
