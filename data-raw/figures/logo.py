#!/usr/bin/env python3
"""Peacock hex logo, Indian folk-art styling (Madhubani/kolam ornament).
Usage: python gen_logo2.py <variant> <out.svg>   variant in {indigo,maroon,cream}"""
import math, sys

R = 290.0
cx, cy = 261.0, 300.0
W, H = 522, 600

def rad(a): return math.radians(a)

def hex_pts(r):
    return [(cx + r*math.cos(rad(a)), cy - r*math.sin(rad(a)))
            for a in (90, 150, 210, 270, 330, 30)]

def hex_path(r):
    p = hex_pts(r)
    return "M " + " L ".join(f"{x:.2f},{y:.2f}" for x, y in p) + " Z"

def hex_perimeter_dots(r, per_edge):
    """Evenly spaced points along the hex outline at radius r."""
    p = hex_pts(r)
    out = []
    for i in range(6):
        x0, y0 = p[i]
        x1, y1 = p[(i+1) % 6]
        for k in range(per_edge):
            t = k / per_edge
            out.append((x0 + (x1-x0)*t, y0 + (y1-y0)*t))
    return out

# ---------- palette ----------
FILL = dict(
    feather="#12967E", feather2="#0C6E5E",
    body="#1657A6", body2="#0E3C7E",
    breast="#1E9C7F",
    eye_gold="#E9B44C", eye_green="#1F9E80", eye_navy="#0E2C63",
    gold="#E7B24B", vermilion="#E4572E", ivory="#F7ECD2",
)
VARIANTS = {
    "indigo": dict(bg="#1A2159", bg2="#10143A", line="#E7B24B"),
    "maroon": dict(bg="#5E1526", bg2="#3A0C17", line="#E7B24B"),
    "cream":  dict(bg="#F1E3C4", bg2="#E6D2A6", line="#1B2A63"),
}

