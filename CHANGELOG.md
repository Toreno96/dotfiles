# Changelog

All notable changes to the `ithaca` that aren't versioned in my `dotfiles` repository will be documented in this file.

The format is _very loosely_ based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

<!--

`Added` for new features.
`Changed` for changes in existing functionality.
`Deprecated` for soon-to-be removed features.
`Removed` for now removed features.
`Broke` in case of breaking anything.
`Fixed` for any bug fixes.
`Security` in case of vulnerabilities.
`Updated` or `Upgraded` for any updates/upgrades that cannot be defined clearly as `Changed` (e.g. package upgrades).

-->

## 2024-02-07

- Upgraded packages via `pacman`.
- Changed `/etc/pacman.d/mirrorlist` to the newly generated one via `reflector` (see the exact invocation in the file).
- Applied (partial or full) changes from `/etc/**/*.pacnew` files:

    ```
    /etc/mkinitcpio.conf
    /etc/pacman.conf
    /etc/shells
    /etc/systemd/homed.conf
    /etc/systemd/logind.conf
    /etc/systemd/timesyncd.conf
    ```
- Removed `pacnew` files from above.
- Removed `pacnew` files I didn't plan to use (mostly, if not only, `/etc/pacman.d/mirrorlist.pacnew`).
- Broke kernel image, and as a result, made the Linux image (both default and fallback) unbootable with `something something Antergos (/vmlinuz-linux): Not found` error during boot.
- Fixed kernel image.
- Updated bootctl as a part of the previous fix (which changed the boot loader look to more minimalistic one).
- Removed many leftover files related to Antergos; some backups are in `~/tmp/trash/`.
- Changed lightdm configuration.
- Removed old unused lightdm webkit package (and, surprisingly, its dependency: `gnome-backgrounds`) and configuration.
- Changed `/etc/lightdm/wallpaper{_,-}multihead.jpg`
- Added AccountsService-based icon for my user `dstasczak` (in `/var/lib/AccountsService/icon/` because `~/.face` proved to be incompatible with lightdm).
