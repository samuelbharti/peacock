const { Resvg } = require('@resvg/resvg-js');
const fs = require('fs');
// args: <in.svg> <out.png> <width>
const [, , inp, outp, w] = process.argv;
const svg = fs.readFileSync(inp, 'utf8');
const r = new Resvg(svg, {
  fitTo: { mode: 'width', value: parseInt(w || '512', 10) },
  background: 'rgba(0,0,0,0)',
});
fs.writeFileSync(outp, r.render().asPng());
console.log('rendered', outp, w);
