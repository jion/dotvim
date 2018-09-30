FROM ubuntu:18.04
########################################
# System Stuff
########################################

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -my && apt-get install -my gnupg
RUN echo "deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu bionic main\ndeb-src http://ppa.launchpad.net/neovim-ppa/stable/ubuntu bionic main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

RUN apt-get update && apt-get install -my \
        ctags \
        git \
        curl \
        python-dev \
        python-pip \
        python3-dev \
        python3-pip \
        neovim

########################################
# Neovim
########################################
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN mkdir -p /root/.config/nvim/ /root/.config/nvim/colors/
ADD .vimrc /root/.config/nvim/init.vim
ADD .vim/colors/solarized.vim /root/.config/nvim/colors/solarized.vim

RUN nvim +PlugInstall +UpdateRemotePlugins +qa

########################################
# Python
########################################

# Install python linting and neovim plugin
RUN pip install neovim jedi flake8 flake8-docstrings flake8-isort flake8-quotes
RUN pip install pep8-naming pep257 isort
RUN pip3 install neovim jedi flake8 flake8-docstrings flake8-isort flake8-quotes
RUN pip3 install pep8-naming pep257 isort mypy ansible-lint flake8-bugbear
RUN pip3 install flake8-commas flake8-comprehensions
RUN pip3 install --upgrade neovim


CMD ['bash']
