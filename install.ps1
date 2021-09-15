# This is a somewhat-hacky script to configure PowerShell and Windows Terminal
# See https://github.com/anishathalye/dotbot for the real script

# Replace the Target portion with the profilePath (relative or absolute) that the new link refers to
$profilePath = "$($HOME)\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$themePath = "$($HOME)\Documents\PowerShell\wezmps.omp.json"
# Replace the Link portion with the profilePath to the symbolic link you want to create
$profileTarget = "$($PSScriptRoot)\dots\powershell\profile.ps1"
$themeTarget = "$($PSScriptRoot)\dots\powershell\wezmps.omp.json"

New-Item -ItemType SymbolicLink -Path $profilePath -Target $profileTarget
New-Item -ItemType SymbolicLink -Path $themePath -Target $themeTarget
