#!/usr/bin/env sh

docker build -t alpine-initrd .

[ -d .root ] || mkdir .root

cd .root
docker save alpine-initrd > root.tar
tar xf root.tar
find -maxdepth 1 -type d ! -path . ! -path ./root -exec sh -c "
	cd {}
	[ -d root ] || mkdir root
	cd root
	tar xf ../layer.tar
	cp -ar . ../../root
	cd ..
	rm -rf root
	cd ..
	rm -rf {}
	" \;
rm root.tar
rm *.json
rm repositories

cd ..
[ -d root ] && rm -rf root
mv .root/root root

