Script that exports all of the available GPG keys of the Github organization's members. It's may be helpful when you verify the commit signatures locally.


GH token is requried. Go to the [Personal access tokens](https://github.com/settings/tokens) page and generate a new one with the `read:org` scope.

> The `read: org` scope is optional but allows to get a complete list of the organization's members, including private onces.


Let's export all available keys from Github and import them into GPG:
```bash
export GH_TOKEN=<your_personal_token>
./export-org-keys.sh <your_gh_organization> | gpg --import -
```
