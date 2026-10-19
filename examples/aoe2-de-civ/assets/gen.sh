#!/usr/bin/env bash
# Regenerate San Franciscans' 2D concept art via local ComfyUI (`um comfy`), or use Antigravity's `image-generator` subagent.
# The files in gen/ are the ones the mod shipped with.
#
#   assets/gen.sh concepts     # unit concept art
#   assets/gen.sh meshes       # note on 3D meshes (gen/*.glb)
#   assets/gen.sh images       # 2D art: wonder, emblem, unit portraits
#   assets/gen.sh all
#
# Units are rendered from 3D so every one of AoE2's 16 facing angles is consistent; the concept
# images are only the input to image-to-3D. Accents meant to take the player's colour are asked for
# in saturated blue and masked by hue when the sprites are packed (make_sprites.py).
set -euo pipefail
cd "$(dirname "$0")"
UM=${UM:-$(command -v um || echo ../../../bin/um)}
OUT=gen

comfy_gen() {  # name prompt
  "$UM" comfy image "$2" --out "$OUT/$1.png"
}

CONCEPT_STYLE="clean studio product render, three-quarter front view from slightly above, soft even lighting, whole object in frame, isolated on a plain white background, no text, no logos"
AOE_STYLE="in the style of Age of Empires II Definitive Edition building sprites: detailed pre-rendered 3D, warm sunlight from the upper left, isometric three-quarter view from above at 30 degrees, on a plain white background, no text"

concepts() {
  comfy_gen robotaxi_concept "a white compact electric SUV robotaxi, a black spinning lidar sensor dome on the roof, small black sensor pods on the front fenders and mirrors, tinted windows, bright saturated blue accent stripes along the sides and blue wheel rims. $CONCEPT_STYLE"
  comfy_gen drone_concept "a white quadcopter delivery drone with four rotors on arms, carrying a small brown cardboard parcel underneath, bright saturated blue accent panels on the body and the rotor guards. $CONCEPT_STYLE"
}

meshes() {
  echo "Shipped 3D meshes (gen/robotaxi.glb, gen/drone.glb) are available in $OUT."
  echo "To generate new 3D models, convert concept images to GLB using your local 3D pipeline."
}

images() {
  comfy_gen wonder "the Transamerica Pyramid skyscraper in San Francisco as a game wonder building: a tall white four-sided pyramid tower with narrow vertical windows and two wings near the top, standing on a square grey stone plaza with small palm trees and bright blue banners at the corners, $AOE_STYLE"
  comfy_gen emblem "a heraldic civilization emblem for a game: the Golden Gate Bridge's red-orange tower over blue bay waves on a round golden-bordered shield, flat painted game icon, centered, plain white background, no text"
  comfy_gen icon_robotaxi "a square game unit portrait icon in the painted style of Age of Empires II: a modern white electric self-driving robotaxi crossover with a black lidar sensor dome on its roof and blue trim, three-quarter front view, parked on a medieval cobblestone street between timber houses, dramatic warm lighting, detailed oil painting, no text, no logos"
  comfy_gen icon_drone "a square game unit portrait icon in the painted style of Age of Empires II: a white quadcopter delivery drone carrying a parcel over a medieval town at dusk, dramatic lighting, detailed painting, no text"
}

case "${1:-}" in
  concepts) concepts ;;
  meshes) meshes ;;
  images) images ;;
  all) concepts; meshes; images ;;
  *) sed -n '2,8p' "$0"; exit 1 ;;
esac
