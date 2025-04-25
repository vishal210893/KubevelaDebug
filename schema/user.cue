// schema/user.cue
package schema
//#User: {
//    name: string      // required
//    age:  int & >=0   // required and must be non‑negative
//}
//
//// The value we want to validate (age still missing).
//user: #User & {
//    name: "Alice"
//}


parameter: {
  firstkey: string
  secondkey: string
  thirdkey: string
  forthkey: string
}
output: {
  apiVersion: "v1"
  kind:       "ConfigMap"
  metadata: {
    name: context.name
  }
  data: {
    one: parameter.firstkey
    two: parameter.secondkey
    three: parameter.thirdkey
    four: parameter.forthkey
  }
}

context: _
parameter: _

parameter: {"firstkey":"1","secondkey":"2","thirdkey":"3","forthkey":"4"}
context: {"appAnnotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"core.oam.dev/v1beta1\",\"kind\":\"Application\",\"metadata\":{\"annotations\":{},\"name\":\"kubevelaefshappypathonlycheckingsta-wdrg\",\"namespace\":\"default\"},\"spec\":{\"components\":[{\"name\":\"express-server\",\"properties\":{\"firstkey\":\"1\",\"secondkey\":\"2\",\"thirdkey\":\"3\"},\"type\":\"configmap-component\"}]}}\n"},"appLabels":{},"appName":"kubevelaefshappypathonlycheckingsta-wdrg","appRevision":"","appRevisionNum":0,"cluster":"","clusterVersion":{"gitVersion":"v1.30.4+k3s1","major":"1","minor":30,"platform":"linux/arm64"},"components":[{"name":"express-server","type":"configmap-component","properties":{"firstkey":"1","secondkey":"2","thirdkey":"3"}}],"name":"express-server","namespace":"default","publishVersion":"","replicaKey":"","revision":"","workflowName":""}
