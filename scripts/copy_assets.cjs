// scripts/copy-nd-assets.cjs
const fs = require("fs");
const path = require("path");

const pkgAssets = path.join(
  __dirname,
  "..",
  "node_modules",
  "@endikau",
  "nd_assets",
  "dist"
);

// Where you want them in your Hugo site:
const hugoAssets = path.join(__dirname, "..", "hugo", "assets", "nd_assets");

// Clean old copy
fs.rmSync(hugoAssets, { recursive: true, force: true });
fs.mkdirSync(hugoAssets, { recursive: true });

function copyDir(from, to) {
  for (const entry of fs.readdirSync(from, { withFileTypes: true })) {
    const srcPath = path.join(from, entry.name);
    const destPath = path.join(to, entry.name);

    if (entry.isDirectory()) {
      fs.mkdirSync(destPath, { recursive: true });
      copyDir(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

copyDir(pkgAssets, hugoAssets);
