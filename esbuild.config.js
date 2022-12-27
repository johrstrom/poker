const esbuild = require('esbuild');
const fs = require('fs');


// could just glob and pass this in the cli, but glob support is shell dependant
entryPoints = filesFromDir('app/assets/javascripts');

function filesFromDir(dir) {
  return fs.readdirSync(dir).map((file) => {
    if(fs.lstatSync(`${dir}/${file}`).isDirectory()) {
      return filesFromDir(`${dir}/${file}`);
    } else {
      return `${dir}/${file}`;
    }
  }).flat(); // only works for 1 subdirectory
}

esbuild.build({
  entryPoints: entryPoints,
  bundle: true,
  sourcemap: true,
  format: 'esm',
  outdir: 'app/assets/builds',
  external: ['fs'],
  minify: process.env.RAILS_ENV == 'production' ? true : false,
  watch: process.argv.includes('--watch'),
}).catch((e) => console.error(e.message));

