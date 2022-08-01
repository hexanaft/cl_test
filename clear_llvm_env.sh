#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# exit when any command fails
set -e

rm /etc/profile.d/set_clang_path.sh
# TODO how to delete \$HOME/.local/bin: from PATH ?
source /etc/profile
rm -rf ~/.local
rm -rf ~/.llvm
