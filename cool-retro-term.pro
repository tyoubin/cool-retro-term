TEMPLATE = subdirs

CONFIG += ordered
CONFIG+=sdk_no_version_check

SUBDIRS += qmltermwidget
SUBDIRS += app

desktop.files += cool-retro-term.desktop
desktop.path += /usr/share/applications

INSTALLS += desktop
