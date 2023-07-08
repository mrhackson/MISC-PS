function Get-GitRepo{
    param(
        $URI,
        [switch]$ChangeDirectory
    )
    $OriganalDirectory = Get-Location
    Set-Location "$env:userprofile\Documents\Code"
    $repoName = [System.IO.Path]::GetFileNameWithoutExtension($URI)
    if(!(Test-Path $repoName)){
        git clone $URI
    }
    if($ChangeDirectory){
        cd $repoName
    }else{
        cd $OriganalDirectory
    }
}
