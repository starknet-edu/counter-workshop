#!/bin/bash

# Prompt the user to enter the commit hash to cherry-pick
read -p "Enter commit hash to cherry-pick: " COMMIT_HASH

# List of branches to cherry-pick to
BRANCHES=("step1" "step2" "step3" "step4" "step5" "step6" "step7" "step8" "step9" "step10" "step11" "step12" "step13" "step14" "step15-js")

# Store the current branch to return to it later
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Loop through each branch and apply the cherry-pick
for BRANCH in "${BRANCHES[@]}"
do
    echo "Cherry-picking to $BRANCH"

    # Checkout the branch
    git checkout "$BRANCH"

    # Cherry-pick the commit
    git cherry-pick "$COMMIT_HASH"

    # Push the changes
    git push origin "$BRANCH"

    echo "Cherry-picked to $BRANCH successfully"
done

# Return to the original branch
git checkout "$CURRENT_BRANCH"