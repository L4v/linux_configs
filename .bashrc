#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# NOTE(Jovan): For displaying git branch in
# current dir (with dirty checking)

check_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]]
}

parse_git_dirty() {
    check_git_dirty && echo "*"
}

color_git() {
    check_git_dirty && echo "\[\033[0;35m\]" \
    || echo "\[\033[0;37m\]"
}

# TODO(Jovan): Implement colorchange
parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ → \
\1$(parse_git_dirty)/"
}

#export PS1="[\e[1;92m\u\e[0;39m@\h \W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\]$ "

export PS1="\u\[\033[00m\]@\h[\[\033[92m\]\W\[\033[00m\]\[\033[00m\]\$(parse_git_branch)\[\033[00m\]]$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NOTE(Jovan): Custom scripts
export PATH="$PATH:~/.scripts"

# NOTE(Jovan): Github autocomplete
test -f ~/Scripts/git-completion.bash && . $_

# NOTE(Jovan): Upload files to transfer.sh
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "http://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "http://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "http://transfer.sh/$file_name"|tee /dev/null;fi;}

source /usr/share/nvm/init-nvm.sh

# NOTE(Jovan): GitCredentialManager store
export GCM_CREDENTIAL_STORE=gpg
