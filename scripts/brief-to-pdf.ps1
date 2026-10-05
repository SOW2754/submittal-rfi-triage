param(
  [Parameter(Mandatory = $true)][string]$Html,
  [string]$Pdf
)

$ErrorActionPreference = 'Stop'

$Html = (Resolve-Path -LiteralPath $Html).Path
if (-not $Pdf) { $Pdf = [System.IO.Path]::ChangeExtension($Html, '.pdf') }

$outDir = Split-Path -Parent $Pdf
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$edge = @(
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe' -ErrorAction SilentlyContinue).'(default)'
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1

if (-not $edge) { throw 'Microsoft Edge not found. Cannot render PDF.' }

if (Test-Path -LiteralPath $Pdf) { Remove-Item -LiteralPath $Pdf -Force }

$uri = (New-Object System.Uri $Html).AbsoluteUri
& $edge --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="$Pdf" $uri | Out-Null

$deadline = (Get-Date).AddSeconds(30)
while (-not (Test-Path -LiteralPath $Pdf) -and (Get-Date) -lt $deadline) { Start-Sleep -Milliseconds 300 }
if (-not (Test-Path -LiteralPath $Pdf)) { throw "Edge did not produce $Pdf" }

# Edge can still be flushing bytes when the file first appears.
$last = -1
while ($true) {
  $size = (Get-Item -LiteralPath $Pdf).Length
  if ($size -gt 0 -and $size -eq $last) { break }
  $last = $size
  Start-Sleep -Milliseconds 400
}

$enc = [System.Text.Encoding]::GetEncoding(28591)
$raw = $enc.GetString([System.IO.File]::ReadAllBytes($Pdf))
$pages = ([regex]::Matches($raw, '/Type\s*/Page[^s]')).Count

Write-Output "PDF: $Pdf"
Write-Output "PAGES: $pages (target 1)"
if ($pages -gt 1) {
  Write-Output "Over target. Fine if the item count genuinely needs the room; do a tightening pass first."
}
