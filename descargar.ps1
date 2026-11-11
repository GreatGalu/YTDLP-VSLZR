Clear-Host

$banner = @"
===================================================================================
 ▄████    ██ ███   ▓ ▄▄██   ▄▄▄       ▄▄▄█▄███▓  ▄████    ▄▄▄        ██▓      █    ██ 
 ██▒ ▀█▒ ▓██ ▒ ██▓ ▓█   ▀  ▒▄▀ █▄     ▓  ██▒ ▓▒  ██▒ ▀█▒ ▒▄▀ █▄     ▓██▒      ██  ▓▀█▒
▒ ▄░▄▄▄░ ▓██ ░▄█ ▒ ▒█ █    ▒██  ▀█▄   ▒ ▓██░ ▒░ ▒ ▄░▄▄▄░ ▒██  ▀█▄   ▒██░     ▓██  ▒██░
░▓█  ██▓ ▒▄█▀▀█▄   ▒▓█  ▄  ░▄█▄▄▄▄██  ░ ▓▄█▓ ░  ░▓█  ██▓ ░▄█▄▄▄▄██  ▒█ ░     ▓▓█  ░██░
░▒▒███▀▒ ░██▓ ▒██▒ ░▒████▒  ▓█   ▓██▒   ▒██▒ ░  ░▒▒███▀▒  ▓█   ▓██▒ ░▄█████▒ ▒▒███▄▀▓ 
 ░▒   ▒  ░ ▒▓ ░▒▓░ ░░ ▒░ ░  ▒▒   ▓▒█░   ▒ ░░     ░▒   ▒   ▒▒   ▓▒█░ ░ ▒░▓  ░ ░▒▓▒ ▒ ▒ 
  ░   ░    ░▒ ░ ▒░  ░ ░  ░   ▒   ▒▒ ░     ░       ░   ░    ▒   ▒▒ ░ ░ ░ ▒  ░ ░░▒░ ░ ░ 
░ ░   ░    ░░   ░     ░      ░   ▒      ░       ░ ░   ░    ░   ▒      ░ ░     ░░░ ░ ░ 
      ░     ░         ░  ░       ░  ░                 ░        ░  ░     ░  ░    ░     
===================================================================================
"@

Write-Host $banner -ForegroundColor Green
Write-Host " Hello Galu, Ready to download!?" -ForegroundColor White
Write-Host " Author: @GreatGalu" -ForegroundColor White
Write-Host ""

$url = Read-Host "-> Paste the video or playlist URL"

if ([string]::IsNullOrWhiteSpace($url)) {
    Write-Host "[!] You didn't enter any URLs. Cancelling..." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "Select the download type:" -ForegroundColor Yellow
Write-Host " [1] Individual song - FLAC"
Write-Host " [2] Individual song - MP3"
Write-Host " [3] Individual video - MP4"
Write-Host " [4] Complete playlist - FLAC (Creates ordered folder)"
Write-Host " [5] Complete playlist - MP3 (Creates ordered folder)"
Write-Host ""

$option = Read-Host "Enter an option (1-5)"

Write-Host ""
Write-Host "Starting download..." -ForegroundColor Cyan
Write-Host ""

switch ($option) {
    "1" {
        yt-dlp --cookies-from-browser firefox --no-playlist -o "%(title)s.%(ext)s" -x --audio-format flac --embed-thumbnail --add-metadata $url
    }
    "2" {
        yt-dlp --cookies-from-browser firefox --no-playlist -o "%(title)s.%(ext)s" -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata $url
    }
    "3" {
        yt-dlp --cookies-from-browser firefox --no-playlist -o "%(title)s.%(ext)s" -f "bv*+ba/b" --merge-output-format mp4 --embed-thumbnail --add-metadata $url
    }
    "4" {
        # Descarga la playlist entera en FLAC creando carpeta ordenada
        yt-dlp --cookies-from-browser firefox -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -x --audio-format flac --embed-thumbnail --add-metadata $url
    }
    "5" {
        # Descarga la playlist entera en MP3 creando carpeta ordenada
        yt-dlp --cookies-from-browser firefox -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata $url
    }
    default {
        Write-Host "[!] Invalid option." -ForegroundColor Red
        exit
    }
}

Write-Host ""
Write-Host "===================================================" -ForegroundColor Green
Write-Host "       ¡Download completed successfully!           " -ForegroundColor Green
Write-Host "   Do you want to perform another download? (Y/N)  " -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green
