file(REMOVE_RECURSE
  "QKaraoke/Main.qml"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appQKaraoke_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
