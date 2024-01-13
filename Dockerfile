FROM archlinux:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=America/New_York
ENV SHELL=/bin/zsh

RUN pacman-key --init && pacman-key --populate archlinux

RUN pacman -Syu --noconfirm \
    base-devel \
    curl \
    git \
    exa \
    neovim \
    tree-sitter-cli \
    ripgrep

EXPOSE 8080 8081 8082 8083 8084 8085

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install bacon hurl

# Act
RUN curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Fix Dubious Ownership
RUN mkdir /root/workspace
RUN git config --global --add safe.directory /root/workspace

# Files
COPY ./home/ /root/
COPY ./ /root/.config/nvim

# Install Neovim extensions.
RUN nvim --headless +qall

# Set default location after container startup.
WORKDIR /root/workspace

CMD ["tail", "-f", "/dev/null"]
