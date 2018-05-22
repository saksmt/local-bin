ifndef PREFIX
PREFIX = /usr/local
endif

SRC_BIN = bin/buildkernel bin/dropcaches bin/dropswap bin/executify bin/passwd-gen bin/overlay bin/reload-idea-project bin/memusg bin/destroy bin/take bin/take-until bin/drop-until bin/unique bin/fav-deadbeef
SRC_ETC = etc/colors.sh etc/guard.sh etc/buildtools/kernel.conf etc/overlay/config
SRC_SHARE = usr/share/font_8x16.c
SRC_LIB = lib/colorize lib/command-loader lib/prompt
SRC_PORTAGE = portage/bin/fetch-git portage/bin/upd portage/add portage/remove portage/sync portage/.atom-regexp portage/.link-regexp portage/metadata/layout.conf portage/profiles/repo_name

.PHONY: all install uninstall installdirs

all:
	@echo "You can either install or unintall this scripts."
	@echo "Use:"
	@echo "   make install"
	@echo " or"
	@echo "   make uninstall"

installdirs:
	if [[ ! -d $(PREFIX) ]]; then mkdir $(PREFIX); fi
	if [[ ! -d $(PREFIX)/bin ]]; then mkdir $(PREFIX)/bin; fi
	if [[ ! -d $(PREFIX)/etc ]]; then mkdir $(PREFIX)/etc; fi
	if [[ ! -d $(PREFIX)/lib ]]; then mkdir $(PREFIX)/lib; fi
	if [[ ! -d $(PREFIX)/usr ]]; then mkdir $(PREFIX)/usr; fi
	if [[ ! -d $(PREFIX)/usr/share ]]; then mkdir $(PREFIX)/usr/share; fi
	if [[ ! -d $(PREFIX)/portage ]]; then mkdir $(PREFIX)/portage; fi

install: installdirs
	install -t $(PREFIX)/bin $(SRC_BIN)
	install -t $(PREFIX)/etc $(SRC_ETC)
	install -t $(PREFIX)/lib $(SRC_LIB)
	install -t $(PREFIX)/usr/share $(SRC_SHARE)
	install -t $(PREFIX)/portage $(SRC_PORTAGE)

uninstall:
	rm -rf $(addprefix $(PREFIX),$(SRC_BIN))
	rm -rf $(addprefix $(PREFIX),$(SRC_ETC))
	rm -rf $(addprefix $(PREFIX),$(SRC_LIB))
	rm -rf $(addprefix $(PREFIX),$(SRC_SHARE))
	rm -rf $(addprefix $(PREFIX),$(SRC_PORTAGE))

