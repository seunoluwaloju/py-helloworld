#!/usr/bin/env bats

@test "validate pod status" {
  run bash -c "kubectl get pod -o wide | grep 'helloworld'"
  [[ "${output}" =~ "Running" ]]
}

@test "validate deployment replica status" {
  run bash -c "kubectl get -o jsonpath="{.status.availableReplicas}" deployment helloworld"
  [[ "${output}" =~ "2" ]]
}

@test "validate service type" {
  run bash -c "kubectl get -o jsonpath="{.spec.type}" svc helloworld"
  [[ "${output}" =~ "LoadBalancer" ]]
}

@test "validate service port" {
  run bash -c "kubectl get -o jsonpath="{.spec.ports[0].port}" svc helloworld"
  [[ "${output}" =~ "3000" ]]
}

@test "validate access to the application" {
  run bash -c "curl http://localhost:3000"
  [[ "${output}" =~ "Hello Equal Experts" ]]
}