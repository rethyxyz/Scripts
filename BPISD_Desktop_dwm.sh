#!/bin/bash
#
# BPISD for Desktops: dwm Edition
#  _____
# |  __ \  GitHub: https://github.com/brodyrethy
# | |__) | 
# |  _  /  
# | | \ \  
# |_|  \_\ Website: https://rethy.xyz
#
# Description:
# BPISD is a post-installation script to set up Debian 9/10.
# In this case, dwm is the wm installed. The configs used
# are the ones I've made over the years.
#

get_dotfiles () {
    git clone https://github.com/brodyrethy/dotfiles ~/dotfiles
}

create_dirs () {
    sudo mkdir -p ~/.config/mpc
	sudo mkdir -p ~/vim/undodir
	sudo mkdir -p /mnt/thewired_server
}

move_files_and_dirs () {
	#THIS COMMAND MUST BE RUN FIRST TO GET config.h
	sudo cp ~/dotfiles/.config/config.h_desktop ~/dotfiles/.config/dwm/config.h

	sudo cp -R ~/dotfiles/.fonts ~/
    sudo cp -R ~/dotfiles/.config/dwm ~/.config/
    sudo cp -R ~/dotfiles/.config/mpd ~/.config/
    sudo cp -R ~/dotfiles/.config/ranger ~/.config/
    sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config/
    sudo cp -R ~/dotfiles/.config/st ~/.config/

    sudo cp ~/dotfiles/inputrc /etc/
    sudo cp ~/dotfiles/grub /etc/default/
    sudo cp ~/dotfiles/sources.list /etc/apt/
    sudo cp ~/dotfiles/nobeep.conf /etc/modprobe.d/
    sudo cp ~/dotfiles/pulseaudio.service /etc/systemd/system/

    sudo cp ~/dotfiles/.xinitrc ~/
    sudo cp ~/dotfiles/.Xdefaults ~/
	sudo cp ~/dotfiles/.bash_aliases ~/
    sudo cp ~/dotfiles/.bash_profile ~/
    sudo cp ~/dotfiles/.vimrc ~/.vimrc
    sudo cp ~/dotfiles/.bashrc ~/.bashrc
}

