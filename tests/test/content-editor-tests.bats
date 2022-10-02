#!/usr/bin/env bash

bucket=$BUCKET_NAME

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-files/load'
    
    export AWS_ACCESS_KEY_ID=$BOBBY_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$BOBBY_SECRET_KEY
}

@test "Content editor should be able to upload and delete files" {
    touch xyz.html
    aws s3 cp xyz.html s3://"$bucket"/
    aws s3api delete-object --bucket "$bucket" --key xyz.html
    last_object=$(aws s3 ls "$bucket"/ | awk '{print $4}' | tail -1)
    refute [ "$last_object" == 'xyz.html' ]
}

teardown() {
    rm xyz.html
}


