#!/bin/bash

#
# Run a bash shell configured for git.
#

# Select git info displayed, see /usr/lib/git-core/git-sh-prompt for more
# GIT_PS1_SHOWDIRTYSTATE=1           # '*'=unstaged, '+'=staged
# GIT_PS1_SHOWSTASHSTATE=1           # '$'=stashed
# GIT_PS1_SHOWUNTRACKEDFILES=1       # '%'=untracked
# GIT_PS1_SHOWUPSTREAM="verbose"     # 'u='=no difference, 'u+1'=ahead by 1 commit
# GIT_PS1_STATESEPARATOR=' '         # Space between branch and index status
# GIT_PS1_DESCRIBE_STYLE="describe"  # detached HEAD style:
# contains      relative to newer annotated tag (v1.6.3.2~35)
# branch        relative to newer tag or branch (master~4)
# describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
# default       exactly eatching tag


GIT_PS1_SHOWDIRTYSTATE=1 \
	GIT_PS1_SHOWSTASHSTATE=1 \
	GIT_PS1_SHOWUNTRACKEDFILES=1 \
	GIT_PS1_SHOWUPSTREAM="verbose" \
	GIT_PS1_STATESEPARATOR=' ' \
	GIT_PS1_DESCRIBE_STYLE="describe" \
	PROMPT_COMMAND='__git_ps1 "\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "\n$ "' \
	bash

