# Run Prettier (assuming Prettier is available in the system PATH)
npx prettier . --write

# Add all changes to the staging area
git add .

# Prompt for commit message
$commit_message = Read-Host -Prompt "Enter the commit message"

git commit -m $commit_message

# Define function to display interactive menu
Function Show-Menu {
    param (
        [string]$Title = 'Select commit type',
        [string[]]$Options
    )
    Clear-Host
    Write-Host "================ $Title ================"
    for ($i = 0; $i -lt $Options.Length; $i++) {
        Write-Host "$($i+1). $($Options[$i])"
    }
    $choice = Read-Host "Enter your choice"
    return $choice
}

# Display interactive menu for commit type
$commitTypeMenu = Show-Menu -Title 'Select commit type' -Options @("Changes", "Fixes", "Other")

# Process user choice for commit type
switch ($commitTypeMenu) {
    1 {
        $commit_type_prefix = "changes/"
        break
    }
    2 {
        $commit_type_prefix = "fixes/"
        break
    }
    Default {
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
