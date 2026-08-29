# CV source

LaTeX source for the academic CV linked from the site (`/cv/`).

- **Entry point:** `main.tex` (imports everything under `sections/`).
- **Published PDF:** `../files/CV_Matias_Fuentes_Becerra.pdf` — this is what the site serves. It is a build artifact, not edited by hand.

## Updating the CV

Edit the `.tex` files and commit. On push, the **Build CV** GitHub Action
(`.github/workflows/build-cv.yml`) compiles `main.tex` with a full TeX Live
image and commits the refreshed PDF to `files/`. Nothing else to do.

## Building locally (optional)

Requires `pdflatex` + `biber` on PATH (MiKTeX or TeX Live). No Perl/latexmk needed.

```powershell
powershell -File cv\build-cv.ps1
```

This compiles `main.tex` and copies the result to
`files/CV_Matias_Fuentes_Becerra.pdf`. Build artifacts in this folder are
git-ignored.
