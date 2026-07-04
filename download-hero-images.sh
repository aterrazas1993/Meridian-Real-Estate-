#!/usr/bin/env bash
# Downloads the 8 hero images into public/img/ as hero-01.jpg ... hero-08.jpg
# Run from your repo root:  bash download-hero-images.sh
# Source: Pexels (Pexels License — free for commercial use, no attribution required).
set -euo pipefail

mkdir -p public/img
base="https://images.pexels.com/photos"
ids=(7721062 35275363 30475302 9493985 35158328 28279109 188916 15480506)

i=1
for id in "${ids[@]}"; do
  n=$(printf "%02d" "$i")
  # compressed, 1920px wide — good quality, small file
  url="${base}/${id}/pexels-photo-${id}.jpeg?auto=compress&cs=tinysrgb&w=1920"
  echo "→ hero-${n}.jpg"
  curl -fsSL "$url" -o "public/img/hero-${n}.jpg"
  i=$((i+1))
done

echo "Done — 8 images saved to public/img/"
