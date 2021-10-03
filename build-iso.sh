#/bin/sh
IMAGE_NAME="zfs-archiso"
docker image inspect "$IMAGE_NAME" 2>&1 > /dev/null || (docker build -t "$IMAGE_NAME" .)  

docker run -it --privileged \
  -v "$PWD/packages.x86_64:/opt/zfs-archiso/packages.x86_64:ro" \
  -v "$PWD/pacman.conf:/opt/zfs-archiso/pacman.conf:ro" \
  -v "$PWD/profiledef.sh:/opt/zfs-archiso/profiledef.sh:ro" \
  -v "$PWD/pkgcache/:/var/cache/pacman/pkg/" \
  -v "$PWD/out/:/opt/zfs-archiso/out/" \
 "$IMAGE_NAME" 
