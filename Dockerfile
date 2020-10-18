FROM archlinux/base

ARG ARCHZFS_KEY="F75D9D76"
ARG BUILD_DIR="/opt/zfs-archiso"

RUN pacman -Syu --noconfirm archiso
RUN pacman-key --init && pacman-key --populate
RUN printf 'keyserver hkp://keyserver.ubuntu.com' >> /etc/pacman.d/gnupg/gpg.conf
RUN pacman-key -r "$ARCHZFS_KEY" && pacman-key --lsign-key "$ARCHZFS_KEY"
RUN cp -r /usr/share/archiso/configs/releng "${BUILD_DIR}"
RUN printf '\n[archzfs]\nServer = https://archzfs.com/$repo/$arch\nSigLevel = Optional TrustAll' >> "${BUILD_DIR}/pacman.conf"
RUN printf 'zfs-linux\nzfs-utils' >> "${BUILD_DIR}/packages.x86_64"


WORKDIR "${BUILD_DIR}"

COPY profiledef.sh "${BUILD_DIR}"

VOLUME "${BUILD_DIR}/out"

CMD ["/usr/bin/mkarchiso", "-v", "."]