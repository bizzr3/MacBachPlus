
RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
PURPLE='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
NIL='\[\033[00m\]'

# Hostname styles
FULL='\H'
SHORT='\h'

UC=$GREEN
LC=$BLUE
HD=$SHORT

# Prompt function because PROMPT_COMMAND is awesome
function set_prompt() {
    # show the host only and be done with it.
    host="${UC}${HD}${NIL}"

    # Special vim-tab-like shortpath (~/folder/directory/foo => ~/f/d/foo)
    _pwd=`pwd | sed "s#$HOME#~#"`
    if [[ $_pwd == "~" ]]; then
       _dirname=$_pwd
    else
       _dirname=`dirname "$_pwd" `
        if [[ $_dirname == "/" ]]; then
              _dirname=""
        fi
       _dirname="$_dirname/`basename "$_pwd"`"
    fi
    path="${_dirname}"
    myuser="${UC}\u${NIL}"

    # Dirtiness from:
    # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
    if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then dirty=""
    else
       dirty="${RED}*${NIL}"
    fi
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then
       branch=" ${NIL}(git@${PURPLE}${_branch}${dirty}${NIL})"
    fi

    # Dollar/pound sign
    end="${LC}\$${NIL} "

    # Virtual Env
    if [[ $VIRTUAL_ENV != "" ]]
       then
           venv=" ${RED}(${VIRTUAL_ENV##*/})"
    else
       venv=''
    fi

    # Anaconda conda environments
    if [[ $CONDA_DEFAULT_ENV != "" ]]
       then
           conda=" ${RED}(${CONDA_DEFAULT_ENV##*/})"
    else
       conda=''
    fi

    export PS1="${myuser}:${venv}${conda}${branch} ${end}"
    # export PS1="${myuser}\h${venv}${branch} ${end}"
}

export PROMPT_COMMAND=set_prompt
alias l='ls'
alias ll='ls -lah'
alias ls='ls -GFh'
alias ?='pwd'
alias c='clear'
alias g?='git status'
alias m.='git checkout master'
alias gl='git branch'
alias p.='cd /Users/bizzr3/projects/rabbit/'
alias ??='cat /Users/bizzr3/.bash_help'
alias ll='ls -lah'
alias ls='ls -GFh'
alias ?='pwd'
alias c='clear'
