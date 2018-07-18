PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
SHAREDIR=$(PREFIX)/share/ocrd-im6convert

SCRIPTS = ocrd-im6convert

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
	which convert || echo 'apt-get install graphicsmagick'

# Install the executable in $(PREFIX)/bin and the ocrd-tool.json to $(SHAREDIR)
install:
	mkdir -p $(BINDIR)
	for script in $(SCRIPTS);do \
		sed 's,^SHAREDIR.*,SHAREDIR="$(SHAREDIR)",' $$script > $(BINDIR)/$$script ;\
		chmod a+x $(BINDIR)/$$script ;\
	done
	mkdir -p $(SHAREDIR)
	cp -t $(SHAREDIR) ocrd-tool.json

# Uninstall scripts and $(SHAREDIR)
uninstall:
	for script in $(SCRIPTS);do \
		rm --verbose --force "$(BINDIR)/$$script";\
	done
	rm -rfv $(SHAREDIR)

