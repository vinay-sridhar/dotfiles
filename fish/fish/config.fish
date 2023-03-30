if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# ALIASES
################################################################################################################################

alias l='ls'
alias py='python3'
alias v='nvim'
alias pdf='xdg-open'

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
    sshpass -p 'uOTR$82' ssh vinay.s@abacus.iiit.ac.in
end 

# Copy from abacus to local 
function cpabacus
    if [ "-r" = $argv[1] ]
        scp -r vinay.s@abacus.iiit.ac.in:~$argv[2] . 
    else 
        sshpass -p 'uOTR$82' scp vinay.s@abacus.iiit.ac.in:~$argv[1] . 
    end 
end 
