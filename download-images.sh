#!/usr/bin/env bash
# Downloads every site image into public/img/. Run from repo root: bash download-images.sh
# Source: Pexels (Pexels License — free for commercial use, no attribution required).
set -euo pipefail

mkdir -p public/img
base="https://images.pexels.com/photos"

map=(
  "hero-01:7721062" "hero-02:35275363" "hero-03:30475302" "hero-04:9493985"
  "hero-05:35158328" "hero-06:28279109" "hero-07:188916"  "hero-08:15480506"
  "company:28729467"
  "cap-investment:7534561" "cap-development:6933852"
  "cap-construction:8221720" "cap-management:34607320"
  "brand:15210485"
  "pf-riverside:17364664" "pf-harbor:21284473" "pf-center:4322027"
  "pf-mill:7078180" "pf-hq:17256453" "pf-depot:30271883"
  "case-center:8135502" "case-harbor:31737843" "case-mill:7045945"
  "ctx-lobby:29870243" "ctx-hall:695193" "ctx-street:31258508"
  "ctx-rooftop:16135943" "ctx-residence:20439293"
  "news-leasing:18703869" "news-project:18254581" "news-phase:33837741"
)

fail=0
for pair in "${map[@]}"; do
  name="${pair%%:*}"; id="${pair##*:}"
  url="${base}/${id}/pexels-photo-${id}.jpeg?auto=compress&cs=tinysrgb&w=1920"
  printf '→ %-16s (id %s)\n' "${name}.jpg" "$id"
  curl -fsSL "$url" -o "public/img/${name}.jpg" || { echo "   !! FAILED: $name"; fail=1; }
done
count=$(ls -1 public/img/*.jpg 2>/dev/null | wc -l | tr -d ' ')
echo "Saved ${count} images to public/img/"
[ "$fail" -eq 0 ] || { echo "Some downloads failed."; exit 1; }
