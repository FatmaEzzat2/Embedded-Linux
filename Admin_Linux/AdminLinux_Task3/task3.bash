#!/bin/bash

# Check if .bashrc file exists
if [ -f ~/.bashrc ]; then
   
# Append new environment variables to .bashrc
  echo "export HELLO=$HOSTNAME" >> ~/.bashrc



  echo "LOCAL="$(whoami)"" >>~/.bashrc
#run .bashrc file
    source ~/.bashrc
fi

gnome-terminal

