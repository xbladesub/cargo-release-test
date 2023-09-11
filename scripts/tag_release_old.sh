
#!/bin/sh -eu
# make sure local main branch is up to date
git checkout main && git pull --ff-only
RELEASE=${RELEASE:-`date --iso-8601`}
# release branch is started from main
git checkout -b release/${RELEASE}
# major/minor/patch
COMPONENT=${COMPONENT:-patch}
# bump release version
TAG=1 COMPONENT=$COMPONENT ./scripts/bumpversion_old.sh
# git push && git push --tags
