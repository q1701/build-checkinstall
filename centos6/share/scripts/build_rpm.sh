#!/bin/bash

# Abort if error
trap "exit 1" ERR

#====================================
# Build the checkinstall's RPM file.
#====================================

# Environments
export SCRIPT_DIR=$VOLUME_SHARE_CONTAINER/scripts
export PATCH_DIR=$VOLUME_SHARE_CONTAINER/patches
export OUT_DIR=$VOLUME_SHARE_CONTAINER

# Update yum packages
yum -y update

# Download the original version
yum -y install git
git clone http://checkinstall.izto.org/checkinstall.git
cd $BUILD_TMP/checkinstall

# Apply patches
yum -y install patch
## [Change installation directory of installwatch.so to /usr/local/lib64 on a 64bit system.]
## http://d.hatena.ne.jp/pcmaster/20120916/p1
patch -p1 -d . < $PATCH_DIR/checkinstall.lib64.patch
## [Change the location of configration files to /usr/local/etc.]
## http://d.hatena.ne.jp/naga_sawa/20120410/1334024586
patch -p1 -d . < $PATCH_DIR/checkinstall.confdir.patch
## [Changed setting not to use Slackware's native "makepkg".]
## http://blog.toor.jp/2012/03/checkinstall_on_centos-6-2-64bit/
patch -p1 -d . < $PATCH_DIR/checkinstall.makepkg.patch
## [Exclude "/selinux" by default. (--exclude=/selinux)]
## http://checkinstall.izto.org/cklist/msg00776.html
patch -p1 -d . < $PATCH_DIR/checkinstall.selinux.patch
## [Set "RPM" as a default package type.]
## http://d.hatena.ne.jp/akishin999/20130220/1361316887
patch -p1 -d . < $PATCH_DIR/checkinstall.rpm.patch
## [Add a option "autoreqprov" to turn on/off automatic dependencies feature of the RPM.]
## http://checkinstall.izto.org/cklist/msg00574.html
patch -p1 -d . < $PATCH_DIR/checkinstall.autoreqprov.patch
## [Include 'checkinstallrc' into the checkinstall's rpm file.]
## http://qiita.com/hnakamur/items/55ed1bc496b2e72a5ca6
patch -p1 -d . < $PATCH_DIR/checkinstall.rc.patch
# [A temporary patch to include symbolic links to directories into RPM file]
# http://blog.bsdhack.org/index.cgi/Computer/20140523.html
patch -p1 -d . < $PATCH_DIR/checkinstall.symlinkdir.patch

# Make and install
make install

# Run checkinstall to create its rpm
## Install dependencies to run checkinstall
export REQUIRES="gettext,file,which,tar,rpm-build"
yum -y install ${REQUIRES//,/ }
## Prepare environment to run the rpm-build
export HOME=/root
mkdir -p $HOME/rpmbuild/SOURCES
## Identify the version string. ("x.y.z")
export VERSION=$(checkinstall --version | grep "^checkinstall" | sed "s/checkinstall \(.*\), .*/\1/")
## Build a rpm.
checkinstall --type=rpm --pkgname=checkinstall --pkgversion=$VERSION --default --requires=$REQUIRES
## Save the full path of the rpm file into a file
export RPM_PATH="$HOME/rpmbuild/RPMS/$(arch)/checkinstall-$VERSION-1.$(arch).rpm"
## Install the generated rpm file to test it
yum -y localinstall $RPM_PATH
cd $BUILD_TMP

# Export
cp -a $RPM_PATH $OUT_DIR
rm -f $RPM_PATH
echo "========================="
echo "Created: $(basename $RPM_PATH)"
echo "========================="

# Clean up
cd /
yum clean all
rm -rf $BUILD_TMP
