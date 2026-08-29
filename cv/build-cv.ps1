# Compiles the CV and refreshes the copy the site serves.
# Usage:  powershell -File cv\build-cv.ps1     (run from anywhere)
# Needs pdflatex + biber on PATH (MiKTeX or TeX Live). No Perl/latexmk required.
$ErrorActionPreference = 'Stop'

$cvDir   = $PSScriptRoot
$outPdf  = Join-Path $cvDir 'main.pdf'
$sitePdf = Join-Path $cvDir '..\files\CV_Matias_Fuentes_Becerra.pdf'

Push-Location $cvDir
try {
    & pdflatex -interaction=nonstopmode -halt-on-error main.tex
    & biber main
    & pdflatex -interaction=nonstopmode -halt-on-error main.tex
    & pdflatex -interaction=nonstopmode -halt-on-error main.tex
    if (-not (Test-Path $outPdf)) { throw "Compile finished but $outPdf was not produced." }

    Copy-Item $outPdf $sitePdf -Force
    Write-Host "Updated $([System.IO.Path]::GetFullPath($sitePdf))"

    # Tidy build artifacts (they are git-ignored anyway)
    Get-ChildItem $cvDir -Include '*.aux','*.bbl','*.bcf','*.blg','*.fdb_latexmk','*.fls','*.log','*.out','*.run.xml','*.synctex.gz','main.pdf' -Recurse |
        Remove-Item -Force -ErrorAction SilentlyContinue
}
finally {
    Pop-Location
}
