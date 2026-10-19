# Uses automatic $args to preserve '--' pass-through tokens and avoid CommonParameters hijacking

$OutputEncoding = [System.Text.Encoding]::UTF8
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
} catch {
    # Ignore IOException when running in headless/redirected agent pipes without a console handle
}

$oldPythonUtf8 = $env:PYTHONUTF8
$oldPythonIoEncoding = $env:PYTHONIOENCODING
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"

$RootDir = (Resolve-Path "$PSScriptRoot\..").Path
$VenvPython = Join-Path $RootDir ".venv\Scripts\python.exe"
$ActiveVenvPython = if ($env:VIRTUAL_ENV) { Join-Path $env:VIRTUAL_ENV "Scripts\python.exe" } else { $null }
$oldPythonPath = $env:PYTHONPATH
$env:PYTHONPATH = if ($oldPythonPath) { "$RootDir;$oldPythonPath" } else { "$RootDir" }

$exitCode = 0
try {
    if (Test-Path $VenvPython) {
        & $VenvPython -m um @args
    } elseif ($ActiveVenvPython -and (Test-Path $ActiveVenvPython)) {
        & $ActiveVenvPython -m um @args
    } elseif (Get-Command py -ErrorAction SilentlyContinue) {
        & py -m um @args
    } else {
        & python -m um @args
    }
    $exitCode = $LASTEXITCODE
} finally {
    $env:PYTHONPATH = $oldPythonPath
    $env:PYTHONUTF8 = $oldPythonUtf8
    $env:PYTHONIOENCODING = $oldPythonIoEncoding
}
exit $exitCode
