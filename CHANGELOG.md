# Changelog

All changes to this project should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [[0.0.2.14]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.14) - 2024-01-17

BUGFIX: Invalid json string, trailing quotes after boolean's

---

## [[0.0.2.13]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.13) - 2024-01-17

BUGFIX: Removed the extraneous hashtable update as we're no longer using hashtables.

---

## [[0.0.2.12]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.12) - 2024-01-17

This release fixes the boolean to string issue. PowerShell is casting booleans to strings during the ConvertTo-Json cmdlet, this is causing the GitHub API to throw a 422 error. There were several iterations in an attempt to programatically fix this, but the solution was to simply write the JSON string out manually.

What's Changed

1. Added code to manually construct the json string

---

## [[0.0.2.3]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.3) - 2024-01-17

This release adds some features, you can now set the body of the release, as well as whether or not it's a pre-release and if you want the auto-generated release notes to be added.

What's Changed

1. Added a Body parameter
2. Added a PreRelease parameter, defaults to false
3. Added a ReleaseNotes parameter, defaults to true

---

## [[0.0.2.1]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.1) - 2024-01-17

This release adds some features, you can now set the body of the release, as well as whether or not it's a pre-release and if you want the auto-generated release notes to be added.

What's Changed

1. Added a Body parameter
2. Added a PreRelease parameter, defaults to false
3. Added a ReleaseNotes parameter, defaults to true

---

## [[0.0.2.0]](https://github.com/mod-posh/NewTaggedRelease/releases/tag/v0.0.2.0) - 2024-01-17

This is a breaking change. This release moves from Python to PowerShell for ease of troubleshooting on my end. This release has removed the calculation of the version from the project file. This can be passed either by another action, or script, or manually if need be.

What's Changed

1. Changed the Action to PowerShell
2. Removed Version calculation
3. Added Name and Version inputs
4. Added Verbose for more detailed logging

---
