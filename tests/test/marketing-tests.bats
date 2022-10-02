#!/usr/bin/env bash

bucket=$BUCKET_NAME

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-files/load'

    export AWS_ACCESS_KEY_ID=$ALICE_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$ALICE_SECRET_KEY
    echo "<h1>Breaking news: </h1><p>Ne ws</p>" > article_3.html
}

@test "Marketing employee should be able to upload news" {
    aws s3 cp article_3.html s3://"$bucket"/news/
    last_article=$(aws s3 ls "$bucket"/news/ | awk '{print $4}' | tail -1)
    assert_equal "$last_article" 'article_3.html'
}

@test "Marketing employee should not be able to delete news" {
    aws s3api delete-object --bucket "$bucket" --key news/article_1.html || echo "delete failed"
    first_article=$(aws s3 ls "$bucket"/news/ | awk '{print $4}' | head -1)
    assert_equal "$first_article" 'article_1.html'   
}

teardown() {
    export AWS_ACCESS_KEY_ID=$BOBBY_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$BOBBY_SECRET_KEY
    aws s3api delete-object --bucket "$bucket" --key news/article_3.html
    rm article_3.html
}
