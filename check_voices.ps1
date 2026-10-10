Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.GetInstalledVoices() | ForEach-Object {
    $info = $_.VoiceInfo
    Write-Host "Name: $($info.Name) | Gender: $($info.Gender) | Culture: $($info.Culture) | Age: $($info.Age)"
}
