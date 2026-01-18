**Context:**
I need to port the `cool-retro-term` application from Qt5 to Qt6. The original project relies on a heavily modified, unmaintained fork of `qmltermwidget`.

**Strategic Decision:** Instead of porting the old fork, I want to switch to the active, upstream **LXQt `qmltermwidget` (master branch)** to ensure future maintainability. I am willing to sacrifice non-core features (like baud rate simulation or specific font tweaks) temporarily to achieve a stable build.

**Action Required: Complete Submodule Replacement**

Before writing any code, we must switch the underlying dependency to the upstream version. Please perform the following Git and file system operations:

1.  **Remove the Old Submodule:**
    *   De-initialize and remove the existing `qmltermwidget` submodule (the old fork) from the git repository.
    *   Delete the corresponding directory and clean up `.gitmodules`.

2.  **Add the New Submodule:**
    *   Add the upstream repository `https://github.com/lxqt/qmltermwidget.git` as a new submodule at the path `qmltermwidget`.
    *   **Important:** Checkout the `master` branch.

3.  **Update Build Configuration:**
    *   Modify the root `cool-retro-term.pro` (or `CMakeLists.txt`) to include the *new* submodule file structure.
    *   *Note:* The file names and folder structure in the LXQt version will differ from the old fork. Do not try to compile yet, just ensure the build system points to the new paths (e.g., look for `qmltermwidget.pro` or `CMakeLists.txt` inside the new directory).

**Expectation:** The project will *not* compile after this step. This is expected. We will fix the API breakages in the next phase.

**Task:**
Please execute the porting process following these specific phases:

**Phase 1: Proof of Concept (Shader Compatibility Check)**
1.  Set up a new Qt6 environment including `Qt6::Core5Compat` and `Qt6::Quick`.
2.  Compile the upstream LXQt `qmltermwidget` as a library.
3.  Create a minimal "Hello World" QML application that instantiates the upstream `QmlTermWidget`.
4.  **Critical Step:** Verify if the widget can serve as a `source` for a `ShaderEffect` or `ShaderEffectSource`. Apply a basic shader (e.g., a simple blur or color inversion) to the terminal widget to confirm that Qt6 RHI (Rendering Hardware Interface) handles the texture correctly.

**Phase 2: The Adapter Layer (C++)**
1.  Do not modify the upstream `qmltermwidget` source code directly.
2.  Create a wrapper class (e.g., `CRTermWidget`) in the main project that inherits from the upstream widget.
3.  Implement an **Adapter Pattern**: Expose the properties and signals expected by `cool-retro-term`'s existing QML (e.g., font handling, color schemes) and map them to the new upstream APIs inside this wrapper.
4.  Stub out (leave empty) any complex legacy functions that don't have direct upstream equivalents for now.

**Phase 3: QML Migration & Core Functionality**
1.  Update the project's build system (CMake/QMake) to link against the upstream library.
2.  Replace usages of the old `QTerminal` imports with the new wrapper class in the QML files.
3.  Replace obsolete Qt5 imports:
    *   Change `import QtGraphicalEffects` to `import Qt5Compat.GraphicalEffects`.
    *   Remove `QtQuick.Controls 1.x` and migrate basic controls to `QtQuick.Controls 2` or `Basic`.
4.  Comment out non-essential features in the QML (custom scrollbars, settings menus regarding performance hacks) to get the application to launch.

**Phase 4: Verification**
1.  Ensure the application launches without crashing.
2.  Verify basic terminal Input/Output works.
3.  Verify the retro visual effects (Shaders) are rendering over the terminal window.

**Goal:** A running Qt6 version of cool-retro-term using unmodified upstream dependencies, even if some advanced settings are currently disabled.
