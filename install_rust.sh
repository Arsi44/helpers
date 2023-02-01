#!/bin/bash

# Functions
install() {
	sudo apt update
	sudo apt upgrade -y
	sudo apt install curl pkg-config libssl-dev libudev-dev build-essential clang make -y
	touch $HOME/.bash_profile
	curl --proto '=https' -sSf https://sh.rustup.rs | sh -s -- -y
	rustup toolchain install nightly
	rustup default nightly
	source "$HOME/.cargo/env"

}

echo -e "Rust installation"
install
echo -e "Rust has been installed!"