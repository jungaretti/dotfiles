function gst {
    git status
}

function glg {
    git log --stat
}

function ggl {
    $branch = "$(git branch --show-current)"
    git pull origin $branch
}

function ggp {
    $branch = "$(git branch --show-current)"
    git push origin $branch
}

function ggpnp {
    ggl; if ($?) { ggp }
}
