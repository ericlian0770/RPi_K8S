#!/bin/bash
set -e

echo "Installing AI tools..."

# Update system
sudo apt update && sudo apt upgrade -y

# 1) Gemini (example: via pip if available)
echo "Installing Gemini..."
pip install gemini-ai || echo "Gemini package not found, please check source."

# 2) Codex (example placeholder)
echo "Installing Codex..."
pip install openai-codex || echo "Codex package not found, please check source."

# 3) OpenCode (placeholder)
echo "Installing OpenCode..."
npm install -g opencode || echo "OpenCode package not found, please check source."

# 4) Pi (example: math/AI library)
echo "Installing Pi..."
pip install pi-ai || echo "Pi package not found, please check source."

# 5) OpenClaw (placeholder)
echo "Installing OpenClaw..."
pip install openclaw || echo "OpenClaw package not found, please check source."

# 6) Antigravity (fun Python easter egg)
echo "Installing Antigravity..."
pip install antigravity || echo "Antigravity is built into Python (import antigravity)."

# 7) Vibe (placeholder)
echo "Installing Vibe..."
npm install -g vibe || echo "Vibe package not found, please check source."

# 8) VSCode (real package)
echo "Installing VSCode..."
sudo apt install -y code || echo "VSCode install failed, check Microsoft repo setup."

# 9) Hermes (example: AI model wrapper)
echo "Installing Hermes..."
pip install hermes-ai || echo "Hermes package not found, please check source."

# 10) Cline (real VSCode extension)
echo "Installing Cline..."
code --install-extension cline || echo "Cline extension not found, please check marketplace."

echo "All installations attempted."
