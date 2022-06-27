#!/bin/sh -l
set -e

echo Creating deployer directory

mkdir -p ~/.config/dfx/identity/default

echo Adding identity.pem

echo $INPUT_IDENTITY > ~/.config/dfx/identity/default/identity.pem
sed -i 's/\\r\\n/\r\n/g' ~/.config/dfx/identity/default/identity.pem

echo "Deploying to $INPUT_NETWORK"

echo -e "> $INPUT_NETWORK: Generating required files.."
ENV=$INPUT_NETWORK cargo test --test generate -q

echo -e "$INPUT_NETWORK > Deploying foo_canister canister.."
dfx deploy --network=$INPUT_NETWORK foo_canister --no-wallet
echo -e "$INPUT_NETWORK > Deploying bar_canister canister.."
dfx deploy --network=$INPUT_NETWORK bar_canister --no-wallet

echo -e "$INPUT_NETWORK > Removing .dfx and target folder.."
rm -rf .dfx
rm -rf target