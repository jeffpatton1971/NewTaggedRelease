import os
import xml.etree.ElementTree as ET
import sys
import git
import requests

def newtaggedrelease(source_path, project_name):
    github_token = os.getenv('GITHUB_TOKEN')
    github_repository = os.getenv('GITHUB_REPOSITORY')  # 'owner/repo' format

    csproj_path = os.path.join(source_path, f"{project_name}.csproj")
    tree = ET.parse(csproj_path)
    root = tree.getroot()
    namespace = {'msbuild': 'http://schemas.microsoft.com/developer/msbuild/2003'}
    version = root.find('msbuild:PropertyGroup/msbuild:Version', namespace).text

    repo = git.Repo(root)
    repo.git.add(A=True)
    repo.index.commit(f"{project_name} {version} Release")
    origin = repo.remote(name='origin')
    origin.push()
    tag = repo.create_tag(f"v{version}", message=f"{project_name} Version {version}")
    origin.push(tag)

    api_url = f"https://api.github.com/repos/{github_repository}/releases"
    headers = {'Authorization': f'token {github_token}'}
    data = {
        'tag_name': f"v{version}",
        'name': f"v{version}"
    }

    response = requests.post(api_url, json=data, headers=headers)
    response.raise_for_status()  # This will raise an error if the request failed

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python newtaggedrelease.py <source_path> <project_name>")
        sys.exit(1)

    source_path = sys.argv[1]
    project_name = sys.argv[2]

    newtaggedrelease(source_path, project_name)
