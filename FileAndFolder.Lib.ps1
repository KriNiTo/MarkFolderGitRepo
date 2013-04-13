function SetAttributes($fileOrFolder, [System.IO.FileAttributes] $attributesToSet) 
{
    $targetFile=Get-ItemProperty $fileOrFolder;
    $targetFile.Attributes = $targetFile.Attributes -bor $attributesToSet;
}

function RemoveAttributes($fileOrFolder, [System.IO.FileAttributes] $attributesToRemove) 
{
    $targetFile=Get-ItemProperty $fileOrFolder;
    $targetFile.Attributes = $targetFile.Attributes -band (-bnot $attributesToRemove);
}


filter RemoveMetafiles($Destination)
{
    $targetFileName = (Join-Path $Destination $_.Name);
    
    if (Test-Path $targetFileName)
    {
        Remove-Item $targetFileName -Force;
    }
    
    $_;
}


filter CopyMetafilesAndSetAttribute($Destination)
{
    Copy-Item $_.FullName -Destination $Destination;

    $targetFileName = Join-Path $Destination $_.Name;

    SetAttributes $targetFileName "Hidden, System";

    $targetFileName;
}
