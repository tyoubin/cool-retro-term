QT += qml quick widgets sql quickcontrols2
CONFIG+=sdk_no_version_check
TARGET = cool-retro-term 

# Force Release mode by default
CONFIG += release
CONFIG -= debug

DESTDIR = $$OUT_PWD/../

HEADERS += \
    fileio.h \
    monospacefontmanager.h

SOURCES = main.cpp \
    fileio.cpp \
    monospacefontmanager.cpp

macx:ICON = icons/crt.icns

RESOURCES += qml/resources.qrc

#########################################
##          macOS Configuration
#########################################

macx {
    # 1. Define source (Go up one level from app/ to find qmltermwidget)
    QML_SRC = $$PWD/../qmltermwidget/QMLTermWidget

    # 2. Define Destination
    # If DESTDIR is set (e.g. ".."), use it. Otherwise default to current build dir.
    isEmpty(DESTDIR) {
        APP_BUNDLE = $$OUT_PWD/$${TARGET}.app
    } else {
        APP_BUNDLE = $$DESTDIR/$${TARGET}.app
    }

    # 3. Create the copy command
    # We use $(MKDIR) which translates to 'mkdir -p' in the Makefile
    copy_qml.commands = $(MKDIR) $$APP_BUNDLE/Contents/PlugIns && cp -r $$QML_SRC $$APP_BUNDLE/Contents/PlugIns/

    # 4. Trigger after linking
    QMAKE_POST_LINK += $$copy_qml.commands
}
