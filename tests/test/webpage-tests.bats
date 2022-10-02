#!/usr/bin/env bash

endpoint=$BUCKET_WEBSITE_ENDPOINT
distribution_domain=$DISTRIBUTION_DOMAIN_NAME

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-files/load'

    touch response
}


@test "Web user should land on index page" {
    curl "$distribution_domain" > response
    response_content=`cat response`
    assert_equal "$response_content" '<h1>WORTH Tech Test</h1>'
}

@test "Web user should land on error page if requested page does not exist" {
    curl "$endpoint"/imaginarypage.html > response
    response_content=`cat response | tail -2 | head -1`
    assert_equal "$response_content" '<h1>Page not found</h1>'
}

@test "News should be publicly avialable" {
    curl "$distribution_domain"/news/article_2.html | head -1 > response
    response_content=`cat response`
    assert_equal "$response_content" '<h1>Some other important news</h1>'
}


teardown() {
    rm -f response
}
