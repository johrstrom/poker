const esbuild = require('esbuild');
const fs = require('fs');
const { exec } = require('child_process');


const assetsDir = 'app/assets'

// could just glob and pass this in the cli, but glob support is shell dependant
jsEntryPoints = filesFromDir(`${assetsDir}/javascripts`);
cssEntryPoints = filesFromDir(`${assetsDir}/stylesheets`);

function filesFromDir(dir) {
  return fs.readdirSync(dir).map((file) => {
    if(fs.lstatSync(`${dir}/${file}`).isDirectory()) {
      return filesFromDir(`${dir}/${file}`);
    } else {
      return `${dir}/${file}`;
    }
  }).flat(); // only works for 1 subdirectory
}

let firing = false;

function rebuildHandler(eventType, fileName) {
  if(firing){
    return;
  } else {
    firing = true;
    railsRebuild();
    setTimeout(() => { firing = false; }, 400);
  }
}

function railsRebuild() {
  exec('bin/recompile_js', (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
    console.log(stdout);
    console.error(stderr);
  });
}

// special watch definition so we can invoke the rails pipeline
if(process.argv.includes('--watch')) {
  jsEntryPoints.concat(cssEntryPoints).forEach(file => {
    fs.watch(file, rebuildHandler);
  });
} else {

  esbuild.build({
    entryPoints: jsEntryPoints,
    bundle: true,
    sourcemap: true,
    format: 'esm',
    outdir: 'app/assets/builds',
    external: ['fs'],
    minify: process.env.RAILS_ENV == 'production' ? true : false,
    watch: false,
  }).catch((e) => console.error(e.message));
}
