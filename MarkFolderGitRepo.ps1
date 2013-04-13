Param (
    [parameter(Mandatory=$true)]
    $FolderToMark
    )

$ErrorActionPreference = "Stop";
$DebugPreference = "SilentlyContinue" 


################################################################################################################################################

# Include Lib
. (Join-Path (Split-Path $MyInvocation.MyCommand.Path) "FileAndFolder.Lib.ps1");


$DataDirectory = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "Meta"


if (!(Test-Path $FolderToMark))
{
    Write-Error "Verzeichnis '$FolderToMark' nicht gefunden."
    Exit 1;
}


$result = Get-ChildItem $DataDirectory | RemoveMetafiles $FolderToMark | CopyMetafilesAndSetAttribute $FolderToMark;
SetAttributes $FolderToMark "Readonly";

Write-Host "Fertig! Verzeichnis wurde markiert."
Write-Host "- Metadateien wurden kopiert und versteckt.";
Write-Host "- Verzeichnis '$FolderToMark' wurde 'Readonly' gemacht (Damit Iconanzeige funktioniert).";
