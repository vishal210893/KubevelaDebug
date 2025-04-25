"my-trait": {
	type: "trait"
}
template: {
	patch: spec: template: spec: {
		// +patchKey=name
		volumes: [{
			//name: "\(parameter.volumeName)" // works whether or not default value taken
			name: parameter.volumeName // incorrect if default value taken
			hostPath: path: parameter.hostMountPath
		}]
	}
	parameter: {
		// +usage=mount path on host (default /var/run/datadog)
		hostMountPath: *"/etc/mydata" | string
		// +usage=name of host mount volume (default datadog)
		volumeName: *"my-default-vol" | string
	}
}