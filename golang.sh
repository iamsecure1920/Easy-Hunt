#!/bin/bash

# Fetch the latest Go version number dynamically
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1 | tr -d '\n' | tr -d '\r')
GO_TARBALL_URL="https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"
TARBALL_NAME="${LATEST_VERSION}.linux-amd64.tar.gz"
INSTALL_DIR="/usr/local"
BIN_DIR="/usr/local/bin"
PROFILE_FILE="$HOME/.profile"

# Download the tarball
wget --https-only "$GO_TARBALL_URL" -O "$TARBALL_NAME" && \

# Check if the downloaded file is a valid gzip compressed file
{ file "$TARBALL_NAME" | grep -q 'gzip compressed data' && \

  # Remove any previous Go installation
  sudo rm -rf "$INSTALL_DIR/go" && \

  # Extract the tarball to the install directory
  sudo tar -C "$INSTALL_DIR" -xzf "$TARBALL_NAME" && \

  # Create symlinks for Go binaries in /usr/local/bin
  sudo ln -sfn "$INSTALL_DIR/go/bin/go" "$BIN_DIR/go" && \
  sudo ln -sfn "$INSTALL_DIR/go/bin/gofmt" "$BIN_DIR/gofmt" && \

  # Add Go to PATH if not already added
  grep -q "$INSTALL_DIR/go/bin" "$PROFILE_FILE" || echo "export PATH=\$PATH:$INSTALL_DIR/go/bin" >> "$PROFILE_FILE" && \

  # Clean up
  rm "$TARBALL_NAME" && \

  # Notify user of successful installation
  echo "Go installation is complete. Please run 'source $PROFILE_FILE' to update your current shell." ; } || \

# Handle errors
{ echo "Error: Invalid tarball. Please try again." ; rm "$TARBALL_NAME" ; exit 1; }

