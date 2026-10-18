"""Genera public/50-anni-al-CERN.pdf (da pdf/plan.typ) e public/og.png (da pdf/og.typ)
con il branding del sito.

Uso (dalla radice del repo):
    uv run --with typst --with segno python pdf/build.py
"""
import re
import urllib.request
from pathlib import Path

import segno
import typst

ROOT = Path(__file__).resolve().parent.parent
PDF_DIR = ROOT / "pdf"
FONTS = PDF_DIR / ".fonts"
SITE = "https://fconforti.github.io/cern/"
CSS = "https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,144,800;1,144,500&family=Inter:wght@400;600;700"


def fetch_fonts() -> None:
    FONTS.mkdir(exist_ok=True)
    css = urllib.request.urlopen(CSS, timeout=30).read().decode()
    blocks = re.findall(r"font-family: '([^']+)';\s*font-style: (\w+);\s*font-weight: (\d+);\s*src: url\(([^)]+\.ttf)\)", css)
    for family, style, weight, url in blocks:
        dest = FONTS / f"{family}-{weight}{'-italic' if style == 'italic' else ''}.ttf"
        if not dest.exists():
            dest.write_bytes(urllib.request.urlopen(url, timeout=60).read())


def main() -> None:
    fetch_fonts()
    segno.make(SITE, error="m").save(PDF_DIR / ".qr.svg", kind="svg", dark="#7fd1ff", light=None, border=0, scale=10)
    out = ROOT / "public" / "50-anni-al-CERN.pdf"
    typst.compile(str(PDF_DIR / "plan.typ"), output=str(out), root=str(ROOT), font_paths=[str(FONTS)])
    print(f"ok: {out.relative_to(ROOT)} ({out.stat().st_size // 1024} KB)")
    og = ROOT / "public" / "og.png"
    typst.compile(str(PDF_DIR / "og.typ"), output=str(og), format="png", ppi=72, root=str(ROOT), font_paths=[str(FONTS)])
    print(f"ok: {og.relative_to(ROOT)} ({og.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
