#!/bin/sh
printf '\033c\033]0;%s\a' walesi-bardok
base_path="$(dirname "$(realpath "$0")")"
"$base_path/walesi-bardok.v01.x86_64" "$@"
