# About this fork

Previously the project has not been in active development for 3 years. This is tyoubin's fork, an attempt at reviving this application.

> **Note**: This fork is **macOS-only**. Linux support has been deprecated.

## Fixed

- Application hangs when pressing Command + Q or closing the window on macOS
- Special characters not rendering on arm64 macOS

# cool-retro-term

|> Default Amber|C:\ IBM DOS|$ Default Green|
|---|---|---|
|![Default Amber Cool Retro Term](https://user-images.githubusercontent.com/121322/32070717-16708784-ba42-11e7-8572-a8fcc10d7f7d.gif)|![IBM DOS](https://user-images.githubusercontent.com/121322/32070716-16567e5c-ba42-11e7-9e64-ba96dfe9b64d.gif)|![Default Green Cool Retro Term](https://user-images.githubusercontent.com/121322/32070715-163a1c94-ba42-11e7-80bb-41fbf10fc634.gif)|

## Description

cool-retro-term is a terminal emulator which mimics the look and feel of the old cathode tube screens.
It has been designed to be eye-candy, customizable, and reasonably lightweight.

It uses the QML port of qtermwidget (Konsole): https://github.com/tyoubin/qmltermwidget.

This terminal emulator requires Qt5. It's suggested that you stick to the latest LTS version.

Settings such as colors, fonts, and effects can be accessed via context menu.

## Screenshots
![Image](<https://i.imgur.com/TNumkDn.png>)
![Image](<https://i.imgur.com/hfjWOM4.png>)
![Image](<https://i.imgur.com/GYRDPzJ.jpg>)

## Building on macOS

1. Install Qt 5 via [Homebrew](https://brew.sh/)
	- `brew install qt@5`
	- add Qt 5's `bin` directory to your `$PATH` per Homebrew's Caveats message
2. Clone the codebase
	- `git clone --recursive https://github.com/tyoubin/cool-retro-term.git`
3. Go to the directory and compile
	- `cd cool-retro-term`
	- `qmake -r`
	- `make -j$(sysctl -n hw.ncpu)`
4. Optionally drag `cool-retro-term.app` to the `/Applications` folder

