package spinnaker.execution.task.before.deployManifest

deny["deployManifest cannot be run without requisite canDeploy stage"] {
    canDeployStages := [s | s = input.pipeline.stages[_]; s.type == "customCanDeployStage"]
    stage := canDeployStages[_]
    not stage.context.canDeploy == true
}