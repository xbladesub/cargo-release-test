#!/bin/bash -eu

# Checkout the master branch and ensure it's up to date
git checkout main
git pull --ff-only

# Set the release version
RELEASE=${RELEASE:-`date --iso-8601`}

# Create a release branch
RELEASE_BRANCH="release/${RELEASE}"

# Create and switch to the release branch
git checkout -b "${RELEASE_BRANCH}"

# Specify the version component (major, minor, or patch)
COMPONENT=${COMPONENT:-patch}

# Bump the version using cargo-release
cargo release ${COMPONENT} -p cargo-release-test --execute --verbose

git add . && git commit -m "Bump version to ${RELEASE}"

# Push the changes and the newly created tag to the remote repository
# git push origin "${RELEASE_BRANCH}"
# git push --tags
