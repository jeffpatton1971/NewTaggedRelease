param (
 [string]$Name,
 [string]$Version
)
try
{
 $ErrorActionPreference = 'Stop';
 $Error.Clear();

 $repository = $env:GITHUB_REPOSITORY
 $runnerPath = $env:GITHUB_WORKSPACE
 $repoName = $repository.Split('/')[1]
 $sourcePath = Join-Path -Path $runnerPath -ChildPath $repoName
 $token = $env:GITHUB_TOKEN
 $verbose = $env:VERBOSE

 $baseUri = 'https://api.github.com/repos'
 $apiUrl = "$($baseUri)/$($repository)/releases"

 if ([string]::IsNullOrEmpty($Name))
 {
  $Name = $Version
 }

 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "NewTaggedRelease DEBUG"
  Write-Host "FileName   : $($FileName)"
  Write-Host "Name       : $($Name)"
  Write-Host "Version    : $($Version)"
  Write-Host "Repository : $($repository)"
  Write-Host "RunnerPath : $($runnerPath)"
  Write-Host "RepoName   : $($repoName)"
  Write-Host "SourcePath : $($sourcePath)"
  Write-Host "ApiUrl     : $($apiUrl)"
 }

 $headers = @{
  Authorization = "token $($token)"
 }

 $body = @{
  "tag_name" = $Version
  "name"     = $Name
 } | ConvertTo-Json

 Invoke-RestMethod -Uri $apiUrl -Method Post -Body $body -Headers $headers
}
catch
{
 $_.InvocationInfo | Out-String;
 throw $_.Exception.Message;
}