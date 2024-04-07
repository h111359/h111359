Connect-AzAccount
Get-AzLocation | select Location

$subscriptionid = 'dc2cd780-3b19-49a2-b28b-c4af023fd1e7'
$resourceGroup = "rg-web"
$location = "northeurope"
$StorageAccountName = "saweb"
$StorageAccountType = "Standard_LRS"
$IndexDocument = "index.html"
$ErrorDocument = "error.html"
$context = Get-AzSubscription -SubscriptionId $

Set-AzContext $context
$RepoPath = "C:\\Hristo\\Repositories\\GitHub\\h111359\\hmhristov-web\\index.html"
$BlobName = $IndexDocument
$customDomainName = "www.hmhristov.com"

New-AzResourceGroup -Name $resourceGroup -Location $location

New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name $StorageAccountName `
  -Location $location `
  -SkuName $StorageAccountType `
  -Kind StorageV2
  
$StorageAccountResourceId = (Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $StorageAccountName).Id  
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroup -AccountName $StorageAccountName
$SActx = $storageAccount.Context

Enable-AzStorageStaticWebsite -Context $SActx -IndexDocument $IndexDocument -ErrorDocument404Path $ErrorDocument

# upload a file
set-AzStorageblobcontent -File $RepoPath `
-Container `$web `
-Blob $BlobName `
-Context $SActx `
-Properties @{ ContentType = "text/html; charset=utf-8";}

Set-AzStorageAccount -ResourceGroupName $resourceGroup -Name $StorageAccountName -CustomDomainName $customDomainName -UseSubDomain $false

Write-Output $storageAccount.PrimaryEndpoints.Web

Remove-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $resourceGroup
