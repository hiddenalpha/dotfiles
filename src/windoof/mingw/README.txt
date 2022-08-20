
Some notes about cross compilation for windoof
==============================================

Packages (alpine):

  mingw-w64-gcc


make:

  CC=x86_64-w64-mingw32-gcc
  AR=x86_64-w64-mingw32-ar
  CPP=x86_64-w64-mingw32-cpp
  CXX=x86_64-w64-mingw32-g++
  LD=x86_64-w64-mingw32-ld
  NM=x86_64-w64-mingw32-nm
  BINEXT=.exe
  LIBSEXT=.lib
  LIBDPRE=
  LIBDEXT=.dll
  LIBSPREF=
  LIBSSUFF=.lib


DeflateAndInflate:

  TODO


zlib:

    && echo "\n  Build zlib\n" \
    && THEOLDPWD="$PWD" \
    && cd /tmp \
    && VERSION="1.2.11" \
    && curl -LsS -o "/tmp/zlib-${VERSION}.tgz" "https://github.com/madler/zlib/archive/refs/tags/v${VERSION:?}.tar.gz" \
    && tar xzf "/tmp/zlib-${VERSION:?}.tgz" \
    && export SRCDIR="/tmp/zlib-${VERSION:?}" \
    && mkdir $SRCDIR/build \
    && cd "${SRCDIR:?}" \
    && export DESTDIR=./build BINARY_PATH=/bin INCLUDE_PATH=/include LIBRARY_PATH=/lib \
    && sed -i "s;^PREFIX =.\*\$;;" win32/Makefile.gcc \
    && make -e -fwin32/Makefile.gcc PREFIX=x86_64-w64-mingw32- \
    && make -e -fwin32/Makefile.gcc install PREFIX=x86_64-w64-mingw32- \
    && unset DESTDIR BINARY_PATH INCLUDE_PATH LIBRARY_PATH \
    && cp README build/. \
    && (cd build && rm -rf lib/pkgconfig) \
    && (cd build && find -type f -not -name MD5SUM -exec md5sum -b {} + > MD5SUM) \
    && (cd build && tar --owner=0 --group=0 -cz *) > /tmp/zlib-1.2.11-windoof.tgz \
    && cd / \
    && rm -rf /tmp/zlib-1.2.11 \
    && mkdir -p /usr/local/x86_64-w64-mingw32 \
    && tar -C /usr/x86_64-w64-mingw32 -f /tmp/zlib-1.2.11-windoof.tgz -x include lib \
    && echo -e "\n  zlib Done :)\n" \
    && cd "${THEOLDPWD:?}" \

