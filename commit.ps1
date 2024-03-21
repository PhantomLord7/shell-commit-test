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
}

# Process user input to navigate through the menu
$selectedOption = 0
Show-Menu -Options @("Changes", "Fixes", "Other")
while ($true) {
    $key = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode
    if ($key -eq 13) { # Enter key
        break
    }
    elseif ($key -eq 38) { # Up arrow
        $selectedOption = [Math]::Max(0, $selectedOption - 1)
        Write-Host ([char]27) "[1A" # Move cursor up
    }
    elseif ($key -eq 40) { # Down arrow
        $selectedOption = [Math]::Min(($Options.Length - 1), $selectedOption + 1)
        Write-Host ([char]27) "[1B" # Move cursor down
    }
}
$commit_type_prefix = switch ($selectedOption) {
    0 {"changes/"; break}
    1 {"fixes/"; break}
    Default {""; break}
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
