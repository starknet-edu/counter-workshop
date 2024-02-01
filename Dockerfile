FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install git curl zsh -y

# Change default shell to zsh
SHELL ["/bin/zsh", "-lc"]

# Set environment variables
ENV SHELL /bin/zsh
ENV HOME /root
ENV PATH $PATH:$HOME/.bin:$HOME/.local/bin

# Install oh-my-zsh for VSCode's DevContainer plugin
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install starkli
RUN curl https://get.starkli.sh | sh

# Install and configure asdf
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.14.0

# Enable oh-my-zsh plugin for asdf
RUN sed -i 's/plugins=(git)/plugins=(git asdf)/' $HOME/.zshrc

# Source changes to configuration file
RUN source $HOME/.zshrc

# Add asdf binaries to path
ENV PATH $PATH:$HOME/.asdf/bin:$HOME/.asdf/shims

# Install common dependenies with asdf
RUN asdf plugin add scarb
RUN asdf plugin add starknet-foundry

WORKDIR /app

COPY .tool-versions .
RUN asdf install