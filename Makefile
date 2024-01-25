ifndef PREFIX
PREFIX = /usr/local
endif

SRC_BIN = bin/buildkernel \
          bin/brightness \
          bin/dropcaches \
          bin/docker-orchestra \
          bin/dropswap \
          bin/executify \
          bin/passwd-gen \
          bin/overlay \
          bin/reload-idea-project \
          bin/memusg \
          bin/destroy \
          bin/ntfs-is-shit \
          bin/min \
          bin/max \
          bin/take \
          bin/take-until \
          bin/drop-until \
          bin/unique \
          bin/fav-deadbeef \
          bin/fix-shebang \
          bin/touchpad \
          bin/mkpr \
          bin/git-parents \
          bin/private-scratch \
          bin/icefox \
          bin/is-pwned \
          bin/docker-util \
          bin/remux-audio \
          bin/backup \
          bin/repin-unstable-nixpkgs \
          bin/tunnel-to-home-server \
          bin/better-git-stash-pop \
          bin/continually \
          bin/duration-to-millis \
          bin/millis-to-duration \
          bin/countdown \
          bin/work \
          bin/k8sps1 \
          bin/update-nixos

SRC_ETC = etc/colors.sh etc/guard.sh etc/buildtools/kernel.conf etc/overlay/config etc/pr.conf.tpl
SRC_ETC_DEFAULT = etc/default/k8sps1 etc/default/k8sps1.fancy
SRC_SHARE = usr/share/font_8x16.c
SRC_LIB = lib/colorize \
          lib/command-loader \
          lib/prompt \
          lib/logging \
          lib/require-binary \
          lib/concurrently \
          lib/sanitize-for-ntfs \
          lib/help-utils
SRC_PORTAGE = portage/bin/fetch-git portage/bin/upd portage/add portage/remove portage/sync portage/.atom-regexp portage/.link-regexp portage/metadata/layout.conf portage/profiles/repo_name
SRC_DOCKER_UTIL = lib/docker-util/clean-networks

.PHONY: all install uninstall installdirs

all:
	@echo "You can either install or uninstall these scripts."
	@echo "Use:"
	@echo "   make install"
	@echo " or"
	@echo "   make uninstall"

installdirs:
	install -d \
        $(PREFIX)/bin \
        $(PREFIX)/etc \
        $(PREFIX)/etc/default \
        $(PREFIX)/lib \
        $(PREFIX)/lib/docker-util \
        $(PREFIX)/usr \
        $(PREFIX)/usr/share \
        $(PREFIX)/usr/portage

install: installdirs
	install -t $(PREFIX)/bin $(SRC_BIN)
	install -t $(PREFIX)/etc $(SRC_ETC)
	install -t $(PREFIX)/etc/default $(SRC_ETC_DEFAULT)
	install -t $(PREFIX)/lib $(SRC_LIB)
	install -t $(PREFIX)/lib/docker-util $(SRC_DOCKER_UTIL)
	install -t $(PREFIX)/usr/share $(SRC_SHARE)
	install -t $(PREFIX)/portage $(SRC_PORTAGE)

uninstall:
	rm -rf $(addprefix $(PREFIX),$(SRC_BIN))
	rm -rf $(addprefix $(PREFIX),$(SRC_ETC))
	rm -rf $(addprefix $(PREFIX),$(SRC_LIB))
	rm -rf $(addprefix $(PREFIX),$(SRC_SHARE))
	rm -rf $(addprefix $(PREFIX),$(SRC_PORTAGE))
	rm -rf $(addprefix $(PREFIX),$(SRC_DOCKER_UTIL))
