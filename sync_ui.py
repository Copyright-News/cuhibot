#!/usr/bin/env python3
"""
Developer utility to synchronize the source-of-truth app.html
to index.html to prevent drift.
"""

from pathlib import Path

def main():
    root = Path(__file__).parent.resolve()
    app_html = root / "app.html"
    index_html = root / "index.html"
    
    if not app_html.exists():
        print(f"Error: Source file {app_html} does not exist.")
        return

    print("Synchronizing HTML mirrors...")
    
    # Read the source of truth
    content = app_html.read_text(encoding="utf-8")
    
    # Write to target mirror
    index_html.write_text(content, encoding="utf-8")
    print(f"-> Synchronized {index_html}")
    
    print("UI synchronization complete. All mirrors are 100% identical.")

if __name__ == "__main__":
    main()
