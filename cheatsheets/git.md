git
# </ Git >


```bash
................................................................................  
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

................................................................................

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