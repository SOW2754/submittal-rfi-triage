<#
  Extract text from a PDF.

  Prefers poppler's pdftotext -layout, which preserves the column structure Procore and
  Forma RFI exports rely on, and reads ASCII diagrams correctly. Falls back to a pure
  .NET extractor when poppler isn't installed, so this still runs on a machine that
  hasn't had anything added to it.

  Usage:
    powershell -File pdf-to-text.ps1 -Pdf "<in.pdf>" -Out "<out.txt>"
    powershell -File pdf-to-text.ps1 -Pdf "<in.pdf>"          # prints to stdout
#>
param(
  [Parameter(Mandatory = $true)][string]$Pdf,
  [string]$Out
)
$ErrorActionPreference = 'Stop'
$Pdf = (Resolve-Path -LiteralPath $Pdf).Path

function Find-PdfToText {
  $onPath = (Get-Command pdftotext.exe -ErrorAction SilentlyContinue).Source
  if ($onPath) { return $onPath }
  # winget installs to a versioned folder and only updates PATH for new shells
  $hit = Get-ChildItem "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Recurse -Filter pdftotext.exe `
           -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($hit) { return $hit.FullName }
  return $null
}

$tool = Find-PdfToText
if ($tool) {
  $target = if ($Out) { $Out } else { [System.IO.Path]::GetTempFileName() }
  & $tool -layout $Pdf $target 2>$null
  if (-not (Test-Path -LiteralPath $target)) { throw "pdftotext produced no output for $Pdf" }
  $text = [System.IO.File]::ReadAllText($target)
  Write-Output "ENGINE: pdftotext -layout"
  Write-Output "CHARS: $($text.Length)"
  if ($text.Trim().Length -lt 200) {
    Write-Output "NEARLY EMPTY - this PDF is probably a scan with no text layer."
    Write-Output "Render it instead: pdftoppm -png -r 150 <pdf> <prefix>, then read the images."
  }
  if ($Out) { Write-Output "WROTE: $Out" }
  else { Remove-Item $target -Force; Write-Output "----"; Write-Output $text }
  return
}

Write-Output "ENGINE: .NET fallback (poppler not found; install with: winget install oschwartz10612.Poppler)"

$enc   = [System.Text.Encoding]::GetEncoding(28591)
$bytes = [System.IO.File]::ReadAllBytes($Pdf)
$raw   = $enc.GetString($bytes)

function Expand-Flate([byte[]]$data) {
  $ms = New-Object System.IO.MemoryStream(,$data)
  $ms.ReadByte() | Out-Null; $ms.ReadByte() | Out-Null   # zlib header
  $ds = New-Object System.IO.Compression.DeflateStream($ms, [System.IO.Compression.CompressionMode]::Decompress)
  $o  = New-Object System.IO.MemoryStream
  try { $ds.CopyTo($o) } catch {}
  $ds.Dispose(); $ms.Dispose()
  return $o.ToArray()
}

function Convert-PdfString([string]$s) {
  $sb = New-Object System.Text.StringBuilder
  for ($i = 0; $i -lt $s.Length; $i++) {
    $c = $s[$i]
    if ($c -eq '\') {
      $i++
      if ($i -ge $s.Length) { break }
      $n = $s[$i]
      switch ($n) {
        'n' { [void]$sb.Append("`n") }
        'r' { [void]$sb.Append("`r") }
        't' { [void]$sb.Append("`t") }
        '(' { [void]$sb.Append('(') }
        ')' { [void]$sb.Append(')') }
        '\' { [void]$sb.Append('\') }
        default {
          if ($n -match '[0-7]') {
            $oct = "$n"
            while ($oct.Length -lt 3 -and ($i + 1) -lt $s.Length -and $s[$i+1] -match '[0-7]') {
              $i++; $oct += $s[$i]
            }
            [void]$sb.Append([char][Convert]::ToInt32($oct, 8))
          } else { [void]$sb.Append($n) }
        }
      }
    } else { [void]$sb.Append($c) }
  }
  return $sb.ToString()
}

$COMMON = @('the','and','shall','with','that','this','for','are','not','from','have',
            'power','provided','requirement','equipment','question','response','please',
            'drawing','sheet','detail','panel','circuit','voltage','system','install')

