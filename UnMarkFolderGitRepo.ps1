Param (
    [parameter(Mandatory=$true)]
    $FolderToUnMark
    )

$ErrorActionPreference = "Stop";
$DebugPreference = "SilentlyContinue" 

################################################################################################################################################

# Include Lib
. (Join-Path (Split-Path $MyInvocation.MyCommand.Path) "FileAndFolder.Lib.ps1");

$DataDirectory = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "Meta"


if (!(Test-Path $FolderToUnMark))
{
    Write-Error "Verzeichnis '$FolderToUnMark' nicht gefunden."
    Exit 1;
}


$result = Get-ChildItem $DataDirectory | RemoveMetafiles $FolderToUnMark
RemoveAttributes $FolderToUnMark "Readonly";

Write-Host "Fertig! Verzeichnis erscheint wieder als Standard-Ordner. "
Write-Host "- Metadateien wurden entfernt.";
Write-Host "- Verzeichnis-Attribut 'Readonly' wurde von: '$FolderToUnMark' entfernt.";


