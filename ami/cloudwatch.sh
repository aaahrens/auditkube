#!/bin/bash -ex

if [[ -n $CLOUDWATCH_AWS_ACCESS_KEY_ID ]]
then
    sudo apt-get update -y
    sudo apt-get install -y unzip libwww-perl libdatetime-perl

    pushd /tmp/
    curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O
    unzip CloudWatchMonitoringScripts-1.2.1.zip
    rm CloudWatchMonitoringScripts-1.2.1.zip

    sudo mv aws-scripts-mon /etc
    pushd /etc/aws-scripts-mon

    sudo echo "AWSAccessKeyId=${CLOUDWATCH_AWS_ACCESS_KEY_ID}" > awscreds.conf
    sudo echo "AWSSecretKey=${CLOUDWATCH_AWS_SECRET_ACCCESS_KEY}" >> awscreds.conf

    crontab -l > /tmp/new_crontab
    echo "*/5 * * * * /etc/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron" >> /tmp/new_crontab
    crontab /tmp/new_crontab
    rm /tmp/new_crontab

    popd
    popd
else
    echo "Not Installing CloudWatch"
fi
