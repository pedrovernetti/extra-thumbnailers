# extra-thumbnailers

A pack of 3 thumbnailers covering file formats for which there are no default thumbnailers on GNOME environments, namely ePUB documents, Windows executables/DLLs and WebP images.

##### epub-thumbnailer

A thumbnailer for ePUB documents/ebooks, a quick python3 port of [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) by [Mariano Simone](https://github.com/marianosimone).

##### ms-thumbnailer

A thumbnailer for Windows executables and DLLs, adapted from [icoextract](https://github.com/jlu5/icoextract), by [James Lu](https://github.com/jlu5).

##### webp-thumbnailer

A thumbnailer for WebP images by [me](https://github.com/pedrovernetti).

-----
### Installation

##### Using Installer Script

Run: `./install.sh` or, for a re-installation: `./install.sh --reinstall` (no `sudo`).

##### Dependencies (third-party Python libraries/modules)

All 3 thumbnailers depends on `Pillow` (Python Imaging Library) and __ms-thumbnailer__ also depends on `pefile`.

----
### Uninstall

##### Using Installer Script

Run: `./install.sh --uninstall`.

----
### Bugs

If you find a bug, please report it at https://github.com/pedrovernetti/extra-thumbnailers/issues.

----
### License

This pack of thumbnailers is distributed under the terms of the GNU General Public License, version 3 (__GPL-3.0__). See the [LICENSE](/LICENSE) file for details.
