#!/bin/sh

PostToCircleCI()
{
    echo -e "PostToCircleCI \n"
    echo -e $CCI_STATUS"\n"
    previous_commit_message=`git log --format=format:%s -n 1 HEAD~1`

    if [[ $CCI_STATUS != "pass" ]]
    then
        echo -e "Job failed, we skip."
        exit 0
    fi


    # If the previous commit right before the update_version was from the update migration pipeline we skip it
    if [[ $previous_commit_message == *"SKIP_MIGRATION_STEP"* ]]
    then
        echo -e "We will skip the update_migration pipeline as we already come from it."
    else
        echo -e "Now we must trigger the update_migration pipeline."

        echo -e will exec: curl --location --request POST \'${PIPELINE_URL}\' --header \'Content-Type: application/json\' -d \'{\"parameters\": {\"gem\": \"${PIPELINE_PARAMS}\"}}\' -u \'${PIPELINE_PERSONAL_TOKEN}:\'
        curl --location --request POST ${PIPELINE_URL} --header 'Content-Type: application/json' -d '{"parameters": {"gem": "'${PIPELINE_PARAMS}'"}}' -u "${PIPELINE_PERSONAL_TOKEN}:"
    fi

    exit 0
}

. "/tmp/BLURP_JOB_VARS"

PostToCircleCI