
Debian
====================
This directory contains files used to package yepd/yep-qt
for Debian-based Linux systems. If you compile yepd/yep-qt yourself, there are some useful files here.

## yep: URI support ##


yep-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install yep-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your yepqt binary to `/usr/bin`
and the `../../share/pixmaps/yep128.png` to `/usr/share/pixmaps`

yep-qt.protocol (KDE)

