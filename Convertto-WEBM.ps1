Function Convertto-WEBM{
    param(
        [parameter(
            Mandatory         = $true,
            ValueFromPipeline = $true)]
        $inputFile,
        $OutputDirectory,
        [switch]$WhatIF,
        $processName = "$env:userprofile\Videos\ffmpeg\bin\ffmpeg.exe"
    )

    $videoExtensions = @('*.avi','*.mkv','*.m4v','*.mp4')
    $outputPath = $OutputDirectory

    if(Test-Path $processName){
        foreach($input in $inputFile){
            $item = if(!($input.fullname)){
                 Get-Item -literalPath $input
            }else{
                $input
            }

            if(Test-Path -LiteralPath $item.FullName){
            
                if(!($OutputDirectory)){
                    $outputPath = $input.DirectoryName
                }

                if(!(Test-Path $outputPath)){
                    New-Item -ItemType Directory -Path $outputPath | Out-Null
                }

                $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($item.FullName) + '.webm';
                $outputFileName = [System.IO.Path]::Combine($outputPath, $outputFileName);
                if(!(Test-Path $outputFileName)){
                   "Converting $($item.fullname)"
                   $processArgs = "-i `"$($item.fullname)`" -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis `"$outputFileName`""
                    if(!($WhatIF)){
                        start-process $processName $processArgs -wait
                    }
                }else{
                    "$outputFileName already exists"
                }
            }else{
                "Unable to find $input"
            }
        }
    }else{
        "$processName not found"
    }
}
