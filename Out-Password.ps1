function Out-Password{
    param(
        $Password
    )
    foreach ($char in $Password.GetEnumerator()) {
        if($char -eq " "){
            Write-Host " " -NoNewline
        }elseif($char -cmatch "[a-z]"){
            Write-Host $char -ForegroundColor Green -NoNewline -BackgroundColor Black
        }elseif ($char -match "[A-Z]") {
            Write-Host $char -ForegroundColor Black -NoNewline -BackgroundColor Green
        }elseif ($char -match "[0-9]") {
            Write-Host $char -ForegroundColor Yellow -NoNewline -BackgroundColor Black
        }else {
            Write-Host $char -ForegroundColor Red -NoNewline -BackgroundColor Black
        }
    }
}
