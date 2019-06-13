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

The docker-compose.yml file specifies mount points to point to your
source directory.

My own `python_mozetl` repository is typically located at
`/Users/vng/dev/python_mozetl`, and is made available to the container
under `/app/src/python_mozetl`.  

You will need to update the volumes entry so that the `python_mozetl`
repository is available to the container on your machine.
