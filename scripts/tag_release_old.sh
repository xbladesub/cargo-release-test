
#!/bin/sh -eu
# make sure local master branch is up to date
git checkout master && git pull --ff-only
RELEASE=${RELEASE:-`date --iso-8601`}
# release branch is started from master
git checkout -b release/${RELEASE}
# major/minor/patch
COMPONENT=${COMPONENT:-patch}
# bump release version
TAG=1 COMPONENT=$COMPONENT ./scripts/bumpversion.sh
# git push && git push --tags
