<#
.SYNOPSIS
This script allows you to download Azure PDF documents to PC for offline use. There is approximately 1GB of Azure PDF documentation.
Script can run for a while depending on your internet connection speed. 
.DESCRIPTION
Use this script with PowerShell Scripting host.
.PARAMETER Folder
The name of the folder which script should download Azure documents into.
Parameter is optional. If not specified, default value (the date) is used which is in the 'yyyy-mm-yy' format.
New folder is created in current location.
#>

Param( 
    [Parameter(Mandatory=$false)] 
    [String] 
    $folderName = (Get-Date -Format yyyy-MM-dd).ToString()
) 

# Initialize variables
$githubUri = "https://api.github.com/repositories/72685026/contents/articles"
$azureUri = "https://docs.microsoft.com/pdfstore/en-us/Azure.azure-documents/live/"

# Create a new directory for downloaded files in form of current date if it does not already exist.
if (!(Test-Path -Path ".\$folderName" )) {
    New-Item -ItemType "directory" -Name $folderName
}
Else {
    Write-Host "Target folder already exists. Azure Document files will be downloaded into existing folder." -ForegroundColor Yellow
}

# Set security protocol to support TLS 1.2 as PowerShell defaults to TLS 1.0
$securityProtocol = "tls12, tls11, tls"
[Net.ServicePointManager]::SecurityProtocol = $securityProtocol

# Acquire a list of Azure Document files and put it into an object.
$AzureDocFiles = ConvertFrom-Json(Invoke-WebRequest $githubUri)
$AzureDocFiles = $AzureDocFiles | Select-Object type,name | Where-Object {$_.type -eq "dir"}

foreach($AzureDocFile in $AzureDocFiles) {
    $AzureDocFileName = $AzureDocFile.name + ".pdf"
    $AzureDocFileOutPath = ".\$folderName\$AzureDocFileName"
    $AzureDocFileUri = $azureUri + $AzureDocFileName
    $AzureDocFileSize = 

    Write-Host "Downloading file $AzureDocFileName" -ForegroundColor Green

    Try {
            Invoke-WebRequest -Uri $AzureDocFileUri -OutFile $AzureDocFileOutPath
        }
        Catch {
            $_.Exception.Message
        }
    }

Write-Host "Finished downloading." -ForegroundColor Green
Write-Host "Files are downloaded to folder " + $folderName -ForegroundColor White