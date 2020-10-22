################################################
# Persistence Policies

## pakcage declaration for PE Plugin
package spinnaker.execution.pipelines.before

## package declaration for Armory Extension
# package opa.pipelines

deny["Every pipeline github trigger must have a secret"] {
	some i
    trigger := input.triggers[i]
	trigger.type == "git"
    trigger.source == "github"
    object.get(trigger, "secret", "") == ""
}

response := {
	"allowed": count(deny) == 0,
	"errors": deny,
}