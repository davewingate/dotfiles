
# depends on colors.bash

_set_prompt () {
    Last_Command=$? # Must come first!
    FancyX='\342\234\227'
    
    PS1="\[$Gray\]\u@\h\[$Reset\]"
    PS1+=" \[$Blue\]\w\[$Reset\]"
    PS1+="$(__git_ps1 "\[$Purple\] (%s)\[$Reset\]" 2>/dev/null)"
    if [[ $Last_Command == 0 ]]; then
        PS1+=" \[$Gray\]\\\$"
    else
        PS1+=" \[$Red\]$FancyX"
    fi
    PS1+=" \[$Reset\]"

}
PROMPT_COMMAND='_set_prompt'