#!/usr/bin/env python3
"""Pack PNG files into a multi-size .ico (PNG-compressed entries).
Usage: python pack_ico.py out.ico a.png b.png ..."""
import struct, sys

out = sys.argv[1]
pngs = sys.argv[2:]
imgs = []
for p in pngs:
    data = open(p, "rb").read()
    # PNG IHDR width/height at bytes 16..24
    w = struct.unpack(">I", data[16:20])[0]
    h = struct.unpack(">I", data[20:24])[0]
    imgs.append((w, h, data))

n = len(imgs)
header = struct.pack("<HHH", 0, 1, n)      # reserved, type=icon, count
offset = 6 + 16 * n
entries = b""
blob = b""
for w, h, data in imgs:
    bw = 0 if w >= 256 else w
    bh = 0 if h >= 256 else h
    entries += struct.pack("<BBBBHHII", bw, bh, 0, 0, 1, 32, len(data), offset)
    blob += data
    offset += len(data)

open(out, "wb").write(header + entries + blob)
print("wrote", out, "with sizes", [i[0] for i in imgs])
