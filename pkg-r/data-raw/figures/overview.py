#!/usr/bin/env python3
"""Generate the peacock 'overview' diagram: command -> scaffolded project."""
import sys

W, H = 1240, 440
MONO = "'Consolas','JetBrains Mono','SFMono-Regular',monospace"
SANS = "'Segoe UI','Inter',system-ui,sans-serif"

P = dict(
    paper="#F3E7CC", border="#DDC99C",
    card_dark="#161F52", ink="#1B2A63",
    code_base="#EFE3C6", code_gold="#E7B24B", code_teal="#38C0A6",
    code_green="#B7D98A", code_mute="#8E86A8",
    teal="#B4841F", gold="#B4841F", folder="#1E9C7F", file="#3E6E66",
    dot1="#E7B24B", dot2="#38C0A6", dot3="#C9A24E",
    ai_bg="#E7B24B", ai_fg="#161F52",
)

def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

# ---- left terminal card ----
lx, ly, lw, lh = 64, 96, 470, 248
term = f'''
  <rect x="{lx}" y="{ly}" width="{lw}" height="{lh}" rx="16" fill="{P['card_dark']}"/>
  <circle cx="{lx+28}" cy="{ly+30}" r="6" fill="{P['dot1']}"/>
  <circle cx="{lx+48}" cy="{ly+30}" r="6" fill="{P['dot2']}"/>
  <circle cx="{lx+68}" cy="{ly+30}" r="6" fill="{P['dot3']}"/>
  <line x1="{lx}" y1="{ly+54}" x2="{lx+lw}" y2="{ly+54}"
        stroke="#FFFFFF" stroke-opacity="0.10" stroke-width="1.5"/>
  <text x="{lx+32}" y="{ly+104}" font-family="{MONO}" font-size="23">
    <tspan fill="{P['code_base']}">library(</tspan><tspan fill="{P['code_gold']}"
      font-weight="600">peacock</tspan><tspan fill="{P['code_base']}">)</tspan>
  </text>
  <text x="{lx+32}" y="{ly+146}" font-family="{MONO}" font-size="23">
    <tspan fill="{P['code_teal']}" font-weight="600">init_shiny</tspan><tspan
      fill="{P['code_base']}">(</tspan><tspan fill="{P['code_green']}">"my_app"</tspan><tspan
      fill="{P['code_base']}">)</tspan>
  </text>
  <text x="{lx+32}" y="{ly+196}" font-family="{MONO}" font-size="20"
        fill="{P['code_mute']}">#&gt; <tspan fill="{P['dot2']}">&#10003;</tspan> created my_app/</text>
'''

# ---- centre connector ----
ax0, ax1, ay = 556, 686, ly + 108
arrow = f'''
  <text x="{(ax0+ax1)/2:.0f}" y="{ay-26}" font-family="{SANS}" font-size="18"
        fill="{P['ink']}" text-anchor="middle" font-weight="600"
        letter-spacing="0.5">scaffolds</text>
  <line x1="{ax0}" y1="{ay}" x2="{ax1-6}" y2="{ay}" stroke="{P['teal']}"
        stroke-width="5" stroke-linecap="round"/>
  <path d="M {ax1-14},{ay-9} L {ax1+4},{ay} L {ax1-14},{ay+9} Z" fill="{P['teal']}"/>
'''

# ---- right files card ----
rx, ry_, rw, rh = 706, 96, 470, 248
tree = [
    ("ui.R", False, False),
    ("server.R", False, False),
    ("global.R", False, False),
    ("R/", True, False),
    ("www/", True, False),
    ("AGENTS.md", False, True),
]
rows = ""
row_y0 = ry_ + 78
step = 28
last_i = len(tree) - 1
# vertical trunk of the tree
trunk_x = rx + 40
rows += (f'<line x1="{trunk_x}" y1="{row_y0-16}" x2="{trunk_x}" '
         f'y2="{row_y0+step*last_i}" stroke="{P["border"]}" stroke-width="2"/>')
for i, (name, is_dir, hl) in enumerate(tree):
    y = row_y0 + step * i
    # connector tick
    rows += (f'<line x1="{trunk_x}" y1="{y}" x2="{trunk_x+16}" y2="{y}" '
             f'stroke="{P["border"]}" stroke-width="2"/>')
    gx = trunk_x + 24
    if is_dir:
        rows += (f'<rect x="{gx}" y="{y-8}" width="16" height="12" rx="2.5" '
                 f'fill="{P["folder"]}"/>'
                 f'<rect x="{gx}" y="{y-11}" width="8" height="4" rx="1.5" '
                 f'fill="{P["folder"]}"/>')
    else:
        rows += (f'<path d="M {gx+2},{y-10} H {gx+9} L {gx+14},{y-5} V {y+5} '
                 f'H {gx+2} Z" fill="#FFFFFF" stroke="{P["file"]}" '
                 f'stroke-width="1.8" stroke-linejoin="round"/>'
                 f'<path d="M {gx+9},{y-10} V {y-5} H {gx+14}" fill="none" '
                 f'stroke="{P["file"]}" stroke-width="1.5"/>')
    tx = gx + 26
    col = P["gold"] if hl else (P["folder"] if is_dir else P["ink"])
    weight = "700" if (is_dir or hl) else "500"
    rows += (f'<text x="{tx}" y="{y+5}" font-family="{MONO}" font-size="19" '
             f'fill="{col}" font-weight="{weight}">{esc(name)}</text>')
    if hl:
        pill_x = tx + 128
        rows += (f'<rect x="{pill_x}" y="{y-13}" width="34" height="21" rx="10.5" '
                 f'fill="{P["ai_bg"]}"/>'
                 f'<text x="{pill_x+17}" y="{y+2}" font-family="{SANS}" '
                 f'font-size="12.5" font-weight="700" fill="{P["ai_fg"]}" '
                 f'text-anchor="middle">AI</text>')

files = f'''
  <rect x="{rx}" y="{ry_}" width="{rw}" height="{rh}" rx="16" fill="#FFFFFF"
        stroke="{P['border']}" stroke-width="1.5"/>
  <rect x="{rx+28}" y="{ry_+26}" width="18" height="14" rx="2.5" fill="{P['gold']}"/>
  <rect x="{rx+28}" y="{ry_+22}" width="9" height="5" rx="1.5" fill="{P['gold']}"/>
  <text x="{rx+56}" y="{ry_+40}" font-family="{MONO}" font-size="20"
        font-weight="700" fill="{P['ink']}">my_app/</text>
  {rows}
'''

# kolam-style dotted divider under the title
divider = "".join(
    f'<circle cx="{W/2 + i*16:.0f}" cy="80" r="2.2" fill="{P["gold"]}"/>'
    for i in range(-7, 8)
)

svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}">
  <rect x="1" y="1" width="{W-2}" height="{H-2}" rx="26" fill="{P['paper']}"
        stroke="{P['border']}" stroke-width="1.5"/>
  <text x="{W/2:.0f}" y="62" font-family="{SANS}" font-size="26" font-weight="700"
        fill="{P['ink']}" text-anchor="middle">One function, a ready-to-work project</text>
  {divider}
  {term}
  {arrow}
  {files}
  <text x="{W/2:.0f}" y="405" font-family="{SANS}" font-size="16"
        fill="{P['teal']}" text-anchor="middle">Shiny apps · analyses · Quarto sites · Python packages · every one AI-ready</text>
</svg>
'''

out = sys.argv[1] if len(sys.argv) > 1 else "overview.svg"
with open(out, "w", encoding="utf-8") as f:
    f.write(svg)
print("wrote", out)
