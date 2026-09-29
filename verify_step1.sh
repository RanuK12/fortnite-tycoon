#!/bin/bash
set -e
D="$(pwd)"
echo "Verifying step 1: repo structure and README"
# Check directories
for dir in verse docs design; do
    if [ -d "$D/$dir" ]; then
        echo "✓ $dir exists"
    else
        echo "✗ $dir missing"
        exit 1
    fi
done
# Check README
if [ -f "$D/README.md" ]; then
    echo "✓ README.md exists"
    # Check for required content
    if grep -q "Fortnite Tycoon" "$D/README.md"; then
        echo "✓ README contains project title"
    else
        echo "✗ README missing project title"
        exit 1
    fi
    if grep -q "Windows 10/11" "$D/README.md"; then
        echo "✓ README mentions Windows requirement"
    else
        echo "✗ README missing Windows requirement"
        exit 1
    fi
    if grep -q "verse/" "$D/README.md" && grep -q "docs/" "$D/README.md" && grep -q "design/" "$D/README.md"; then
        echo "✓ README describes project structure"
    else
        echo "✗ README missing structure description"
        exit 1
    fi
else
    echo "✗ README.md missing"
    exit 1
fi
echo "All checks passed."
