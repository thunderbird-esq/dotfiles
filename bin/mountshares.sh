#!/bin/bash
# TBESQ Network Share Mounter (edit SMB/NFS as needed)

SHARE_DIR="$HOME/NetworkShares"
REMOTE="//username@macpro.local/share"

mkdir -p "$SHARE_DIR"
mount_smbfs "$REMOTE" "$SHARE_DIR/macpro"
echo "Mac Pro share mounted at $SHARE_DIR/macpro"