echo_data () {
	#mpd
	echo 'music_directory "/mnt/thewired_server/500GigDrive0/Music"' >> ~/.config/mpd/mpd.conf
	#ncmpcpp
	echo 'mpd_music_dir = "/mnt/thewired_server/500GigDrive0/Music"' >> ~/.config/ncmpcpp/config
	#rc.conf
	echo "" >> ~/.config/ranger/rc.conf
	echo "#Changing directories" >> ~/.config/ranger/rc.conf
	echo "map gM cd /mnt/thewired_server/500GigDrive0/Music" >> ~/.config/ranger/rc.conf
	echo "map gb cd /mnt/thewired_server/500GigDrive1/Books" >> ~/.config/ranger/rc.conf
	echo "map gl cd /mnt/thewired_server/500GigDrive1/LaTeX" >> ~/.config/ranger/rc.conf
	echo "map ghh cd /mnt/thewired_server/500GigDrive1/GitHub" >> ~/.config/ranger/rc.conf
	echo "map gp cd /mnt/thewired_server/500GigDrive1/Pictures" >> ~/.config/ranger/rc.conf
	echo "map gP cd /mnt/thewired_server/500GigDrive1/Programming" >> ~/.config/ranger/rc.conf
	echo "map gv cd /mnt/thewired_server/500GigDrive0/Visual Media" >> ~/.config/ranger/rc.conf
	echo "map ghs cd /mnt/thewired_server/500GigDrive1/GitHub Storage" >> ~/.config/ranger/rc.conf
	echo "map gw cd /mnt/thewired_server/500GigDrive1/Pictures/Wallpapers" >> ~/.config/ranger/rc.conf
	echo "map gm cd /mnt/thewired_server/500GigDrive0/Visual Media/Movies" >> ~/.config/ranger/rc.conf
	echo "map gn cd /mnt/thewired_server/500GigDrive1/GitHub Storage/Notes" >> ~/.config/ranger/rc.conf
	echo "map gho cd ~" >> ~/.config/ranger/rc.conf
	echo "map gd cd ~/Downloads" >> ~/.config/ranger/rc.conf
	echo "map gD cd ~/Documents" >> ~/.config/ranger/rc.conf
	echo "map gMn cd /mnt" >> ~/.config/ranger/rc.conf
	#.bash_aliases
	echo "" >> ~/.bash_aliases
	echo "#Changing directories" >> ~/.bash_aliases
	echo "alias gM='cd /mnt/thewired_server/500GigDrive0/Music'" >> ~/.bash_aliases
	echo "alias gb='cd /mnt/thewired_server/500GigDrive1/Books'" >> ~/.bash_aliases
	echo "alias gl='cd /mnt/thewired_server/500GigDrive1/LaTeX'" >> ~/.bash_aliases
	echo "alias ghh='cd /mnt/thewired_server/500GigDrive1/GitHub'" >> ~/.bash_aliases
	echo "alias gp='cd /mnt/thewired_server/500GigDrive1/Pictures'" >> ~/.bash_aliases
	echo "alias gP='cd /mnt/thewired_server/500GigDrive1/Programming'" >> ~/.bash_aliases
	echo "alias gv='cd /mnt/thewired_server/500GigDrive0/Visual Media'" >> ~/.bash_aliases
	echo "alias ghs='cd /mnt/thewired_server/500GigDrive1/GitHub Storage'" >> ~/.bash_aliases
	echo "alias gw='cd /mnt/thewired_server/500GigDrive1/Pictures/Wallpapers'" >> ~/.bash_aliases
	echo "alias gm='cd /mnt/thewired_server/500GigDrive0/Visual Media/Movies'" >> ~/.bash_aliases
	echo "alias gn='cd /mnt/thewired_server/500GigDrive1/GitHub Storage/Notes'" >> ~/.bash_aliases
	#.xinitrc
	echo "/home/skryoo/Scripts/dwmbar_desktop &" >> ~/.xinitrc
	echo "xrandr --output HDMI-0 --left-of DVI-I-1 &" >> ~/.xinitrc
	echo "exec dwm" >> ~/.xinitrc
	#.vimrc
	echo "let g:vimwiki_list = [{'path': '/mnt/thewired_server/500GigDrive1/GitHub Storage/Notes'}]" >> ~/.vimrc
	echo ":map <leader>h :e /home/$USER<CR>" >> ~/.vimrc
}

download_and_install_programs () {
    sudo apt update -y
    sudo apt install ranger feh xinit vim lxappearance x11-xserver-utils pulseaudio curl mpd mpc ncmpcpp firefox-esr xinput python3-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler gparted libax25-dev libukwm-1-dev python3-pip mercurial python-dev python3-dev ruby ruby-dev libx11-dev libxt-dev libncurses5 ncurses-dev sshfs nvidia-driver pulsemixer suckless-tools rsync compton -y
    sudo apt purge youtube-dl -y
    sudo pip3 install youtube-dl
}

compile_py3_vim () {
    git clone https://github.com/vim/vim ~/vim
    cd ~/vim
    ./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
    make && sudo make install
    sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
}

install_vim_plug () {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
   
enable_services () {
    sudo systemctl enable mpd
    sudo systemctl enable pulseaudio
}

update_grub2 () {
    sudo update-grub2
}

remove_nano () {
    sudo apt purge nano && sudo apt remove nano
}

apply_ownership () {
    sudo chown $USER:$USER -R ~
}

main () {
    get_dotfiles
    apply_ownership
    create_dirs
    move_files_and_dirs
    apply_ownership
	echo_data
    download_and_install_programs
    compile_py3_vim
    install_vim_plug
    install_light
    enable_services
    remove_nano
    apply_ownership
    update_grub2
}

main