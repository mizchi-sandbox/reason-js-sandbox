#!/usr/bin/env sh
rm -rf _build
mkdir -p _build/reason-js
node_modules/bs-platform/bin/bsc.exe -g -bin-annot -pp "refmt --print binary" -bs-package-name self \
  -bs-package-output commonjs:_build/reason-js -o _build/reason-js/ReasonJs \
  -c -impl node_modules/reason-js/src/ReasonJs.re
mkdir -p _build/self
selfSortedFiles=$(ocamldep -ppx ./node_modules/bs-platform/bin/bsppx.exe -pp "refmt --print binary" -sort -ml-synonym .re src/*.re)

for source in $selfSortedFiles
do
  destination=$(echo $source | sed "s/src/_build\/self/" | sed "s/\.re$//")
  node_modules/bs-platform/bin/bsc.exe -g -bin-annot -pp "refmt --print binary" -bs-package-name self \
    -bs-package-output commonjs:_build/self -I _build/self -I _build/reason-js \
    -o $destination -c -impl $source
done
