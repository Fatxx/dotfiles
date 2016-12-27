# set prompt
function fish_prompt
    set_color FF0
    echo (whoami) '🔥 ' (pwd) '🚀  '
end

# set node default version
nvm use
