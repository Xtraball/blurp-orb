#!/bin/sh

PostToCircleCI()
{
    echo -e "PostToCircleCI \n"
    echo -e $CCI_STATUS"\n"
    git log --format=format:%s -n 1


    #curl --location \
    #          --request POST '' \
    #          --header 'Content-Type: application/json' \
    #          -d '' \
    #          -u ":"
    echo
}

. "/tmp/BLURP_JOB_STATUS"

PostToCircleCI