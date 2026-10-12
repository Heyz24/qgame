#!/bin/sh
# Runs every test of the qgame package. Needs qaxlc on PATH and a way to run Windows .exe files
# (on Windows: nothing special; on Linux/macOS set QAX_RUN=wine64). Exit code 0 only if everything passed.
cd "$(dirname "$0")" || exit 1
RUN="${QAX_RUN:-}"
fail=0
qaxlc selftest.qax -o selftest.exe >/dev/null || exit 1
$RUN ./selftest.exe || fail=1
qaxlc negative.qax -o negative.exe >/dev/null || exit 1
# case number -> source file whose assert must fire (see the table at the top of negative.qax)
i=0
for f in grid grid grid grid grid grid grid grid rect rect rng rng rng rng clock clock rng; do
  out=$(echo $i | $RUN ./negative.exe 2>&1 >/dev/null); code=$?
  case "$out" in *"assertion failed [$f.qax:"*) ok=1;; *) ok=0;; esac
  if [ $code -ne 101 ] || [ $ok -ne 1 ]; then echo "FAIL: negative case $i (exit $code): $out"; fail=1; fi
  i=$((i+1))
done
echo "qgame negative cases: $i run"
rm -f selftest.exe negative.exe
exit $fail
