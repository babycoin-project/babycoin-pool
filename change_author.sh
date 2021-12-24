#!/bin/sh

if [[ $# -eq 3 ]]; then
    git filter-branch --env-filter '
    if [ "$GIT_COMMITTER_EMAIL" = "'$1'" ]; then
        export GIT_COMMITTER_NAME='$2'
        export GIT_COMMITTER_EMAIL='$3'
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "'$1'" ]; then
        export GIT_AUTHOR_NAME='$2'
        export GIT_AUTHOR_EMAIL='$3'
    fi
    ' --tag-name-filter cat -- --all
else
    echo "usage: $0 OLD_EMAIL NEW_EMAIL NEW_NAME"
    echo ""
    echo "    OLD_EMAIL     The email address to be replaceed in the commits"
    echo "    NEW_EMAIL     The new author email address to be used in the commit matching OLD_EMAIL"
    echo "    NEW_NAME      The name which should be used in the commit mathing OLD_EMAIL"
fi