def build(variant):
    V = VARIANTS[variant]
    line = V["line"]
    C = {**FILL, **V}

    # ---------- feather fan ----------
    FX, FY = 261.0, 428.0
    angles = [30, 45, 60, 75, 90, 105, 120, 135, 150]
    R_TIP = 230.0
    R_BASE = 50.0

    def leaf(rb, rt, w=20):
        mid = (rb+rt)/2
        return (f"M {rb:.1f},0 Q {mid:.1f},{-w:.1f} {rt:.1f},0 "
                f"Q {mid:.1f},{w:.1f} {rb:.1f},0 Z")

    def eyespot():
        # dotted halo
        dots = ""
        n = 13
        for i in range(n):
            a = 2*math.pi*i/n
            dx, dy = 31*math.cos(a), 24*math.sin(a)
            dots += f'<circle cx="{dx:.1f}" cy="{dy:.1f}" r="1.7" fill="{C["gold"]}"/>'
        return (
            dots +
            f'<ellipse rx="26" ry="19.5" fill="{C["eye_gold"]}" '
            f'stroke="{line}" stroke-width="1.4"/>'
            f'<ellipse rx="18" ry="13.5" fill="{C["eye_green"]}" '
            f'stroke="{line}" stroke-width="1.1"/>'
            f'<ellipse cx="2" rx="11" ry="9.5" fill="{C["eye_navy"]}" '
            f'stroke="{line}" stroke-width="1"/>'
            f'<path d="M -4,-6 Q 4,-9 8,-2" fill="none" stroke="{C["ivory"]}" '
            f'stroke-width="1.6" stroke-linecap="round" opacity="0.85"/>'
            f'<circle cx="-2" cy="-3" r="1.8" fill="{C["ivory"]}"/>'
        )

    feathers = ""
    for th in angles:
        barbs = ""
        for r in (95, 120, 145, 170):
            barbs += (f'<line x1="{r}" y1="0" x2="{r-10}" y2="-7" stroke="{line}" '
                      f'stroke-width="1.3" stroke-linecap="round" opacity="0.7"/>'
                      f'<line x1="{r}" y1="0" x2="{r-10}" y2="7" stroke="{line}" '
                      f'stroke-width="1.3" stroke-linecap="round" opacity="0.7"/>')
        feathers += (
            f'<g transform="translate({FX},{FY}) rotate({-th})">'
            f'<path d="{leaf(R_BASE, R_TIP)}" fill="url(#fan)" '
            f'stroke="{line}" stroke-width="1.3"/>'
            f'<line x1="{R_BASE}" y1="0" x2="{R_TIP-14}" y2="0" stroke="{line}" '
            f'stroke-width="1.8" opacity="0.85" stroke-linecap="round"/>'
            f'{barbs}'
            f'<g transform="translate({R_TIP},0)">{eyespot()}</g>'
            f'</g>'
        )

    # ---------- body: neck + breast, patterned ----------
    body_path = ("M 261,300 C 251,301 246,320 246,342 C 246,372 221,398 222,430 "
                 "C 223,470 240,512 261,536 C 282,512 299,470 300,430 "
                 "C 301,398 276,372 276,342 C 276,320 271,301 261,300 Z")
    # scalloped breast pattern (rows of small arcs)
    scallop = ""
    for row, (yy, half, step) in enumerate([(392, 34, 17), (420, 30, 15), (448, 24, 12)]):
        xs = [261 + s for s in range(-half, half+1, step)]
        for x in xs:
            scallop += (f'<path d="M {x-step*0.5:.1f},{yy} Q {x:.1f},{yy+9} '
                        f'{x+step*0.5:.1f},{yy}" fill="none" stroke="{C["gold"]}" '
                        f'stroke-width="1.3" opacity="0.9"/>')
    # neck bands
    for yy in (322, 336):
        scallop += (f'<path d="M 250,{yy} Q 261,{yy+5} 272,{yy}" fill="none" '
                    f'stroke="{C["gold"]}" stroke-width="1.4"/>')
    body = (
        f'<path d="{body_path}" fill="url(#body)" stroke="{line}" stroke-width="1.8"/>'
        f'<ellipse cx="261" cy="402" rx="21" ry="34" fill="{C["breast"]}" opacity="0.35"/>'
        f'{scallop}'
        f'<circle cx="261" cy="290" r="27" fill="url(#body)" stroke="{line}" stroke-width="1.8"/>'
    )

    # ---------- crown / crest with tikka ----------
    crest = ""
    for dx, ty in [(-20, 226), (0, 216), (20, 226)]:
        crest += (f'<line x1="261" y1="266" x2="{261+dx*0.5:.0f}" y2="{ty+8}" '
                  f'stroke="{C["gold"]}" stroke-width="2.6" stroke-linecap="round"/>'
                  f'<circle cx="{261+dx}" cy="{ty}" r="5.5" fill="{C["eye_green"]}" '
                  f'stroke="{line}" stroke-width="1.1"/>'
                  f'<circle cx="{261+dx}" cy="{ty}" r="1.8" fill="{C["gold"]}"/>')
    # forehead tikka
    crest += (f'<path d="M 261,272 q 5,6 0,13 q -5,-7 0,-13 Z" fill="{C["vermilion"]}" '
              f'stroke="{line}" stroke-width="1"/>')

    # ---------- face: almond eyes + beak ----------
    face = (
        f'<path d="M 243,286 Q 250,281 257,286 Q 250,291 243,286 Z" fill="{C["ivory"]}" '
        f'stroke="{line}" stroke-width="1"/>'
        f'<path d="M 265,286 Q 272,281 279,286 Q 272,291 265,286 Z" fill="{C["ivory"]}" '
        f'stroke="{line}" stroke-width="1"/>'
        f'<circle cx="250" cy="286.5" r="2.6" fill="{C["eye_navy"]}"/>'
        f'<circle cx="272" cy="286.5" r="2.6" fill="{C["eye_navy"]}"/>'
        f'<path d="M 255,301 L 267,301 L 261,312 Z" fill="{C["vermilion"]}" '
        f'stroke="{line}" stroke-width="1"/>'
    )

    # ---------- lotus pedestal ----------
    lotus = ""
    ly = 548
    petals = [(-70, -16), (-46, -26), (-22, -32), (0, -35), (22, -32), (46, -26), (70, -16)]
    for dx, tip in petals:
        lotus += (f'<path d="M {261+dx*0.35:.0f},{ly} Q {261+dx*0.7:.0f},{ly+tip} '
                  f'{261+dx:.0f},{ly-6} Q {261+dx*0.7:.0f},{ly+4} {261+dx*0.35:.0f},{ly} Z" '
                  f'fill="{C["eye_gold"]}" stroke="{line}" stroke-width="1.2"/>')
    lotus += (f'<path d="M 231,{ly} Q 261,{ly+18} 291,{ly}" fill="none" '
              f'stroke="{line}" stroke-width="1.6"/>')

    # ---------- kolam dotted border ----------
    dots = ""
    for x, y in hex_perimeter_dots(R-16, 8):
        dots += f'<circle cx="{x:.1f}" cy="{y:.1f}" r="2.4" fill="{C["gold"]}"/>'

    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}">
  <defs>
    <radialGradient id="bg" cx="0.5" cy="0.42" r="0.75">
      <stop offset="0" stop-color="{C['bg']}"/>
      <stop offset="1" stop-color="{C['bg2']}"/>
    </radialGradient>
    <radialGradient id="fan" cx="{FX}" cy="{FY}" r="{R_TIP}" gradientUnits="userSpaceOnUse">
      <stop offset="0.12" stop-color="{C['feather2']}"/>
      <stop offset="1" stop-color="{C['feather']}"/>
    </radialGradient>
    <linearGradient id="body" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="{C['body']}"/>
      <stop offset="1" stop-color="{C['body2']}"/>
    </linearGradient>
    <clipPath id="clip"><path d="{hex_path(R)}"/></clipPath>
  </defs>
  <path d="{hex_path(R)}" fill="url(#bg)"/>
  <g clip-path="url(#clip)">
    {feathers}
    {lotus}
    {body}
    {crest}
    {face}
  </g>
  <path d="{hex_path(R-6)}" fill="none" stroke="{line}" stroke-width="5"/>
  <path d="{hex_path(R-27)}" fill="none" stroke="{line}" stroke-width="1.6" opacity="0.8"/>
  {dots}
</svg>
'''
    return svg

variant = sys.argv[1] if len(sys.argv) > 1 else "indigo"
out = sys.argv[2] if len(sys.argv) > 2 else f"logo_{variant}.svg"
with open(out, "w", encoding="utf-8") as f:
    f.write(build(variant))
print("wrote", out)
