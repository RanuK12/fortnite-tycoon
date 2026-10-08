#!/usr/bin/env python3
import sys
import os

def test_verse_file():
    file_path = "verse/core/game_mode.verse"
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"{file_path} not found")
    with open(file_path, 'r') as f:
        content = f.read()
    # Check for class definition
    if "tycoon_game_mode := class(creative_game_mode):" not in content:
        raise AssertionError("Missing class definition")
    # Check for OnBegin method
    if "OnBegin<override>()" not in content:
        raise AssertionError("Missing OnBegin method")
    # Check for log
    if 'Log("Tycoon GameMode iniciado")' not in content:
        raise AssertionError("Missing log message")
    print("All checks passed")

if __name__ == "__main__":
    try:
        test_verse_file()
        sys.exit(0)
    except Exception as e:
        print(f"Test failed: {e}")
        sys.exit(1)
