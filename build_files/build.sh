#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y 


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

#systemctl enable podman.socket


CFS_TGZ_URL=$(curl --fail --retry 15 --retry-all-errors -sL \
    "https://api.github.com/repos/45Drives/cockpit-file-sharing/releases/latest" | \
    jq -r '.assets[] | select(.name? | match("cockpit-file-sharing-.*.el9.noarch.rpm$")) | .browser_download_url')
dnf --setopt=install_weak_deps=False install -y "${CFS_TGZ_URL}"



CI_TGZ_URL=$(curl --fail --retry 15 --retry-all-errors -sL \
    "https://api.github.com/repos/45Drives/cockpit-identities/releases/latest" | \
    jq -r '.assets[] | select(.name? | match("cockpit-identities-.*.el8.noarch.rpm$")) | .browser_download_url')
dnf --setopt=install_weak_deps=False install -y "${CI_TGZ_URL}"
