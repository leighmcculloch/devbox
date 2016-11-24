# apt-get source for google-cloud-sdk
echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update local package directory
apt-get -y update

# Update to the latest of all packages
apt-get -y dist-upgrade

# Install packages for general use and dev
apt-get -y install \
  build-essential \
  ncurses-dev \
  xauth \
  mosh \
  curl \
  zsh \
  tmux \
  git \
  make \
  python3.5 \
  direnv \
  tig \
  jq \
  google-cloud-sdk \

# Install Vim Latest
apt-get remove \
  vim \
  vim-runtime \
  gvim \
  vim-tiny \
  vim-common \
  vim-gui-common \
  vim-nox
git clone https://github.com/vim/vim.git
cd vim
make && make install
cd -
rm -fR vim

# Install PIP (used by AWS CLI)
curl -s https://bootstrap.pypa.io/get-pip.py | python

# Install AWS CLI
pip install awscli

# Install any custom files
cp -R all/* /

# Install optionals
if test "${LANGS#*go}" != "$LANGS"
then
  ./install-go.sh
fi
if test "${LANGS#*swift}" != "$LANGS"
then
  ./install-swift.sh
fi
if test "${LANGS#*ruby}" != "$LANGS"
then
  ./install-ruby.sh
fi
if test "${LANGS#*rust}" != "$LANGS"
then
  ./install-rust.sh
fi

# Set the script that will be executed when new users are added
cp -R all/* /
cp -R ../setup-user /usr/local/sbin/adduser

# Disable root login
passwd -l root
