cmake_minimum_required(VERSION 3.16)

project(QKaraoke VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Widgets)

qt_standard_project_setup()

qt_add_executable(appQKaraoke
    main.cpp
)

qt_add_qml_module(appQKaraoke
    URI QKaraoke
    VERSION 1.0
    QML_FILES Main.qml
)



target_link_libraries(appQKaraoke PRIVATE
    Qt6::Quick
    Qt6::Widgets
    Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appQKaraoke
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
