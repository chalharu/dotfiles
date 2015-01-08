$(boot2docker shellinit)
eval "$(rbenv init -)"

if [ -f ~/.sensitive_profile ]; then
  . ~/.sensitive_profile
fi

