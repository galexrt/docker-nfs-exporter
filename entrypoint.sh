#!/bin/bash

NFS_EXPORTS="${NFS_EXPORTS:-}"
RPCNFSDOPTS="${RPCNFSDOPTS:-}"
RPCNFSDCOUNT="${RPCNFSDCOUNT:-8}"
RPCMOUNTDOPTS="${RPCMOUNTDOPTS:---manage-gids}"

for share in $NFS_EXPORTS; do
    echo "$share" >> /etc/exports
done

modprobe nfsd || { echo "Failed modprobing 'nfsd' kernel module"; exit 1; }

echo "Initializing NFS Server.."
rpcbind
/usr/sbin/rpc.nfsd "$RPCNFSDOPTS" "$RPCNFSDCOUNT"

echo "NFS Server running.."
/usr/sbin/rpc.mountd "$RPCMOUNTDOPTS"

sleep infinity
