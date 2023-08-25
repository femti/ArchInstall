#!/usr/bin/env bash
set -e

yay -Syu && sudo pacman -Scc && sudo pacman -Rsn $(pacman -Qdtq) && sudo rm -rf ~/.cache/thumbnails/*
