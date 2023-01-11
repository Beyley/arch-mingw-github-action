FROM archlinux:base-devel

LABEL maintainer="joshua@froggi.es"

RUN echo -e '\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n\n' >> /etc/pacman.conf
RUN pacman-key --init
RUN pacman -Sy --needed --noconfirm archlinux-keyring
RUN pacman -Syu --needed --noconfirm clang meson glslang git mingw-w64 wine base base-devel sed git tar curl wget bash gzip sudo file gawk grep bzip2 which pacman systemd findutils diffutils coreutils procps-ng util-linux xcb-util xcb-util-keysyms xcb-util-wm lib32-xcb-util lib32-xcb-util-keysyms glfw-x11
RUN git config --system --add safe.directory /github/workspace

# clone/build/install the lib32-glfw-x11 AUR package (there is no lib32 glfw in the standard Arch repositories)
RUN git clone https://aur.archlinux.org/lib32-glfw.git
RUN cd lib32-glfw
RUN makepkg -Si 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
