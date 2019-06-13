# srg-python_mozetl

Stop futzing with setting up your python_mozetl dependencies.  

You'll go mad.

This sets up a stock Ubuntu image with a working PySpark toolchain
that will pass all the mozilla/python_mozetl testsuite.

Run `make build` to build the image

Run `make bash` to run bash with ~/dev/ mounted into /app/src

The container has an enviroment variable set for HOST_IP which is your
host machine's IP address for en0

The default user is 'app' with a password set to 'badpass' with sudo
rights

TODO: add instructions on how to use pyenv-virtualenv to setup the
python 3.5 enviroment to run the python_mozetl testsuite
