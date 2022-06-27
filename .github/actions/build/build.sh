#!/bin/sh -l
set -e

echo "> $INPUT_NETWORK: Generating required files.."
ENV=$INPUT_NETWORK cargo test --test generate -q

echo "$INPUT_NETWORK > Building foo_canister canister.."
cargo build -q --target wasm32-unknown-unknown --package  foo_canister --release
echo "$INPUT_NETWORK > Building bar_canister canister.."
cargo build -q --target wasm32-unknown-unknown --package  bar_canister --release

echo "$INPUT_NETWORK > Removing target folder.."
rm -rf target