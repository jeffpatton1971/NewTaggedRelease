# New Tagged Release

## Overview

This reusable GitHub Actions workflow automates the process of creating a new release for a .NET project based on the version specified in the `.csproj` file. It checks out the repository, sets up Python, installs necessary dependencies (`gitpython` and `requests`), and then runs a Python script to perform the release process.

### Inputs

- `source_path`: The relative path to the subfolder containing the `.csproj` file.
- `project_name`: The name of the project, which should match the name used in the `.csproj` file.

## Using the Workflow

To use this workflow in your project, you can call it from another workflow file in your repository. Here's an example of how to do it:

```yaml
jobs:
  call-release-workflow:
    uses: jeffpatton1971/NewTaggedrelease@v0.0.1.0
    with:
      source_path: 'path/to/subfolder'
      project_name: 'YourProjectName'
```

## Python Script: `newtaggedrelease.py`

The `newtaggedrelease.py` script automates the process of creating a new Git tag and GitHub release for a .NET project. It reads the version from the `.csproj` file, commits any changes, tags the commit, pushes the tag to the repository, and creates a new release on GitHub.

### Usage

The script is designed to be run with two arguments:

- `source_path`: Path to the folder containing the `.csproj` file.
- `project_name`: Name of the .NET project.

### Execution

The script is executed as part of the GitHub Actions workflow and requires the `GITHUB_TOKEN` and `GITHUB_REPOSITORY` environment variables to be set, which is handled automatically by the workflow.

## License

This project is licensed under the [Gnu GPL-3](LICENSE).
