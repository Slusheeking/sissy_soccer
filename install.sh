#!/bin/bash

# Sissy Soccer Game Installer for Ubuntu
# This script installs Sissy Soccer to your home directory

set -e

echo "================================="
echo "  Sissy Soccer Game Installer"
echo "================================="
echo ""

# Create game directory
GAME_DIR="$HOME/.local/share/sissy-soccer"
mkdir -p "$GAME_DIR"

echo "Installing to: $GAME_DIR"

# Check if game HTML file exists in current directory
if [ ! -f "sissy_soccer.html" ]; then
    echo "ERROR: sissy_soccer.html not found in current directory!"
    echo "Please make sure both this script and sissy_soccer.html are in the same folder."
    exit 1
fi

# Copy game file
cp sissy_soccer.html "$GAME_DIR/sissy_soccer.html"
echo "✓ Game files copied"

# Create launcher script
LAUNCHER="$GAME_DIR/play-sissy-soccer.sh"
cat > "$LAUNCHER" << 'EOF'
#!/bin/bash
xdg-open "$HOME/.local/share/sissy-soccer/sissy_soccer.html"
EOF

chmod +x "$LAUNCHER"
echo "✓ Launcher created"

# Create desktop entry
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

DESKTOP_FILE="$DESKTOP_DIR/sissy-soccer.desktop"
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Sissy Soccer
Comment=Play Sissy Soccer game
Exec=$LAUNCHER
Icon=applications-games
Terminal=false
Categories=Game;
EOF

echo "✓ Desktop entry created"

# Create command line shortcut
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
ln -sf "$LAUNCHER" "$BIN_DIR/sissy-soccer"
echo "✓ Command line shortcut created"

echo ""
echo "================================="
echo "  Installation Complete!"
echo "================================="
echo ""
echo "You can now play Sissy Soccer by:"
echo "  1. Searching for 'Sissy Soccer' in your application menu"
echo "  2. Running 'sissy-soccer' in terminal (if ~/.local/bin is in PATH)"
echo "  3. Opening: $GAME_DIR/sissy_soccer.html"
echo ""
echo "Would you like to play now? (y/n)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Launching game..."
    xdg-open "$GAME_DIR/sissy_soccer.html"
fi

echo ""
echo "Enjoy the game!"
echo ""
echo "  ███████╗██╗███████╗███████╗██╗   ██╗"
echo "  ██╔════╝██║██╔════╝██╔════╝╚██╗ ██╔╝"
echo "  ███████╗██║███████╗███████╗ ╚████╔╝ "
echo "  ╚════██║██║╚════██║╚════██║  ╚██╔╝  "
echo "  ███████║██║███████║███████║   ██║   "
echo "  ╚══════╝╚═╝╚══════╝╚══════╝   ╚═╝   "
echo ""