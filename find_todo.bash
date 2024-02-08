#!/usr/bin/env bash

hitted=0

KEYWORDS="TODO FIXME"
PATTERN=$(echo $KEYWORDS | sed 's/ /\\|/g') # This turns the space-separated list into a regex pattern

for file in $@; do
  if [ -f "$file" ]; then
    hits=$(git diff --cached -U0 $file | grep '^+.*\('"$PATTERN"'\)' | sed -e 's/^+//' -e "s/\($PATTERN\)/\x1b[1;31m\1\x1b[0m/g")
    if [ -n "$hits" ]; then
      printf "\x1b[1;31m$file:\x1b[0m\n"
      printf "$hits\n"
      hitted=1
    fi
  fi
done
exit $hitted
