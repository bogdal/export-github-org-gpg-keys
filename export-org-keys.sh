#!/bin/bash
# This script exports the available GPG public keys of your Github organization's members.
#
# Run:
#     export GH_TOKEN<your_gh_personal_token>
#     ./export-org-keys.sh <your_gh_organizatio>
#
# To import keys into GPG run the following command:
# ./export-org-keys.sh <your_gh_organizatio> | gpg --import -

set -e

github_org_members() {
    curl -s "https://api.github.com/graphql" \
      -H "Authorization: bearer $GH_TOKEN" \
      -X POST \
      -d '{
        "query": "query Organization($org: String!){organization(login:$org){membersWithRole(first:100){nodes{login}}}}",
        "variables": {"org": "'"$1"'"}
      }' | jq -r '.data.organization.membersWithRole.nodes[].login'
}

for member in $(github_org_members $1); do
  key=$(curl -s "https://github.com/$member.gpg")
  if [[ ! $key =~ "Note" ]]; then
    echo "$key"
  fi
done
