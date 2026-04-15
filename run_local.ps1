$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

if (-not $env:PLAY_DB_PATH) {
    $env:PLAY_DB_PATH = Join-Path $env:TEMP "cards_azure_play_sessions.db"
}

if (-not (Test-Path ".venv")) {
    py -3.12 -m venv .venv --without-pip
}

$venvPython = ".\.venv\Scripts\python.exe"
$venvPip = ".\.venv\Scripts\pip.exe"

if ((Test-Path $venvPython) -and (Test-Path $venvPip)) {
    & $venvPip install -r requirements.txt
    & $venvPython app.py
} else {
    Write-Host "Venv pip is unavailable; using Python 3.12 user packages for local run."
    py -3.12 -m pip install --user -r requirements.txt
    py -3.12 app.py
}
