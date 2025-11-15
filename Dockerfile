# Use Debian as a base image
FROM debian:latest

COPY ./nvim-install.sh /tmp/nvim-install.sh

# System wide configuration
RUN apt update -y && apt full-upgrade -y && \
    apt install build-essential gdb sudo zsh curl wget git tmux luarocks lazygit ripgrep default-jdk -y && \
    useradd -m -s $(which zsh) dev && \
    echo "dev:dev" | chpasswd && \
    usermod -aG sudo dev && \
    touch /home/dev/.zshrc && \
    chmod +x /tmp/nvim-install.sh && \
    /tmp/nvim-install.sh

# Switch to user
USER dev
WORKDIR /home/dev

# User configuration
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/centenv-config/centenvim.git ~/.config/nvim && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Run until explicitly stopped
CMD ["sleep", "infinity"]
