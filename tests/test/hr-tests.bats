#!/usr/bin/env bash

bucket=$BUCKET_NAME

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-files/load'

    export AWS_ACCESS_KEY_ID=$CHARLIE_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$CHARLIE_SECRET_KEY
}

@test "HR should be able to edit people.html" {
    echo '<h1>Our Employees</h1>
    <ul>
    <li>Bobby Tables</li>
	  <li>Alice</li>
	  <li>Malory</li>
    <li>Marat</li>
    </ul>' > people.html
    aws s3 cp people.html s3://"$bucket"/
    new_employee=`aws s3 cp s3://"$bucket"/people.html - | tail -2 | head -1`
    assert_equal "$new_employee" '    <li>Marat</li>'
    
    # teardown
     echo '<h1>Our Employees</h1>
    <ul>
      <li>Bobby Tables</li>
	  <li>Alice</li>
	  <li>Malory</li>
    </ul>' > people.html
    aws s3 cp people.html s3://"$bucket"/
    rm people.html
}

@test "HR should not be able to edit non-hr files" {
    touch notpeople.html
    aws s3 cp notpeople.html s3://"$bucket"/ || local file_content="upload failed"
    assert_equal "$file_content" 'upload failed'
    
    # teardown
    rm notpeople.html
}


