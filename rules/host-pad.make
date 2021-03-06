# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PAD) += host-pad

#
# Paths and names
#
HOST_PAD_VERSION	:= 1.0.0
HOST_PAD			:= pad
HOST_PAD_URL		:= lndir://$(PTXDIST_WORKSPACE)/local_src/host/$(HOST_PAD).src
HOST_PAD_DIR		:= $(HOST_BUILDDIR)/$(HOST_PAD).src

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PAD_CONF_TOOL	:= autoconf
HOST_PAD_CONF_OPT	:= \
	$(HOST_AUTOCONF)

$(STATEDIR)/host-pad.prepare: $(STATEDIR)/host-pad.get $(STATEDIR)/host-pad.extract
	@$(call targetinfo)
	cd $(HOST_PAD_DIR); \
		cp $(PTXDIST_SYSROOT_HOST)/share/libtool/config/ltmain.sh .; \
		touch NEWS README AUTHORS ChangeLog; \
		aclocal; automake -a; autoconf
	@$(call world/prepare, HOST_PAD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-pad.install: $(STATEDIR)/host-pad.prepare $(STATEDIR)/host-pad.compile
	@$(call targetinfo)
	cp $(HOST_PAD_DIR)/pad $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch)

$(STATEDIR)/host-pad.install.post: $(STATEDIR)/host-pad.install

# vim: syntax=make
