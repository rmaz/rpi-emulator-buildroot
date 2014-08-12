rpi-emulator-buildroot
======================

This is a buildroot based system for the Raspberry Pi focused on libretro emulation and fast booting. Currently there is only support for RetroArch and a Pocketsnes fork, [ARMSNES](https://github.com/rmaz/ARMSNES-libretro), but it is reasonably simple to add more packages. The base image boots to [EmulationStation](https://github.com/Aloshi/EmulationStation) in about 3 seconds, or in my case less time than it takes for my TV to wake up :)

## Trying it out
If you just want to try out the base image without bothering to build anything, there are some file system images available on the releases page. Try the following:

1. Download the [bootfs.tar.gz](https://github.com/rmaz/rpi-emulator-buildroot/releases/download/0.1/bootfs.tar.gz) and [rootfs.tar.gz](https://github.com/rmaz/rpi-emulator-buildroot/releases/download/0.1/rootfs.tar.gz) images.
2. Get an SD card and create 2 partitions, one small (eg 32MB) bootable FAT32 partition, and another root partition with the filesystem of your choice.
3. Write the images to your SD card using `sudo tar xzf bootfs.tar.gz -C /mnt/mntpointboot` and similarly for the root partition.
4. Copy some SNES ROMS to `/mnt/mntpointroot/usr/share/roms`.
5. Put the card in your pi and take it for a spin,,,

## Customising the image
The buildroot system is large but fairly straightforward. You should check out the gory details in the [buildroot manual](http://buildroot.uclibc.org/downloads/manual/manual.html) if you are interested, but if you only want to select different packages just do a `make menuconfig` in the root directory and pick what you want, then a `make`. Hey presto.

If you want to add some packages, you should check section 7 in the manual, it is a slightly involved process. Executive summary:

1. Create a folder for the package in the `package` folder.
2. Add a `Config.in` and `mypackage.mk` file (this is the tricky part).
3. Edit the `package/Config.in` file to add your package in the correct section.
4. Run `make menuconfig` and pick your new package in the menu, then `make`.
5. After fixing about 1000000 build errors, you should finally have your package, happy days.

There are some more detailed installation instructions on the [wiki](https://github.com/rmaz/rpi-emulator-buildroot/wiki/Installation).

## Contributing
If you add any more libretro cores or any other interesting packages, just send a pull request and I'll merge them in. boom.