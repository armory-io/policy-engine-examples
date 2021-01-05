# the spinnaker.http.authz package is uses by gate
# to make authorization decisions about incoming
# API calls
package spinnaker.http.authz

# by default, nothing is allowed
default allow = false

# fiat admins are allowed to do everything
allow {
    input.user.isAdmin == true
}


# deploy_read can only get and list applications
allow {
    input.method = "GET"
    input.path[_] = "applications"
    input.user.roles[_] = "deploy_read"
}

# deploy_admin is allowed to edit and delete pipelines
allow {
    ["GET", "POST", "DELETE"][_] = input.method
    input.path[0] = "pipelines"
    input.user.roles[_] = "deploy_admin"
}

# deploy_execute_dev can perform actions on dev accounts from the infra tab
allow {
    input.method = "POST"
    input.path[0] = "tasks"

    job := input.body.job[0]

    # have to make a list of all actions you can take from the infra tab here
    ["scaleManifest", "deployManifest"][_] = job.type
    
    # this check depends on how accounts are names. you may have to use regular expression
    # to match accounts who names end in dev, for example. 
    job.account = "dev"
    input.user.roles[_] = "deploy_execute_dev"
}

# deploy_execute_test can perform actions on dev accounts from the infra tab
allow {
    input.method = "POST"
    input.path[0] = "tasks"

    job := input.body.job[0]

    # have to make a list of all actions you can take from the infra tab here
    ["scaleManifest", "deployManifest"][_] = job.type
    
    # this check depends on how accounts are names. you may have to use regular expression
    # to match accounts who names end in test, for example. 
    job.account = "test"
    input.user.roles[_] = "deploy_execute_test"
}

# deploy_execute_prod can perform actions on dev accounts from the infra tab
allow {
    input.method = "POST"
    input.path[0] = "tasks"

    job := input.body.job[0]
    
    # have to make a list of all actions you can take from the infra tab here.
    ["scaleManifest", "deployManifest"][_] = job.type
    
    # this check depends on how accounts are names. you may have to use regular expression
    # to match accounts who names end in prod, for example. 
    job.account = "prod"
    input.user.roles[_] = "deploy_execute_prod"
}