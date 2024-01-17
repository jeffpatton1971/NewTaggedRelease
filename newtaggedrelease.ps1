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
  $PreRelease = $false
 }
 else
 {
  $PreRelease = [System.Convert]::ToBoolean($PreRelease)
 }

 if ([string]::IsNullOrEmpty($ReleaseNotes))
 {
  $ReleaseNotes = $true
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
 }

 $payload = @{
  "tag_name"               = $Version
  "name"                   = $Name
  "prerelease"             = $PreRelease
  "generate_release_notes" = $ReleaseNotes
 }

 if (!([string]::IsNullOrEmpty($Body)))
 {
  $payload.Add('body', $Body)
 }

 Invoke-RestMethod -Uri $apiUrl -Method Post -Body $payload -Headers $headers
}
catch
{
 $_.InvocationInfo | Out-String;
 throw $_.Exception.Message;
}