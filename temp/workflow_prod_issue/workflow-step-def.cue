import (
	"vela/op"
	"encoding/json"
	"strings"
)
"build-push-image-s3-ecr": {
	alias: ""
	attributes: {}
	description: "Build from s3 and push image to ECR"
	annotations: {
		"category": "CI Integration"
	}
	labels: {}
	type: "workflow-step"
}

template: {
	kaniko: op.#Apply & {
		value: {
			apiVersion: "v1"
			kind:       "Pod"
			metadata: {
				name:       parameter.fnContext.kanikoPodName
				namespace: context.namespace
			}
			spec: {
				containers: [
					{
						image: parameter.kanikoExecutor
						name:  "kaniko"
						command: ["sleep", "30"]
         }]
				 restartPolicy: "Never"
			}
		}
	}
	log: op.#Log & {
		source: {
			resources: [{
				name:      parameter.fnContext.kanikoPodName
				namespace: context.namespace
			}]
		}
	}
	read: op.#Read & {
		value: {
			apiVersion: "v1"
			kind:       "Pod"
			metadata: {
				name:      parameter.fnContext.kanikoPodName
				namespace: context.namespace
			}
		}
	}
	wait: op.#ConditionalWait & {
		#x: {
			state: {
				terminated: {
					reason: *"" |string
				}
			}
		}
		if len(read.value.status.containerStatuses) > 0 {
				 for _, s in read.value.status.containerStatuses {
						if s.name == "kaniko" {
							#x: s
						}
				}
		}
		continue: #x != null && #x.name == "kaniko" && #x.state.terminated != _|_ && #x.state.terminated.reason != _|_ && #x.state.terminated.reason == "Completed"
	}

	parameter: {
		// +usage=Specify the kaniko executor image, default to oamdev/kaniko-executor:v1.9.1
		kanikoExecutor: *"busybox:latest" | string
		// +usage=Specify the dockerfile
		dockerfile: *"./Dockerfile" | string

		fnContext: {
			name: string
			tenant: string
			awsAccountId: int
			clusterName: string
			kanikoPodName: string
		}
		// +usage=Specify the verbosity level
		verbosity: *"info" | "panic" | "fatal" | "error" | "warn" | "debug" | "trace"
	}
}