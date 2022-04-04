Function Test-VideoChromeCompatability{
#Test to see if a video file is compatible with Google Chrome
#Requires function Get-FFProbeInfo which itself requires ffprobe.exe
    param(
        $fileName,
        [switch]$ShowWarnings
    )
    $ChromeCompatabileAudioCodecs = @('aac','mp3','vorbis')
    $ChromeCompatabileVideoCodecs = @('h264','vp9','vp8','mjpeg')

    $results = Get-FFProbeInfo $fileName
    $audioResults = $results | Where-Object {$_.codec_type -eq "audio"}
    $videoResults = $results | Where-Object {$_.codec_type -eq "video"}

    $audioCodecs = @($audioResults.codec_name)
    $videoCodecs = @($videoResults.codec_name)

    $audioCompatbile = $false
    foreach($audioCodec in $audioCodecs){
        if($audioCodec -in $ChromeCompatabileAudioCodecs){
            $audioCompatbile = $true
        }
    }

    $videoCompatbile = $false
    foreach($videoCodec in $videoCodecs){
        if($videoCodec -in $ChromeCompatabileVideoCodecs){
            $videoCompatbile = $true
        }
    }

    
    if($audioCompatbile -and $videoCompatbile){
        return $true
    }elseif($audioCompatbile){
        if($ShowWarnings){
            Write-Warning "Video incompatible $fileName"
        }
        $videoCodecs
    }elseif($videoCompatbile){
        if($ShowWarnings){
            Write-Warning "Audio incompatible $fileName"
        }
    }else{
        if($ShowWarnings){
            Write-Warning "Video & Audio incompatible $fileName"
        }
    }
    return $false
    
}