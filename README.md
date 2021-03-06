# Download Azure documentation for offline view with PowerShell script
Microsoft hosts Azure documentation on https://docs.microsoft.com/en-us/azure/. Each topic has a rendered PDF file associated which can be downloaded for offline view a shown on picture below (screenshot of https://docs.microsoft.com/en-us/azure/virtual-machines/windows/).

![Screenshot](Docs/Images/WindowsVMDocPDFDL2MP.jpg)

You can download Azure PDF document separately using a download link ('Download PDF'). But sometimes there is a need to download ALL Azure documents to mantain it for offline reference.
I found a nice one-liner from Michael Crump - [Azure Tips and Tricks Part 128 - Download all Azure Documentation for offline viewing](https://www.michaelcrump.net/azure-tips-and-tricks128/)) - but Windows Subsystem for Linux (WSL) is required to run it on Windows.
Kudos to Michael for providing URIs required for download.

I wanted to make it possible to run it in PowerShell and since I have not found any existing published scripts, I decided to make it my first GitHub repo.

The script uses **Invoke-WebRequest** cmdlet and downloads each file separately.

You can download the script and enhance it per your requirements.

## Script syntax
Open PowerShell and select location where you want Azure Documentation to be dowloaded to. Then run:

Get-AzureDocs.ps1 [-folderName <*folderName*>] [-Mode <download | list>] [-Filter <*filter*>]

-*folderName*
Name of the subfolder which documents are downloaded to. Folder can already exist. If it does not exist new folder is created.
Parameter is not mandatory. If you ommit this parameter, script uses its default value which is current date in 'yyyy-MM-dd' format (ie. '2018-08-16').

-*Mode*
Mode of the execution. Choose between listing the available documents or downloading them.
Parameter is optional. If not specified, default value is used which is 'download'.

-*Filter*
Substring of document names which is used to filter documents.
Parameter is optional. If not specified, all documents listed in 'githubUri' location.

## Example

Get-AzureDocs.ps1 -folderName "AzureDocsVM" -Mode "download" -Filter "virtual-machine"

In this example, Azure Document files that include 'virtual-machine' in their name are downloaded into folder 'AzureDocsVM'.