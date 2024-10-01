#!/bin/bash

# Variables
GO_VERSION="1.22.5"
GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/$GO_TARBALL"
INSTALL_DIR="/usr/local"
PROFILE_FILE="$HOME/.bashrc"

# Download the Go tarball
echo "Downloading Go $GO_VERSION..."
wget -c $GO_URL -O $GO_TARBALL

# Remove any existing Go installation
echo "Removing any existing Go installation..."
sudo rm -rf $INSTALL_DIR/go

# Extract the Go tarball to /usr/local
echo "Extracting Go $GO_VERSION..."
sudo tar -C $INSTALL_DIR -xzf $GO_TARBALL

# Add Go environment variables to .bashrc
echo "Updating environment variables..."
{
    echo ''
    echo '# Go environment variables'
    echo "export GOROOT=$INSTALL_DIR/go"
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH'
} >> $PROFILE_FILE

# Reload the .bashrc file
echo "Applying changes..."
source $PROFILE_FILE

# Verify the installation
echo "Verifying the installation..."
go version

echo "Go $GO_VERSION installation completed successfully!"
