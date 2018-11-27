#!/bin/bash

files=0
errors=0

while read -r file
do
  ((files++))
  if ! stderr="$(php -l "$file" 2>&1 >/dev/null)" || [ -n "$stderr" ]; then
    ((errors++))
    if [ -n "$stderr" ]; then
      echo "$file: $stderr" >&2
      echo >&2
    fi
  fi
done < <(find . -type f -name "*.php")

if [ $errors -gt 0 ]; then
  echo "Found syntax errors in $errors of $files files!" >&2
  exit 1
else
  echo "Checked $files files successfully!"
fi
