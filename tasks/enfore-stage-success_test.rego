package spinnaker.execution.task.before.deployManifest

test_denied_if_pipeline_does_not_pass_approval_stage {
    deny["deployManifest cannot be run without requisite canDeploy stage"] with input as {
        "task": {},
        "pipeline": {
            "stages": [
                {
                    "type": "customCanDeployStage",
                    "context": {
                        "canDeploy": false
                    }
                },
                {
                    "type": "wait",
                }
            ]
        }
    }
}

test_not_denied_if_pipeline_passes_approval_stage {
    deny with input as {
        "task": {},
        "pipeline": {
            "stages": [
                {
                    "type": "customCanDeployStage",
                    "context": {
                        "canDeploy": true
                    }
                },
                {
                    "type": "wait",
                }
            ]
        }
    }
}