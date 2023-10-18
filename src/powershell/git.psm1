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

Set-Alias -Name glg -Value Git-Log
Set-Alias -Name gst -Value Git-Status
Set-Alias -Name ggp -Value Git-Push
Set-Alias -Name ggl -Value Git-Pull
