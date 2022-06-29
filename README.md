# Clone All Including Private

# Why This Repo?
There are a wide variety of bash scripts floating around to bulk clone all github repositories from a particular user or organization. However, most of these do not work for private repos. This repo presents two different workflows that have been verified to bulk clone all repositories including private repositories. One is more resilient (will work on more environments) but less automated. The other one is more automated, but less resilient. The more resilient one is presented first. Choose from either the "Create List of Clone Commands" or the "Clone All Repos" workflow.

# Create List of Clone Commands

```
curl -u :<PERSONAL_ACCESS_TOKEN_GOES_HERE> -s https://api.github.com/orgs/<ORG_NAME_GOES_HERE>/repos?per_page=1000 | grep -e 'ssh_url' | awk '{print $2}' | sed 's/"\(.*\)",/git clone \1/' > review_and_execute_gitclone.sh
```

Prerequisites:

A terminal capable of running bash commands, such as Git Bash. https://git-scm.com/

A personal access token from GitHub with access to repo > public repo. https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

A GitHub SSH key. If you haven't set that up yet, see the end of the README.

Usage:

Replace <PERSONAL_ACCESS_TOKEN_GOES_HERE> with your personal access token. If bulk cloning from a user instead of an organization, replace "orgs" with "users" in the uri. Then, replace <ORG_NAME_GOES_HERE> with the name of the organization or user you are bulk cloning from.

For example, if you wanted to clone all the repos from residency at your favorite bootcamp, and your personal access token was 'fshfsh', the command would be as follows:

```
 curl -u :fshfsh -s https://api.github.com/orgs/codesmithllc/repos?per_page=1000 | grep -e 'ssh_url' | awk '{print $2}' | sed 's/"\(.*\)",/git clone \1/' > review_and_execute_gitclone.sh
```

If on Windows, and you get an error similar to "bash: $'\302\226\302\226curl': command not found" in your bash shell, please see https://stackoverflow.com/questions/50038286/git-tag-fails-with-226git-command-not-found for how to resolve this error.

Executing the above command will give you a list of git clone commands in the file named review_and_execute_gitclone.sh . Copy and paste those git clone commands into a terminal and run them.

Limitations:

The GitHub API has limitations of 10,000 repos per organization or 1000 per user. If the org or user you are cloning from has more than that, I recommend the Clone All Repos workflow below.

# Clone All Repos
This is a bash script modified from https://gist.github.com/clrung/75459a9fe954313c57f69d6cdfd502ec . It relies on environment variables and passing arguments. As such, it is more automated. However, this also makes it more prone to bash failures from environment specific problems, such as unexpected line break characters being added to the end of variables or environment variables not being passed correctly to the bash shell. When it works, though, it works beautifully.

Prerequisites:

A terminal capable of running bash commands, such as Git Bash. https://git-scm.com/

A personal access token from GitHub with access to repo > public repo. https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

jq

Usage:

Set your personal access token as an environment variable with a key of GITHUB_TOKEN.

After you have clone_all_repos.sh in a local directory, execute it as follows:

```
clone_all_repos.sh [organization] <output directory>
```

# GitHub SSH Key

The more resilient workflow relies on ssh uris for git clone commands. As such, an SSH key is necessary.

Generate an SSH key using the email for your GitHub account with the following command:

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Follow the prompts to generate the key.

Open the file created by the above command. Copy it's entire contents.

Go to https://github.com/settings/ssh/new . Paste the ssh key into the Key field and press "Add SSH key".

Next, run

```
eval $(ssh-agent)
```

and

```
ssh-add
```

To avoid having to enter your passphrase for each cloned repo.


