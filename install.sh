#!/bin/bash

print_info() {
 echo -e "\e[93m$1\e[0m"
}

install_lazygit() {
 LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
 curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
 tar xf lazygit.tar.gz lazygit
 sudo install lazygit /usr/local/bin
 rm $(pwd)/lazygit $(pwd)/lazygit.tar.gz
}

install_packages() {
 local pkgs=(vim tmux curl)

 for pkg in "${pkgs[@]}"; do
   print_info "Installing ${pkg}"
   sudo apt-get -y --ignore-missing install "${pkg}"
 done

 install_lazygit
}


print_info "Installing packages..."

install_packages

print_info "Done"
print_info "---------------------"

print_info "Creating symlinks\n" 

ln -s $(pwd)/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

print_info "Done"
