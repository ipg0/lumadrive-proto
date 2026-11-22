#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

for tool in protoc protoc-gen-nanopb protoc-gen-dart; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Missing required tool: %s. Install protoc and its Nanopb/Dart plugins and add them to PATH.\n' "$tool" >&2
    exit 1
  fi
done

mkdir -p ../firmware/generated ../lumadrive_control/lib/generated

# generate the firmware types
protoc -I. --nanopb_out=../firmware/generated/ mesh.proto

# generate the dart files
protoc -I. --dart_out=../lumadrive_control/lib/generated/ mesh.proto
