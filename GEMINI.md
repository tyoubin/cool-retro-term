# INSTRUCTIONS TO GEMINI:

- Log any important changes by appending to this file. Do not delete old content of this file.
- The Qt 5 and 6 is installed at `/opt/homebrew/opt/qt@5` and `/opt/homebrew/Cellar/qt/`
- This repo is at path `~/Applications/GitHub/cool-retro-term`
- This repo contains a submodule `qmltermwidget` 

## Git Workflow Protocol

### Repository Architecture
- **Main Repo:** `tyoubin/cool-retro-term` (Branch: `master`)
- **Submodule:** `tyoubin/qmltermwidget` (Branch: `master`)

### The "Submodule Dance" (Critical)
**Rule:** When changing code inside the `qmltermwidget` folder, you must push the submodule **FIRST**, or the build will break for others (Ghost Commit).

#### Phase 1: Update Submodule
1. Enter directory: `cd qmltermwidget`
2. Ensure branch: `git checkout master`
3. Make changes and commit: e.g. `git commit -am "Fix logic"`
4. **PUSH:** `git push origin master`

#### Phase 2: Update Main Repo
1. Go up a level: `cd ..`
2. Stage the pointer change: `git add qmltermwidget`
3. Commit: `git commit -m "Update submodule"`
4. **PUSH:** `git push origin master`

### Pulling Changes
To update your local machine with changes from GitHub, always pull recursively:
`git pull --recurse-submodules`

END OF INSTRUCTIONS TO GEMINI.

# Project Overview

`cool-retro-term` is a terminal emulator designed to mimic the look and feel of old cathode ray tube (CRT) screens. It is built using Qt and QML for the user interface and C++ for the backend logic. The project has not been in active development since 2022. This is the user's fork (`https://github.com/tyoubin/cool-retro-term`), an attempt of reviving this application. **This fork is macOS-only.**

## Architecture Breakdown

1.  **Backend (C++)**: The application's entry point is `app/main.cpp`. This file initializes the Qt/QML environment, handles file I/O, manages fonts, and exposes these backend functionalities to the QML frontend.

2.  **Frontend (QML)**: The entire user interface is built with QML, with `app/qml/main.qml` as the main file.
    *   **Settings**: All settings, profiles, and visual effect parameters are managed by `app/qml/ApplicationSettings.qml`.
    *   **Storage**: Settings are saved locally in an SQLite database, which is handled by `app/qml/Storage.qml`.

3.  **Terminal Emulation**: The core terminal functionality is not part of the main repository but is included as a Git submodule in the `qmltermwidget/` directory. This submodule provides the fundamental terminal widget.

## Rendering and Visual Effects

The distinctive retro appearance is achieved through a multi-step rendering process:

1.  The `qmltermwidget` provides the raw terminal text.
2.  `app/qml/PreprocessedTerminal.qml` likely renders this text into an off-screen texture.
3.  `app/qml/ShaderTerminal.qml` takes this texture and applies a series of GLSL shaders to create the final visual effects (like bloom, scanlines, and screen curvature). These effects are configured through the properties defined in `ApplicationSettings.qml`.

In summary, the project is a QML application that wraps a core C++ terminal widget and applies a customizable shader pipeline to create its unique visual style.

## Initial Analysis and Development Plan (2025-11-28)

Gemini's initial analysis of the project has identified several key areas for improvement to modernize the codebase and ensure its long-term viability.

### Findings:

1.  **Outdated Build Environment**: The project's continuous integration (`.travis.yml`) is configured to use Ubuntu 14.04 and Qt 5.8. These are obsolete and pose a significant maintenance and security risk.
2.  **Inactive Core Dependency**: The `qmltermwidget` submodule, which provides the core terminal functionality, has not been actively maintained, with the last commit dating back to early 2022. This may become a source of bugs or compatibility issues in the future.
3.  **Build System**: The project uses a standard `qmake` and `make` build process.

# Changelog

## Changes Made (2025-11-28)

- Updated the `qmltermwidget` submodule URL in `.gitmodules` to point to the user's fork (`https://github.com/tyoubin/qmltermwidget`).
- Updated the `README.md` file in the main repository to reference the user's fork of `qmltermwidget`.
- Updated the `URL` in `cool-retro-term/qmltermwidget/packaging/rpm/qmltermwidget.spec` to point to the user's fork. This change was made directly to the file within the submodule.

## Update on Outdated Components (2025-11-28)

Based on user feedback, the following decisions were made regarding outdated components:
-   **Build Environment (Travis CI)**: The user requested to **not touch** this part.
-   **Qt Version**: The user specified to use **Qt 5, not 6**. The project was successfully built using the provided Qt 5.15.18, which aligns with this requirement. While there were warnings about the SDK version during compilation, the build completed successfully, confirming Qt 5.15 LTS is effectively in use.
-   **`qmltermwidget` Submodule**: The user requested **not to use** the latest `qmltermwidget` but instead use the user's fork, citing incompatibility issues with Qt 6.

## Build Warnings Addressed (2025-11-28)

Several build warnings were identified and addressed:

