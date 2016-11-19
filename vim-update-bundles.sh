#!/bin/bash

cd .vim
git submodule update --init
git submodule foreach git pull origin master
