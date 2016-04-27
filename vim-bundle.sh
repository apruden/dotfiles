#!/bin/bash

cd .vim
git submodule add $1 bundle/$2
git add .
git commit -m 'Added bundle $2'

