#! /bin/bash

sudo apt update

sudo apt install -y  vim \
	    	git \
	        curl \
		zsh \
		tmux \
		ctags \
	       	cmake \
		zlib1g-dev \
		libssl-dev \
	       	python-dev \
		libreadline-dev \
		exuberant-ctags \
		build-essential \
		fonts-powerline \
	    	ca-certificates \
		ttf-ancient-fonts \
		silversearcher-ag \
		apt-transport-https \
		software-properties-common

# install k-tmux
curl https://raw.githubusercontent.com/wklken/k-tmux/master/tmux.conf > ~/.tmux.conf

# install monoid
mkdir -p ~/.fonts
cd ~/.fonts

if ! sudo test  -f "Monoisome-Regular.ttf"
then
    sudo wget https://github.com/larsenwork/monoid/raw/master/Monoisome/Monoisome-Regular.ttf
    fc-cache
else
    echo "Monoisome font is existing"
fi


# Install Zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install theme
cd  ~/.oh-my-zsh/themes

if ! sudo test  -f "bullet-train.zsh-theme"
then
    sudo wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
    # change theme to "bullet-train"
else
    echo "bullet train theme is existing"
fi


# install rbenv
if ! [ -x "$(command -v rbenv)" ]
then
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	cd ~/.rbenv && sudo src/configure && sudo make -C src
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
	source ~/.zshrc

	sudo mkdir -p "$(rbenv root)"/plugins
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	rbenv install 2.4.1
	rbenv global 2.4.1
	rbenv rehash
	eval "$(rbenv init -)"
else
    echo "rbenv is installed"
fi

#install k-vim
if ! sudo test -f "/tmp/k-vim/install.sh"
then
	cd /tmp
    git clone https://github.com/2pd/k-vim.git
    cd k-vim
	sh -x install.sh
else
	echo "k-vim is installed"
fi

# install docker

if [ -x "$(command -v docker)" ]
then
    echo "Docker is installed"
else
    curl -fsSL get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # sudo add-apt-repository \
	 # "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	 # $(lsb_release -cs) \
	 # edge"
    # sudo apt update
    # sudo apt-get install docker-ce
fi

