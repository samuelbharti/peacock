#!/usr/bin/env python3
"""Wrap the (522x600) hex logo onto a centered 600x600 transparent square,
so favicons come out square with a little padding. Reads a full logo SVG."""
import sys

src = sys.argv[1]
out = sys.argv[2]
text = open(src, encoding="utf-8").read()

head_end = text.index(">") + 1            # end of opening <svg ...>
body = text[head_end:].rstrip()
assert body.endswith("</svg>"), "unexpected SVG tail"
body = body[:-len("</svg>")]

# hex spans x 9.9..512.1 (centre 261); shift +39 to centre in 600
new = (
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 600" '
    'width="600" height="600">'
    '<g transform="translate(39,0)">' + body + "</g></svg>"
)
open(out, "w", encoding="utf-8").write(new)
print("wrote", out)
