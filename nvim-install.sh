#!/bin/bash

# Architecture specific
arch=$(uname -m)

if [[ $arch == "aarch64" ]]; then
  arch="arm64"
fi

cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz
tar -C /opt -xzf nvim-linux-$arch.tar.gz
cd /usr/local/bin
ln -s /opt/nvim-linux-$arch/bin/nvim nvim
