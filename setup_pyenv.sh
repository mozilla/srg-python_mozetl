#!/bin/sh

pyenv virtualenv 3.5.7 python_mozetl
pyenv activate python_mozetl
wget --quiet https://raw.githubusercontent.com/crankycoder/srg-python_mozetl/master/etl-requirements.txt -O /tmp/requirements.txt
pip install --upgrade pip
pip install -r /tmp/requirements.txt
