# </ Git >

If you are a newbie, Refer [Steps](https://github.com/kavindukalinga/Learning/blob/main/cheatsheets/git.md#instructions-for-newbies) after settingup your remote git repository using SSH.

## Table of Contents

- [\</ Git \>](#-git-)
  - [Table of Contents](#table-of-contents)
  - [git init](#git-init)
  - [Working on Git](#working-on-git)
  - [git commands](#git-commands)
  - [Git squash](#git-squash)
  - [Git remote configure](#git-remote-configure)
  - [https to ssh](#https-to-ssh)
  - [Useful Commands](#useful-commands)
  - [Instructions for Newbies:](#instructions-for-newbies)
      - [Clone the Repository:](#clone-the-repository)
      - [Fetch Updates:](#fetch-updates)
      - [Checkout a Branch:](#checkout-a-branch)
      - [Make Changes:](#make-changes)
      - [Stage and Commit Changes:](#stage-and-commit-changes)
      - [Push Changes:](#push-changes)
      - [Review and Merge:](#review-and-merge)
      - [Cleanup:](#cleanup)

## git init

```bash
< Go iside the Directory >
git init
git add .
git commit -m "Initial commit"
git status
git remote add origin https://github.com/kavindukalinga/new-created-repo
git fetch --all
git pull origin main --rebase
git push origin master
git status
git checkout main
git branch -D master
git fetch --all
git pull origin main --rebase
```

## Working on Git

```bash
git clone <ssh>
git branch featurebr
git status
git checkout featurebr
git add .
git commit -m "message"
git fetch --all
git pull --rebase origin main
git push origin featurebr
ui -> PR
ui -> Merge
```

## git commands

```bash
# init
git init

# stage
git add file1 file2
git add .

# Unstage
git reset HEAD
git reset HEAD <file1> <file2> ...

# Remove untracked files
git clean -f
git clean -f y8113.xml y822.txt y8284.cnf ...

# commit 
git commit
git commit -m "add commit message : present tense"

# log
git log
git log --abbrev-commit # shorter commit hash
git log --oneline # first line of wach commit msg
# [Doc](https://git-scm.com/docs/git-log)


```


## Git squash

```bash
git status
git rebase -i HEAD~4  # Here 4 is number of commits to observe
# Go to commit to squash and replace pick with squash | it will squash into previous commit
# Save and next page | Comment unwanted commits | Save
git log --oneline
git push origin branchname -f
```

## Git remote configure

```bash
ssh -T git@bitbucket.org

# Ensure SSH exist
ls -al ~/.ssh

# Generate SSh
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"

# Add ssh to agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Add SSH Key to Bitbucket:
# Open your public key file:
cat ~/.ssh/id_rsa.pub
# Copy the displayed key.
# Go to your Bitbucket account settings, navigate to "SSH keys," and add your public key.

# Verify SSH connection
ssh -T git@bitbucket.org

```

## https to ssh

```bash
git remote -v
git remote set-url origin git@github.com:<username>/<repository>.git
git push origin <branch-name>
```

## Useful Commands

```bash
## Commits
git clone httpLink repoNameYouLike
git add .
git add file1.txt file3.txt file4.txt # Staging
git status
git reset file1.txt     # Unstaging

git commit -m "cmt msg"
git log

## Branches
git branch      # Available Branches
git branch featurebr
git branch

git checkout featurebr

## Inspect
git log
    # Copy the commit hash
git show commit_hash  # show all the changes in commit
git show --name-only commit_hash

git reflog  # Give all the steps of --all

## Undo
git log
    # copy commit_hash
git revert commit_hash  # New commit
:q

# OR
git reset commit_hash   # Reset all mext commits
git reset --soft commit_hash # Remove commits but keep changes
git reset --hard commit_hash # Remove commits with changes

## Merge Branches
git merge featurebr
git log

## Pull Requests
git branch
git push -f  # Force
git checkout featurebr
git push -u origin featurebr

echo newCommit > newcommit.txt
git add .
git commit -m "new commit"
git push
# Login to github, change branch, add PR

## init -h
git init
git remote add
git diff sourceBr targetBr
git tag
git stash
git stash pop
git rebase
git clean
```

## Instructions for Newbies:

Below are step-by-step instructions on how to efficiently work with Git in projects with many branches

#### Clone the Repository:

Start by cloning the repository to your local machine:

```bash
git clone <repository_url>
cd <repository_name>
```

#### Fetch Updates:

Before starting any work, fetch updates from the remote repository to ensure your local copy is up to date:

```bash
git fetch --all
```

#### Checkout a Branch:

Checkout a branch where you will work. If you're working on an existing branch, use:

```bash
git checkout <branch_name>
```

If you need to create a new branch and switch to it, use:

```bash
git checkout -b <new_branch_name>
```

#### Make Changes:

Make your changes to the codebase. You can create, edit, or delete files as needed.

#### Stage and Commit Changes:

Stage the changes you've made for commit:

```bash
git add .
# Commit the changes with a descriptive commit message:
git commit -m "Brief description of changes"

git pull origin main --rebase
```

#### Push Changes:

Push your changes to the remote repository:

```bash
git push origin <branch_name>
```

#### Review and Merge:

> Once your changes are pushed, create a pull request (PR) on the repository's platform (e.g., GitHub, GitLab).
> Request a review from your team members.
> After the review, make any necessary adjustments based on feedback.
> Once the PR is approved, merge it into the main branch or the target branch.

#### Cleanup:

After your changes are merged, clean up your local environment by deleting the branch:

```bash
git checkout main (or master)
git branch -d <branch_name>
```

Optionally, fetch updates again to ensure you have the latest changes:

```bash
git fetch --all
```
