FROM archlinux/base

ARG ARCHZFS_KEY="F75D9D76"
ARG BUILD_DIR="/opt/zfs-archiso"

RUN pacman -Syu --noconfirm archiso base base-devel

RUN pacman -Syy

RUN pacman-key -r "${ARCHZFS_KEY}"        
RUN pacman-key --lsign-key "${ARCHZFS_KEY}"

RUN cp -r /usr/share/archiso/configs/releng "${BUILD_DIR}"

RUN printf '[archzfs]\nServer = https://archzfs.com/$repo/$arch\nSigLevel = Optional TrustAll' >> ${BUILD_DIR}/pacman.conf

RUN printf 'zfs-linux\nzfs-utils' >> ${BUILD_DIR}/packages.x86_64

VOLUME "${BUILD_DIR}/out"

WORKDIR "${BUILD_DIR}"

CMD ["./build.sh", "-v"]
