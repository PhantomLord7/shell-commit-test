# Run Prettier (assuming Prettier is available in the system PATH)
npx prettier . --write

# Add all changes to the staging area
git add .

# Prompt for commit message
$commit_message = Read-Host -Prompt "Enter the commit message"

git commit -m $commit_message

# Select commit type
Write-Host "Select commit type:"
Write-Host "1. Changes"
Write-Host "2. Fixes"
Write-Host "3. Other"

$commit_type = Read-Host "Enter your choice"

switch ($commit_type) {
    1 {
        $commit_type_prefix = "changes/"
        break
    }
    2 {
        $commit_type_prefix = "fixes/"
        break
    }
    3 {
        $commit_type_prefix = ""
        break
    }
    Default {
        Write-Host "Invalid choice. Proceeding with 'other'."
        $commit_type_prefix = ""
        break
    }
}

# Prompt for new branch name
$branch_name = Read-Host -Prompt "Enter the new branch name"

# Add commit type prefix to branch name if applicable
$branch_name = $commit_type_prefix + $branch_name

# Create a new branch and switch to it
git checkout -b $branch_name

# Push changes to the origin branch
git push origin $branch_name

Write-Host "All operations completed successfully. Your code is formatted and pushed to a new branch."

pause