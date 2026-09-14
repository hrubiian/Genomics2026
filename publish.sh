#!/usr/bin/env bash
# Render the Quarto site into docs/ and push it to GitHub Pages.
#
#   ./publish.sh                  -> commits as "Update site"
#   ./publish.sh "week 2 update"  -> uses your own commit message
#
# The live site (https://hrubiian.github.io/Genomics2026/) updates ~1 minute
# after the push finishes.

set -euo pipefail
cd "$(dirname "$0")"

MSG="${1:-Update site}"

# Quarto is not always on PATH outside RStudio; fall back to the bundled copy.
if ! command -v quarto >/dev/null 2>&1; then
  for CANDIDATE in \
    /usr/lib/rstudio/resources/app/bin/quarto/bin \
    /usr/lib/rstudio-server/bin/quarto/bin \
    /usr/share/positron/resources/app/quarto/bin
  do
    if [ -x "$CANDIDATE/quarto" ]; then
      export PATH="$CANDIDATE:$PATH"
      break
    fi
  done
fi

if ! command -v quarto >/dev/null 2>&1; then
  echo "ERROR: quarto not found. Open this project in RStudio and use Build > Render Website," >&2
  echo "       or install Quarto from https://quarto.org/docs/get-started/" >&2
  exit 1
fi

echo "==> Rendering site with $(quarto --version)"
quarto render

# Guarantee the marker exists even if a render ever misses it.
touch docs/.nojekyll

echo "==> Committing"
git add -A
if git diff --cached --quiet; then
  echo "Nothing changed - site is already up to date."
  exit 0
fi
git commit -m "$MSG"

echo "==> Pushing to $(git rev-parse --abbrev-ref HEAD)"
git push

echo
echo "Done. https://hrubiian.github.io/Genomics2026/ will refresh in about a minute."
