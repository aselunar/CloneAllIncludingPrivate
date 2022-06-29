# Usage: Replace <PERSONAL_ACCESS_TOKEN_GOES_HERE> with your personal access token.
# If cloning from a user instead of an org replace "orgs" in https://api.github.com/orgs/ with "users".
# Replace <ORG_NAME_GOES_HERE> with the name of the organization or user.
# Copy and paste the below command into a terminal and run it.
# This will generate a list of git clone commands called "review_and_execute_gitclone.sh" in your directory to copy and paste into your terminal.

curl -u :<PERSONAL_ACCESS_TOKEN_GOES_HERE> -s https://api.github.com/orgs/<ORG_NAME_GOES_HERE>/repos?per_page=1000 | grep -e 'ssh_url' | awk '{print $2}' | sed 's/"\(.*\)",/git clone \1/' > review_and_execute_gitclone.sh
