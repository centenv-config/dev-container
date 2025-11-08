# Use Debian as a base image
FROM debian:latest

# System wide configuration
RUN apt update -y && apt full-upgrade -y && \
    apt install build-essential gdb sudo zsh curl wget luarocks git -y && \
    useradd -m -s $(which zsh) dev && \
    usermod -aG sudo dev && \
    touch /home/dev/.zshrc

# Switch to user
USER dev
WORKDIR /home/dev

# User configuration
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    zsh -c "echo Completed ZSH setup"

# Run until explicitly stopped
CMD ["sleep", "infinity"]
