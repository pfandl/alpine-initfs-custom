#!/usr/bin/env sh

set -e

[ -d root ] || mkdir root
cd root

cp ../../init .
cp ../../linuxrc .
cp ../../linuxrc init
cp ../../simple.script bin

[ -d lib/modules ] || {
  mkdir lib/modules
  rsync -av              \
        --progress       \
        --exclude build  \
        --exclude source \
        ../../kernel/out/lib/modules lib/
  find lib/modules/ -name "*.ko" -exec strip --strip-unneeded {} \;
}

find . 2>/dev/null |              \
  cpio --quiet -o --format=newc | \
  xz -0 --format=lzma             \
  > ../initrd-shell.lz

cp ../../kernel/out/vmlinuz* ../../../mnt/var/www/html/vmlinuz-shell
cp ../initrd-shell.lz ../../../mnt/var/www/html/
