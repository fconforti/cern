"""Genera public/50-anni-al-CERN.pdf (da pdf/plan.typ) e public/og.jpg (da pdf/og.svg)
con il branding del sito.

Uso (dalla radice del repo):
    uv run --with typst --with segno --with pillow --with resvg-py --with fonttools python pdf/build.py
"""
import re
import urllib.request
from pathlib import Path

import io

import resvg_py
from fontTools.ttLib import TTFont
import segno
import typst
from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
PDF_DIR = ROOT / "pdf"
FONTS = PDF_DIR / ".fonts"
OG_FONTS = PDF_DIR / ".fonts-og"
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


def og_fonts() -> list[str]:
    """resvg non riconosce il nome "Fraunces 144pt" delle istanze statiche di Google:
    ne salva una copia rinominata "FrauncesOG", usata solo da og.svg."""
    OG_FONTS.mkdir(exist_ok=True)
    out = OG_FONTS / "FrauncesOG.ttf"
    if not out.exists():
        font = TTFont(FONTS / "Fraunces-800.ttf")
        names = font["name"]
        names.names = [r for r in names.names if r.nameID not in (1, 2, 4, 6, 16, 17)]
        for pid, eid, lid in ((3, 1, 0x409), (1, 0, 0)):
            for nid, value in ((1, "FrauncesOG"), (2, "Regular"), (4, "FrauncesOG"), (6, "FrauncesOG")):
                names.setName(value, nid, pid, eid, lid)
        font.save(out)
    return [str(out)] + [str(p) for p in sorted(FONTS.glob("Inter-*.ttf"))]


def main() -> None:
    fetch_fonts()
    segno.make(SITE, error="m").save(PDF_DIR / ".qr.svg", kind="svg", dark="#7fd1ff", light=None, border=0, scale=10)
    out = ROOT / "public" / "50-anni-al-CERN.pdf"
    typst.compile(str(PDF_DIR / "plan.typ"), output=str(out), root=str(ROOT), font_paths=[str(FONTS)])
    print(f"ok: {out.relative_to(ROOT)} ({out.stat().st_size // 1024} KB)")
    # Anteprima dei link (stile hero): SVG con i filtri neon, reso con i font del sito.
    def inner(svg: str) -> str:
        return svg[svg.index(">", svg.index("<svg")) + 1 : svg.rindex("</svg>")]
    hero = inner((ROOT / "src" / "assets" / "hero.svg").read_text())
    mark = inner((PDF_DIR / "mark.svg").read_text()).replace('id="glow"', 'id="mglow"').replace("url(#glow)", "url(#mglow)")
    svg = (PDF_DIR / "og.svg").read_text().replace("{{HERO}}", hero).replace("{{MARK}}", mark)
    png = resvg_py.svg_to_bytes(svg_string=svg, width=1200, font_files=og_fonts(), skip_system_fonts=True)
    # JPEG: più leggero del PNG (WhatsApp ignora le anteprime troppo pesanti).
    og = ROOT / "public" / "og.jpg"
    Image.open(io.BytesIO(bytes(png))).convert("RGB").save(og, "JPEG", quality=88, optimize=True, progressive=True)
    print(f"ok: {og.relative_to(ROOT)} ({og.stat().st_size // 1024} KB)")

if __name__ == "__main__":
    main()
