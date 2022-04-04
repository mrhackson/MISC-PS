Function Get-FFProbeInfo{
# Requires ffprobe.exe 
# https://ffmpeg.org/ffprobe.html
    param(
        $fileName,
        $ffprobePath = "$env:userprofile\Videos\ffmpeg\bin\ffprobe.exe"
    )
    & $ffprobePath -v error -show_format -show_streams -print_format json $fileName | ConvertFrom-Json | select -ExpandProperty streams | Add-Member -MemberType NoteProperty -Name "FileName" -Value $fileName -PassThru
}
