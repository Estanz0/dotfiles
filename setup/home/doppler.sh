#!/bin/bash
# Doppler setup for the home (global) config, plus chamber for project secrets.
# Installs the Doppler CLI and logs in so ~/.zshenv.local can load secrets;
# installs chamber (segmentio) so `chamber exec <project>/<env> --` can read a
# project's SSM Parameter Store path with the AWS keys Doppler injects.
# On headless machines, skip login and set DOPPLER_TOKEN instead.
set -euo pipefail

# ─── Install ──────────────────────────────────────────────────────────────────
if ! command -v doppler &>/dev/null; then
    echo "Installing Doppler..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install dopplerhq/cli/doppler
    else
        curl -sLf --retry 3 --tlsv1.2 --proto "=https" \
            'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' \
            | sudo gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg
        echo "deb [sign-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" \
            | sudo tee /etc/apt/sources.list.d/doppler-cli.list
        sudo apt-get update -q || echo "Warning: apt-get update had errors (continuing...)"
        sudo apt-get install -y doppler
    fi
fi

# ─── chamber (SSM Parameter Store client for project secrets) ────────────────
if ! command -v chamber &>/dev/null; then
    echo "Installing chamber..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install chamber
    else
        echo "Warning: install chamber from https://github.com/segmentio/chamber/releases (skipping)"
    fi
fi

# ─── Login ────────────────────────────────────────────────────────────────────
# Required for ~/.zshenv.local to load secrets. On headless machines, set
# DOPPLER_TOKEN to a service token instead of running this.
echo "Logging into Doppler (skip with Ctrl-C on headless machines)..."
doppler login
