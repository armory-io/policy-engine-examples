package spinnaker.http.authz

test_is_allowed_if_user_is_admin {
    allow with input as {
        "user": {
            "isAdmin": true
        }
    }
}

test_not_allowed_if_user_is_not_admin {
    not allow with input as {
        "user": {
            "isAdmin": false
        }
    }
}

test_get_application_allowed_by_deploy_read {
    allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_read"]
        },
        "path": ["applications", "myapp"],
        "method": "GET"
    }
}

test_get_application_not_allowed_by_deploy_admin {
    not allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_admin"]
        },
        "path": ["applications", "myapp"],
        "method": "GET"
    }
}

test_list_applications_allowed_by_deploy_read {
    allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_read"]
        },
        "path": ["applications"],
        "method": "GET"
    }
}

test_list_applications_not_allowed_by_deploy_admin {
    not allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_admin"]
        },
        "path": ["applications"],
        "method": "GET"
    }
}

test_deploy_admin_is_allowed_to_delete_pipelines {
    allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_admin"]
        },
        "method": "DELETE",
        "path": ["pipelines", "testapp", "testpipeline"]
    }
}

test_deploy_admin_is_allowed_to_create_and_update_pipelines {
    allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_admin"]
        },
        "method": "POST",
        "path": ["pipelines", "testapp", "testpipeline"]
    }
}

test_deploy_execute_test_can_scale_manifests_from_infra_tab {
    allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_execute_test"]
        },
        "method": "POST",
        "path": ["tasks"],
        "body": {
            "job": [{
                "type": "scaleManifest",
                "account": "test"
            }]
        }
    }
}

test_deploy_execute_test_cannot_scale_manifests_from_infra_tab_for_prod_account {
    not allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_execute_test"]
        },
        "method": "POST",
        "path": ["tasks"],
        "body": {
            "job": [{
                "type": "scaleManifest",
                "account": "prod"
            }]
        }
    }
}

test_deploy_execute_test_cannot_delete_manifests_from_infra_tab_for_prod_account {
    not allow with input as {
        "user": {
            "isAdmin": false,
            "roles": ["deploy_execute_test"]
        },
        "method": "POST",
        "path": ["tasks"],
        "body": {
            "job": [{
                "type": "deleteManifest",
                "account": "test"
            }]
        }
    }
}