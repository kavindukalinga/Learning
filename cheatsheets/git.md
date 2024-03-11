# </ Git >

If you are a newbie, Refer [Steps](https://github.com/kavindukalinga/Learning/edit/main/cheatsheets/git.md#instructions-for-newbies) after settingup your remote git repository using SSH.

```bash

ssh -T git@bitbucket.org
cd 
git clone git@bitbucket.org:kalingachandrasiri/Practice.git
git pull
git status
# < C H A N G E S >
git add .  
git commit -m "Your commit message"
git push


git branch featurebr
git checkout featurebr
# < C H A N G E S >
git add .
git commit -m "Testing 2"
git push origin featurebr
git checkout main
git merge featurebr
git push origin main
```

## Commands c1

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
git reomte add
git diff sourceBr targetBr
git tag
git stash
git stash pop
git rebase
git clean
```

## https to ssh

```bash
git remote -v
git remote set-url origin git@github.com:<username>/<repository>.git
git push origin <branch-name>
```


## Summary

```bash

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

    # Change Directory
    # Clone repo
git clone git@bitbucket.org:kalingachandrasiri/Practice.git

    # Create a new branch
git branch feature_branch
git checkout feature_branch

    # Make changes, commit, and push the new branch
git add .
git commit -m "Adding a new feature"
git push origin feature_branch

    # Merge the changes into the main branch
git checkout main
git merge feature_branch
git push origin main

    # Edit Repo
    # Create a New Repository:
# Create a new directory
mkdir my_project
# Navigate to the directory
cd my_project
# Initialize a new Git repository
git init

    # Clone an existing repository:
git clone repository_url

    # Check the status of your repository:
git status
    # Add changes to the staging area:
git add file_name   # for a specific file
git add .           # for all changes

    # Commit changes:
git commit -m "Your commit message"
git push

    # Branching:
    # Create a new branch:
git branch branch_name

    # Switch to a branch:
git checkout branch_name
    # or
git switch branch_name   # for Git version 2.23 and later

    # Merge branches:
git checkout main       # Switch to the branch you want to merge into (e.g., main)
git merge branch_name   # Merge changes from branch_name into the current branch

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
git fetch origin
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
git fetch origin
```
