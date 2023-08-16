if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# Change default editor to nvim
set -x EDITOR nvim
set -x VISUAL nvim

# For multiwfn 
set -x OMP_STACKSIZE 200M

# Add /usr/sbin to path
set -x PATH /usr/sbin $PATH

# BINDINGS
bind \b 'backward-kill-word'

# ALIASES
################################################################################################################################

alias ls='lsd'
alias l='lsd'
alias py='python3'
alias v='nvim'
alias ll='lsd -al'
alias q='exit'
alias e='exit'
alias r='ranger'
thefuck --alias | source
alias avogadro2='env QT_QPA_PLATFORM=xcb avogadro2'
alias abacus='ssh -X vinay.s@abacus.iiit.ac.in'
alias up='sudo dnf upgrade'
alias myenv='source ~/env/bin/activate.fish'

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
# function abacus
#     if [ "-X" = "$argv[1]" ]
#         ssh -X vinay.s@abacus.iiit.ac.in
#     else
#         ssh vinay.s@abacus.iiit.ac.in
#     end
# end 

# Mount sda1 using udisksctl
function phd
    set device_path "/dev/sda1"
    set mount_path "/run/media/karet/PHD"
    if [ "mount" = "$argv[1]" ]
        if mount | grep $device_path
            echo "Device already mounted"
        else
            udisksctl mount -b $device_path && cd $mount_path && ranger
        end
    else if [ "unmount" = "$argv[1]" ]
        cd
        udisksctl unmount -b $device_path
    else
        if mount | grep $device_path
            cd $mount_path && ranger
        else 
            echo "Usage phd [mount|unmount]"
        end
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

function pdfcompress
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_$argv[1] $argv[1]  
end

function ttyper
    cowsay 'lul'
end