function Score-English([string]$t) {
  $lower = $t.ToLower(); $n = 0
  foreach ($w in $COMMON) { $n += ([regex]::Matches($lower, "\b$w\b")).Count }
  return $n
}

# A subset font can shift every character code by a constant, so "Power" extracts as
# "3RZHU". Undo it by trying offsets and keeping whichever yields the most real words.
function Repair-Offset([string]$t) {
  $best = $t; $bestScore = Score-English $t
  foreach ($off in -60..60) {
    if ($off -eq 0) { continue }
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $t.ToCharArray()) {
      $code = [int]$ch + $off
      if ($code -ge 32 -and $code -le 126) { [void]$sb.Append([char]$code) } else { [void]$sb.Append($ch) }
    }
    $cand = $sb.ToString(); $s = Score-English $cand
    if ($s -gt $bestScore) { $bestScore = $s; $best = $cand }
  }
  return $best
}

function Test-SpacedRun([string]$line) {
  $tokens = $line.Trim() -split '\s+' | Where-Object { $_ -ne '' }
  if ($tokens.Count -lt 6) { return $false }
  (($tokens | Where-Object { $_.Length -eq 1 }).Count / $tokens.Count) -gt 0.6
}

function Repair-SpacedRun([string]$line) {
  $words = [regex]::Split($line.Trim(), '\s{2,}')
  Repair-Offset ((($words | ForEach-Object { ($_ -split '\s+') -join '' }) -join ' '))
}

$acc = New-Object System.Text.StringBuilder
$pos = 0; $streamCount = 0
while ($true) {
  $s = $raw.IndexOf('stream', $pos)
  if ($s -lt 0) { break }
  $dataStart = $s + 6
  if ($raw[$dataStart] -eq "`r") { $dataStart++ }
  if ($raw[$dataStart] -eq "`n") { $dataStart++ }
  $e = $raw.IndexOf('endstream', $dataStart)
  if ($e -lt 0) { break }
  $pos = $e + 9
  $len = $e - $dataStart
  if ($len -le 0) { continue }
  $chunk = New-Object byte[] $len
  [Array]::Copy($bytes, $dataStart, $chunk, 0, $len)
  $plain = Expand-Flate $chunk
  if ($plain.Length -eq 0) { continue }
  $text = $enc.GetString($plain)
  if ($text -notmatch 'BT|Tj|TJ') { continue }
  $streamCount++
  foreach ($m in [regex]::Matches($text, '\((?:\\.|[^\\()])*\)\s*Tj|\[(?:[^\[\]\\]|\\.)*\]\s*TJ|T\*|Td|TD|ET')) {
    $v = $m.Value
    if ($v -match '^(T\*|Td|TD|ET)$') { [void]$acc.Append("`n"); continue }
    foreach ($sm in [regex]::Matches($v, '\((?:\\.|[^\\()])*\)')) {
      [void]$acc.Append((Convert-PdfString $sm.Value.Substring(1, $sm.Value.Length - 2)))
    }
  }
  [void]$acc.Append("`n")
}

$fixed = 0
$repaired = foreach ($line in ($acc.ToString() -split "`r?`n")) {
  if (Test-SpacedRun $line) { $fixed++; Repair-SpacedRun $line } else { $line }
}
$result = (($repaired -join "`n") -replace '[ \t]+', ' ' -replace '(\r?\n\s*){3,}', "`n`n").Trim()

$printable = ([regex]::Matches($result, '[A-Za-z0-9 .,:/()\-]')).Count
$ratio = if ($result.Length -gt 0) { [math]::Round(100 * $printable / $result.Length) } else { 0 }
Write-Output "STREAMS WITH TEXT: $streamCount"
Write-Output "CHARS: $($result.Length)"
Write-Output "LEGIBLE: $ratio%"
if ($fixed -gt 0) { Write-Output "REPAIRED: $fixed offset-encoded line(s)" }
if ($ratio -lt 70) { Write-Output "LOW LEGIBILITY - likely a scan, or CID fonts this can't map." }

if ($Out) {
  [System.IO.File]::WriteAllText($Out, $result, [System.Text.Encoding]::UTF8)
  Write-Output "WROTE: $Out"
} else { Write-Output "----"; Write-Output $result }
