param (
 [string]$Name,
 [string]$Version,
 [string]$Body,
 [string]$PreRelease,
 [string]$ReleaseNotes
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

 if ([string]::IsNullOrEmpty($PreRelease))
 {
  [bool]$PreRelease = $false
 }
 else
 {
  $PreRelease = [System.Convert]::ToBoolean($PreRelease)
 }

 if ([string]::IsNullOrEmpty($ReleaseNotes))
 {
  [bool]$ReleaseNotes = $true
 }
 else
 {
  $ReleaseNotes = [System.Convert]::ToBoolean($ReleaseNotes)
 }

 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "NewTaggedRelease DEBUG"
  Write-Host "FileName     : $($FileName)"
  Write-Host "Name         : $($Name)"
  Write-Host "Version      : $($Version)"
  Write-Host "Repository   : $($repository)"
  Write-Host "RunnerPath   : $($runnerPath)"
  Write-Host "RepoName     : $($repoName)"
  Write-Host "SourcePath   : $($sourcePath)"
  Write-Host "ApiUrl       : $($apiUrl)"
  Write-Host "PreRelease   : $($PreRelease)"
  Write-Host "ReleaseNotes : $($ReleaseNotes)"
  Write-Host "Body         : $($Body)"
 }

 $headers = @{
  Authorization = "token $($token)"
  'Content-Type' = 'application/json'
 }

 $payload = @{
  "tag_name"               = $Version
  "name"                   = $Name
  "generate_release_notes" = $ReleaseNotes
 }

 if (!([string]::IsNullOrEmpty($Body)))
 {
  $payload.Add('body', $Body)
 }

 if ($verbose.ToLower() -eq 'verbose')
 {
  $payload |ConvertTo-Json
 }

 Invoke-RestMethod -Uri $apiUrl -Method Post -Body ($payload |ConvertTo-Json -Compress) -Headers $headers
}
catch
{
 $_.InvocationInfo | Out-String;
 throw $_.Exception.Message;
}