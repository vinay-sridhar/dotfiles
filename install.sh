#!/bin/bash

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on.\n"
    yay -Suy
else 
    echo -e "yay was not located, please install yay. Exiting script.\n"
    exit 
fi

#### Creating my dir structure ####
read -n1 -rep 'Would you like to create your dir structure? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
	mkdir -p ~/Documents ~/Downloads ~/Pictures && echo "Your directory structure has been created!"
fi

#### My packages ####
read -n1 -rep 'Would you like to install your packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
	sudo yay -S --noconfirm alacritty firefox thunar light subversion fish neovim vim ranger evince grace htop btop zip tldr util-linux-user python3-pip gcc gcc-c++ npm avogadro2 bat calc camorama cowsay gimp libreoffice imv youtube-dl dunst && echo "Your packages have been installed!"
fi


#### hyprland ####
read -n1 -rep 'Would you like to install hyprland? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
	sudo yay -S --noconfirm colord ffmpeghumbnailer grimblast grimblast-git hyprland-git hyprpaper-git hyprpicker-git imagemagick polkit-kde-agent qt5-wayland qt6-wayland ripgrep swaylock-effects tumbler waybar-hyprland-git wf-recorder wl-clipboard wlogout wofi wofi-emoji wtype xdg-desktop-portal-hyprland-git && echo "Hyprland has been installed!"
fi


#### Install nerdfonts ####
read -n1 -rep 'Would you like to install Cascaydia code nerd font? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
	mkdir -p ~/.fonts && cd ~/.fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
	unzip *.zip
	rm *.zip
	sudo cp -R ~/.fonts /usr/share/fonts/
	fc-cache -rv
	echo "Font has been installed!"
fi

#### Make fish default shell ####
read -n1 -rep 'Would you like to make fish your default shell? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
	chsh -s $(which fish)
fi

echo "Installation complete!"
