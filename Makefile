PREFIX=$(HOME)/.local
SHAREDIR=$(PREFIX)/share/ocrd-im6convert

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps       Install deps"
	@echo "    install    Install the executable in $(PREFIX)/bin"
	@echo "    uninstall  Uninstall script"

# END-EVAL

# Install deps
deps:
	# apt-get install graphicsmagick

# Install the executable in $(PREFIX)/bin
install:
	mkdir -p $(PREFIX)/bin
	sed 's,^SHAREDIR.*,SHAREDIR="$(SHAREDIR)",' ocrd-im6convert > $(PREFIX)/bin/ocrd-im6convert
	chmod a+x $(PREFIX)/bin/ocrd-im6convert
	mkdir -p $(SHAREDIR)
	cp -t $(SHAREDIR) ocrd-tool.json

# Uninstall script
uninstall:
	rm -rf $(PREFIX)/bin/ocrd-im6convert
	rm -rf $(SHAREDIR)

