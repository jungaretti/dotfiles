function Git-Status { git status }

function Git-Log { git log --stat }

function Git-Push {
    $branch = "$(git branch --show-current)"
    git push origin $branch
}

function Git-Pull {
    $branch = "$(git branch --show-current)"
    git pull origin $branch
}

function Git-AddPick {
    git add -p .
}

Set-Alias -Name glg -Value Git-Log
Set-Alias -Name gst -Value Git-Status
Set-Alias -Name ggp -Value Git-Push
Set-Alias -Name ggl -Value Git-Pull
Set-Alias -Name gap -Value Git-AddPick
