if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# Change default editor to nvim
set -x EDITOR nvim
set -x VISUAL nvim

# Add /usr/sbin to path
set -x PATH /usr/sbin $PATH

# ALIASES
################################################################################################################################

alias l='ls'
alias py='python3'
alias v='nvim'
alias ll='exa --long --all --header'
thefuck --alias | source

# FUNCTIONS
################################################################################################################################

# Open all pdfs in a directory 
function pdfsopen
    for file in (ls *.pdf)
        xdg-open $file
    end
end

# List the number of pages in all pdfs in a directory
function pdfpages
    for file in (ls *.pdf)
        echo $file
        pdfinfo $file | grep 'Pages'
    end 
end 

# Convert to pdf; argv[1] is the extension 
function pdfconv 
    libreoffice --headless --invisible --convert-to pdf --outdir . *.$argv[1]
end

# Launch abacus with password  
function abacus
    if [ "-X" = $argv[1] ]
        ssh -X vinay.s@abacus.iiit.ac.in
    else
        ssh vinay.s@abacus.iiit.ac.in
    end
end 

# Copy from abacus to local 
function cpabacus
    if [ "-r" = $argv[1] ]
        scp -r vinay.s@abacus.iiit.ac.in:$argv[2] . 
    else 
        scp vinay.s@abacus.iiit.ac.in:$argv[1] . 
    end 
end 

# Mount sda1 using udisksctl
function phd
    if [ "mount" = $argv[1] ]
       udisksctl mount -b /dev/sda1 && cd /run/media/karet/PHD/ && ranger
    else if [ "unmount" = $argv[1] ]
        cd
        udisksctl unmount -b /dev/sda1
    end
end
complete -c phd -n '__fish_seen_subcommand_from mount' -a 'mount unmount'

# Wifi connect
function wifi
    if [ "list" = $argv[1] ]
        nmcli device wifi list
    else if [ "connect" = $argv[1] ]
        sudo nmcli device wifi connect $argv[2] password $argv[3]
    else if [ "up" = $argv[1] ]
        sudo nmcli con up $argv[2]
    end
end

function sudo
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end
