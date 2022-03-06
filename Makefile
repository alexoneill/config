# Targets to configure different operating systems.

MAKEFILE_DIR := $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Common modules between systems.
COMMON := git bash-common bin-common vim

#######
# Linux
#######
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)

# Invoke GNU stow on Linux.
STOW := : --dir=$(MAKEFILE_DIR) --target=$(HOME)

# The Linux-specific targets to install.
TARGETS := bash-linux bin-linux fonts-linux i3-linux x11-linux

.PHONY: all
all:
	$(STOW) $(COMMON) $(TARGETS)

.PHONY: clean
clean:
	$(STOW) -D $(COMMON) $(TARGETS)

endif

#######
# macOS
#######
ifeq ($(UNAME_S),Darwin)

# Invoke GNU stow on macOS.
STOW := /usr/local/bin/stow --dir=$(MAKEFILE_DIR) --target=$(HOME)

# The macOS-specific targets to install.
TARGETS := bash-macos bin-macos

# Make links.
.PHONY: all
all: /usr/local/bin/stow
	$(STOW) $(COMMON) $(TARGETS)

.PHONY: clean
clean:
	$(STOW) -D $(COMMON) $(TARGETS)

# https://brew.sh/
/usr/local/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stow if needed
/usr/local/bin/stow: /usr/local/bin/brew
	/usr/local/bin/brew install stow

endif
