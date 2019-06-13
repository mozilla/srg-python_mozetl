FROM ubuntu:cosmic-20190515
ENV PYTHONDONTWRITEBYTECODE 1

MAINTAINER Victor Ng <victor@crankycoder.com>
EXPOSE 8080

# add a non-privileged user for installing and running
# the application

RUN apt-get update && \
    apt-get install -y sudo

RUN groupadd --gid 10001 app && \
    useradd --uid 10001 --gid 10001 --home /app --create-home app && \
    echo "app:docker" | chpasswd && adduser app sudo

# Set 'badpass' as the app password
RUN echo 'app:badpass' | chpasswd

RUN apt-get update && \
    apt-get install -y bash build-essential curl gettext gfortran git libatlas3-base \
    libbz2-dev libopenblas-dev libreadline-dev libsnappy-dev \
    libsqlite3-dev libssl-dev locales make software-properties-common unzip \
    vim wget zlib1g-dev

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && apt-get install -y nodejs && apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
update-locale LANG=C.UTF-8

# Install Java8
RUN wget --quiet https://github.com/mozilla/srg-python_mozetl/releases/download/0.1/jdk-8u212-linux-x64.tar.gz -O /tmp/jdk-8u212-linux-x64.tar.gz
RUN wget --quiet https://raw.githubusercontent.com/mozilla/srg-python_mozetl/master/install-java.sh -O /tmp/install-java.sh
RUN chmod +x /tmp/install-java.sh && /tmp/install-java.sh -f /tmp/jdk-8u212-linux-x64.tar.gz

# Set default user
USER app

# Install pyenv
WORKDIR /app
RUN git clone git://github.com/yyuu/pyenv.git .pyenv

ENV HOME  /app
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /app/.bashrc && \
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /app/.bashrc && \
echo 'eval "$(pyenv init -)"' >> /app/.bashrc && \
echo 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1' >> /app/.bashrc && \
echo 'export LC_ALL=C.UTF-8' >> /app/.bashrc && \
echo 'export LANG=C.UTF-8' >> /app/.bashrc

RUN wget --quiet https://raw.githubusercontent.com/mozilla/srg-python_mozetl/master/etl-requirements.txt -O /tmp/requirements.txt && \
pyenv install 3.5.7 && pyenv global 3.5.7 && \
pip install --upgrade pip && \
pip install -r /tmp/requirements.txt
