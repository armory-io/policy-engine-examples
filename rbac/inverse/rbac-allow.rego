# package name intentionally incorrect for use in
# this example repo. if you use this example,
# please ensure that you rename the package to
# spinnaker.http.authz
package spinnaker.http.allow.authz

# by default, allow everything
default allow = true

# deny all POST requests to /tasks/**
allow = false {
    input.method = "POST"
    input.path[0] = "tasks"
}

# add subsequent rules for any other types of requests you
# with to deny