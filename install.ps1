# See https://github.com/anishathalye/dotbot for the real script

$ErrorActionPreference = "Stop"

# Replace the Target portion with the path (relative or absolute) that the new link refers to
$path = $HOME + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
# Replace the Link portion with the path to the symbolic link you want to create
$target = $PSScriptRoot + "\dots\powershell\profile.ps1"

New-Item -ItemType SymbolicLink -Path $path -Target $target
