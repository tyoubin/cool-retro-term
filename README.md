# About this fork

Previously the project has not been in active development for 3 years. This is the tyoubin's fork, an attempt of reviving this application.

## Fixed

- Application hangs when pressing Command + Q or closing the window on arm64 macOS
- Special characters not rendering on arm64 macOS

# cool-retro-term

|> Default Amber|C:\ IBM DOS|$ Default Green|
|---|---|---|
|![Default Amber Cool Retro Term](https://user-images.githubusercontent.com/121322/32070717-16708784-ba42-11e7-8572-a8fcc10d7f7d.gif)|![IBM DOS](https://user-images.githubusercontent.com/121322/32070716-16567e5c-ba42-11e7-9e64-ba96dfe9b64d.gif)|![Default Green Cool Retro Term](https://user-images.githubusercontent.com/121322/32070715-163a1c94-ba42-11e7-80bb-41fbf10fc634.gif)|

## Description

cool-retro-term is a terminal emulator which mimics the look and feel of the old cathode tube screens.
It has been designed to be eye-candy, customizable, and reasonably lightweight.

It uses the QML port of qtermwidget (Konsole): https://github.com/tyoubin/qmltermwidget.

This terminal emulator works under Linux and macOS and requires Qt5. It's suggested that you stick to the latest LTS version.

Settings such as colors, fonts, and effects can be accessed via context menu.

## Screenshots
![Image](<https://i.imgur.com/TNumkDn.png>)
![Image](<https://i.imgur.com/hfjWOM4.png>)
![Image](<https://i.imgur.com/GYRDPzJ.jpg>)

## Install

Most distributions such as Ubuntu, Fedora or Arch already package the original cool-retro-term in their official repositories.

## Building

### Linux

Check out the wiki and follow the instructions on how to build it on [Linux](https://github.com/Swordfish90/cool-retro-term/wiki/Build-Instructions-(Linux)).

### macOS

0. Install Qt 5 via [Homebrew](https://brew.sh/)
	- `brew install qt@5`
	- add Qt 5's `bin` directory to your `$PATH` per Homebrew's Caveats message
1. Clone the codebase
	- `git clone --recursive https://github.com/tyoubin/cool-retro-term.git`
2. Go to the directory and compile
	- `cd cool-retro-term`
	- `qmake -r`
	- `make -j$(sysctl -n hw.ncpu)`
3. Optionally drag cool-retro-term to the `/Application` folder
