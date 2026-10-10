$pyFile = "C:\Users\ELCOT\.gemini\antigravity-ide\scratch\indian_equity_multiagent_engine\build_index_html.py"
$target = "C:\Users\ELCOT\.gemini\antigravity-ide\scratch\indian_equity_multiagent_engine\index.html"

$raw = [System.IO.File]::ReadAllText($pyFile, [System.Text.Encoding]::UTF8)
$start = $raw.IndexOf("<!DOCTYPE html>")
$end = $raw.LastIndexOf("</html>") + 7
$html = $raw.Substring($start, $end - $start)

[System.IO.File]::WriteAllText($target, $html, [System.Text.Encoding]::UTF8)
Write-Host "Success! Wrote index.html with size: $($html.Length) chars."