-   **qmake SDK version warning**: Added `CONFIG+=sdk_no_version_check` to `cool-retro-term.pro`, `app/app.pro`, and `qmltermwidget/qmltermwidget.pro` to silence the warning about using a newer SDK version than Qt 5.15 was tested with. (Committed to main project)
-   **Deprecated `endl`**: Replaced all instances of `endl` with `Qt::endl` in `app/main.cpp`. (Committed to main project)
-   **Deprecated `qsrand` and `qrand`**: Replaced `qsrand(seed)` and `qrand()` with `QRandomGenerator::global()->seed(seed)` and `QRandomGenerator::global()->bounded()` respectively in `qmltermwidget/lib/ColorScheme.cpp`. (Committed to submodule)
-   **Unused variable `failed`**: Removed the unused `failed` variable declaration in `qmltermwidget/lib/ColorScheme.cpp`. (Committed to submodule)
-   **Unused variables/parameters in `qmltermwidget/lib/ProcessInfo.cpp`**: Added `Q_UNUSED()` to `managementInfoBase`, `mibLength`, `kInfoProc` in `FreeBSDProcessInfo::readProcInfo` and `aPid` in `MacProcessInfo::readProcInfo`. (Committed to submodule)
-   **`/*` within block comment warning**: Corrected a Doxygen comment style in `qmltermwidget/lib/TerminalDisplay.h` on line 153 and an empty comment on line 156. (Committed to submodule)
-   **Deprecated `width`**: Replaced calls to `QFontMetrics::width()` with `QFontMetrics::horizontalAdvance()` in `qmltermwidget/lib/TerminalDisplay.cpp`. (Committed to submodule)
-   **Deprecated `background`**: Replaced `palette().background().color()` with `palette().window().color()` in `qmltermwidget/lib/TerminalDisplay.cpp`. (Committed to submodule)
-   **Deprecated `orientation`, `delta`, `pos` in mouse/wheel events**: Updated usage of these deprecated members of `QWheelEvent` and `QMouseEvent` to their modern `angleDelta().y()`, `angleDelta()`, and `position()` equivalents in `qmltermwidget/lib/TerminalDisplay.cpp`. Also corrected `QPointF` to `QPoint` conversion and appropriate casting for `QWheelEvent` constructor parameters. (Committed to submodule)
-   **Deprecated `start`**: Replaced `QDrag::start()` with `QDrag::exec()` in `qmltermwidget/lib/TerminalDisplay.cpp`. (Committed to submodule)
-   **Deprecated `QWheelEvent` constructor**: Updated the `QWheelEvent` constructor call in `qmltermwidget/lib/TerminalDisplay.cpp` to match the correct signature for Qt 5.15.18, including `phase` and `inverted` parameters and proper type casting for `buttons` and `modifiers`. (Committed to submodule)
-   **Member initialization order warning**: Reordered member initializers in the `TerminalDisplay` constructor within `qmltermwidget/lib/TerminalDisplay.cpp` to match their declaration order. (Committed to submodule)
-   **Property declaration warnings in `qmltermwidget/src/ksession.h`**: Added `READ` accessors (`getShellProgram`, `getShellProgramArgs`) to the `shellProgram` and `shellProgramArgs` Q_PROPERTY declarations in `ksession.h`. Implemented these accessors in `ksession.cpp` and ensured the member variables are correctly initialized in the `KSession` constructor. (Committed to submodule)
-   **Unused parameters in `KSession::sendKey`**: Marked `rep`, `key`, `mod` as `Q_UNUSED` in `ksession.cpp`. (Committed to submodule)

**Remaining Warnings (Not Addressed due to Constraints/Harmlessness):**

-   **Missing `override` keywords**: Warnings about `paint`, `geometryChanged`, and `itemChange` in `qmltermwidget/lib/TerminalDisplay.h` not being marked `override` were not addressed. Adding `override` previously caused compilation errors, and the user's request emphasized avoiding new errors.
-   **`ld: warning: -single_module is obsolete`**: This is a linker warning indicating an obsolete flag. The build completes successfully, and this warning is generally harmless. It does not affect the functionality of the application.

## Bug Fixes (2025-11-28)

-   **Application hangs on quit (macOS)**:
    -   **Problem**: The application would hang when quitting using `Cmd+Q` or closing the window on macOS, while `Ctrl+D` would quit cleanly. This was traced to `_shellProcess->waitForFinished()` in `qmltermwidget/lib/Session.cpp` blocking indefinitely if the underlying shell process didn't terminate quickly after receiving a `SIGHUP` signal.
    -   **Solution**: Removed the blocking call to `_shellProcess->waitForFinished()` from `Session::sendSignal()` in `qmltermwidget/lib/Session.cpp`. This allows the application to rely on the asynchronous `finished()` signal of the shell process for proper cleanup, preventing the hang.

## Bug Fixes (2025-11-29)

- Fix: Special chars not rendering on arm64 macOS
    - Adds a constructor function to set the LC_CTYPE environment variable to UTF-8 and refresh locale state before main() runs. This ensures proper UTF-8 handling for system calls on arm64 macOS.

## Better Build Pipeline (2025-11-30)

- Simplified build process by specifying macOS specific instructions in `app/app.pro`

## Improved Code Quality (2025-11-30)

- Implemented a safer and standard practice to implement the chars rendering fix in `main()`

## Deprecation of Linux Support (2026-01-18)

**Rationale:** This fork is focused on macOS development. Linux support has been deprecated to simplify the codebase and focus development efforts.

**Note:** The `qmltermwidget` submodule was NOT modified per user request, as it may be synced with upstream in the future.

## Update GUI to feel more native (2026-01-18)

Updated the cool-retro-term GUI to feel more native on macOS ("menus, controls, etc") and use Qt5 transitional features (Qt.labs.platform) to ease the path to Qt6.
