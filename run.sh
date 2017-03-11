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
  # should give: _build/self/myDep then _build/self/myDep2 then _build/self/test
  node_modules/bs-platform/bin/bsc.exe -g -bin-annot -pp "refmt --print binary" -bs-package-name self \
    -bs-package-output commonjs:_build/self -I _build/self -I _build/reason-js \
    -o $destination -c -impl $source
done

# no linking! BuckleScript maps 1 Reason/OCaml file to 1 JS file. Feel free to
# use your current JS module bundler (e.g. Browserify, Webpack)!

# Are you ready to run your JS output?
node ./_build/self/test.js
