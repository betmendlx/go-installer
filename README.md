# Go Installer Script

This repository contains a Bash script to automatically download and install the latest version of Go (Golang) on Ubuntu. The script will fetch the latest version from the official Go website, install it, and update your environment variables.

## Features

- Automatically detects and downloads the latest version of Go.
- Removes any existing Go installation.
- Updates environment variables for Go.
- Verifies the installation.

## Requirements

- Ubuntu (or any Debian-based distribution)
- `curl` and `wget` installed

## Installation

1. Clone this repository:
    ```sh
    git clone https://github.com/betmendlx/go-installer.git
    cd go-installer
    ```

2. Make the script executable:
    ```sh
    chmod +x install-go.sh
    ```

3. Run the script:
    ```sh
    ./install-go.sh
    ```

## Usage

The script will perform the following steps:

1. Download the latest Go binary tarball.
2. Remove any existing Go installation from `/usr/local/go`.
3. Extract the downloaded tarball to `/usr/local`.
4. Update the `.bashrc` file to include Go environment variables.
5. Apply the changes and verify the installation.

## Environment Variables

The script updates your `.bashrc` file with the following environment variables:

```sh
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
```

Contributing
If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.
