#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables
INSTALL_DIR="/usr/local"
PROFILE_FILE="$HOME/.bashrc"

# Get the latest version of Go
echo -e "${YELLOW}Fetching the latest Go version...${NC}"
GO_URL=$(curl -s https://go.dev/dl/ | grep -oP 'href="\Khttps://[^"]+linux-amd64\.tar\.gz(?=")' | head -n 1)
GO_TARBALL=$(basename $GO_URL)
GO_VERSION=$(echo $GO_TARBALL | sed -n 's/^go\([0-9.]*\)\.linux-amd64\.tar\.gz$/\1/p')

# Check if we successfully retrieved the URL
if [ -z "$GO_URL" ]; then
    echo -e "${RED}Failed to fetch the latest Go version.${NC}"
    exit 1
fi

# Download the Go tarball
echo -e "${YELLOW}Downloading Go $GO_VERSION...${NC}"
wget -c $GO_URL -O $GO_TARBALL

# Remove any existing Go installation
echo -e "${YELLOW}Removing any existing Go installation...${NC}"
sudo rm -rf $INSTALL_DIR/go

# Extract the Go tarball to /usr/local
echo -e "${YELLOW}Extracting Go $GO_VERSION...${NC}"
sudo tar -C $INSTALL_DIR -xzf $GO_TARBALL

# Add Go environment variables to .bashrc if not already present
if ! grep -q "export GOROOT=$INSTALL_DIR/go" $PROFILE_FILE; then
    echo -e "${YELLOW}Updating environment variables...${NC}"
    {
        echo ''
        echo '# Go environment variables'
        echo "export GOROOT=$INSTALL_DIR/go"
        echo 'export GOPATH=$HOME/go'
        echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH'
    } >> $PROFILE_FILE
else
    echo -e "${GREEN}Environment variables already set.${NC}"
fi

# Reload the .bashrc file
echo -e "${YELLOW}Applying changes...${NC}"
source $PROFILE_FILE

# Verify the installation
echo -e "${YELLOW}Verifying the installation...${NC}"
go version

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Go $GO_VERSION installation completed successfully!${NC}"
else
    echo -e "${RED}Failed to verify Go installation.${NC}"
fi
