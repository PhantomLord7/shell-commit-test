# Run Prettier (assuming Prettier is available in the system PATH)
npx prettier . --write

# Add all changes to the staging area
git add .

# Prompt for commit message
$commit_message = Read-Host -Prompt "Enter the commit message"

# Commit with the entered message
git commit -m $commit_message

# Prompt for new branch name
$branch_name = Read-Host -Prompt "Enter the new branch name"

# Create a new branch and switch to it
git checkout -b $branch_name

# Push changes to the origin branch
git push origin $branch_name

Write-Host "All operations completed successfully. Your code is formatted and pushed to a new branch."

pause