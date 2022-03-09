#!/bin/bash

#Script written to work on debian 11

if [ "$EUID" -ne 0 ]; then
	echo "Please run script as root"
	exit
fi

if [ $(cat /etc/hosts | grep "fgata-va.42.fr") -ne 0 ]; then
	echo "127.0.0.1	fgata-va.42.fr" >> /etc/hosts
fi

if [ "$#" -ne 1 ]; then
	echo "$0 takes exactly one argument. the user you want to grant docker access."
	exit
fi

if ! id -u "$1" > /dev/null 2>&1; then
	echo "Error: The user you want to grant docker access doesn't exists."
	exit
fi

if [ ! dpkg -s docker-ce ]; then
	echo "First we uninstall old docker versions."
	apt-get remove docker docker-engine docker.io containerd runc
	echo "Let's set up the repository"
		apt-get update
		apt-get install \
		ca-certificates \
		curl \
		gnupg \
		lsb-release
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	echo "Installing docker..."
	apt-get update
	status = apt-get install docker-ce docker-ce-cli containerd.io
	if status -ne 0 || $(docker run hello-world) -ne 0; then
		echo "Something wen't wrong on install, try again!"
		exit
	fi
	echo "Now let's grant access to docker for $1"
	groupadd docker
	usermod -aG docker $1
	chown "$1":"$1" /home/"$1"/.docker -R
	chmod g+rwx "/home/$1/.docker" -R
	echo "Enable docker to start on boot..."
	systemctl enable docker.service
	systemctl enable containerd.service
	echo "Try to logout and login again to test if everything is working fine."
fi
