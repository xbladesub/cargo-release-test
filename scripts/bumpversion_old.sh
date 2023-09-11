#!/usr/bin/env bash

set -e

# we TAG only stable releases
# if TAG is not set then we do a development pre-release build without commit and tag
if [[ $TAG ]]; then
    # we do release
    # by default we bump patch component during release
    COMPONENT=${COMPONENT:-patch}
    bumpversion "${@}" ${COMPONENT}
else
    # we do pre-release
    # pre-releases are ordered after the current release and before the next patch release
    NEXT_PATCH_VERSION=`bumpversion --list --dry-run --allow-dirty patch 2>&1 |tail -1 |sed 's/new_version=//'`
    NEXT_PATCH_VERSION_ARR=(${NEXT_PATCH_VERSION//./ })

    NEW_MAJOR=${NEXT_PATCH_VERSION_ARR[0]}
    NEW_MINOR=${NEXT_PATCH_VERSION_ARR[1]}
    NEXT_PATCH=${NEXT_PATCH_VERSION_ARR[2]}
    PRE_RELEASE="-dev.git`git rev-parse --short HEAD`"
    NEW_PATCH="${NEXT_PATCH}${PRE_RELEASE}"

    COMPONENT=${COMPONENT:-patch}
	COMMIT=${COMMIT:---no-commit}
	bumpversion --new-version $NEW_MAJOR.$NEW_MINOR.$NEW_PATCH ${COMMIT} --no-tag "${@}" ${COMPONENT}
fi
