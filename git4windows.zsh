#!/usr/bin/env zsh
# Based on https://github.com/win0err/aphrodite-terminal-theme

export VIRTUAL_ENV_DISABLE_PROMPT=true
setopt PROMPT_SUBST

git4windows_get_prompt() {
	if [[ -v VIRTUAL_ENV ]]; then
		echo -n "%F{white}["$(basename "$VIRTUAL_ENV")"]%f "
	fi

	echo -n "%F{green}%n@%m "

	if [[ -n $MSYSTEM ]]; then
		echo -n "%F{magenta}$MSYSTEM "
	fi

	echo -n "%F{yellow}%~"
	echo -n " "

	local git_branch=$(git --no-optional-locks rev-parse --abbrev-ref HEAD 2> /dev/null)
	if [[ -n "$git_branch" ]]; then
		local git_status=$(git --no-optional-locks status --porcelain 2> /dev/null | tail -n 1)
		[[ -n "$git_status" ]] && echo -n "%F{red}" || echo -n "%F{cyan}"
		echo -n "(${git_branch})%f"
	fi

	if [[ -v GIT4WINDOWS_SHOW_TIME ]]; then
		echo -n "%F{grey} [%D{%H:%M:%S}]%f"
	fi

	echo

	echo -n "%(?.%f.%F{red})"
	echo -n "%(!.#.$)%f "
}

export PROMPT='$(git4windows_get_prompt)'
