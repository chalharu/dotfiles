export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'


PERL_MB_OPT="--install_base \"/Users/mitsu/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/mitsu/perl5"; export PERL_MM_OPT;

b2d_xhyve_root="/opt/boot2docker-xhyve"
if [ -f ${b2d_xhyve_root}/.mac_address ]; then
    export DOCKER_HOST=tcp://`${b2d_xhyve_root}/uuid2ip/mac2ip.sh $(cat ${b2d_xhyve_root}/.mac_address)`:2375
fi

alias start-docker='pushd ${b2d_xhyve_root} >/dev/null; make run; popd >/dev/null'
alias halt-docker=' pushd ${b2d_xhyve_root} >/dev/null; make halt; popd >/dev/null'

