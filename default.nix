with import <nixpkgs> {}; {
  SCKOpenJDK11Env = gcc8Stdenv.mkDerivation {
    name = "SCKOpenJDK11-env";
    
    nativeBuildInputs = [
      stdenv
      gcc
      pkgconfig
      valgrind
      ccache
      unzip
      autoconf
      file
      zip
    ];

    buildInputs = [      
      openjdk11

      # libraries
      alsaLib
      freetype
      cups
      xlibs.libXaw
      xlibs.libXfont2
      xlibs.libXrender
      xlibs.libXft
      xlibs.libXres
      xlibs.libICE
      xlibs.libXcomposite
      xlibs.libXi
      xlibs.libXt
      xlibs.libSM
      xlibs.libXcursor
      xlibs.libXtst
      xlibs.libXmu
      xlibs.libXv
      xlibs.libX11
      xlibs.libXext
      xlibs.libXpresent
      xlibs.libXrandr
    ];

    OBF_JAVA11_HOME = "${openjdk11.out}/lib/openjdk";
  };
}
