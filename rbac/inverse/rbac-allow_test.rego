package spinnaker.http.allow.authz 

test_is_allowed_default {
    allow with input as {}
}

test_is_not_allowed_post_tasks {
    not allow with input as {
        "path": ["tasks"],
        "method": "POST"
    }
}

test_is_allowed_get_tasks {
    allow with input as {
        "path": ["tasks"],
        "method": "GET"
    }
}