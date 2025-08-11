$region ="us-east-1"
$AllInstances=((Get-EC2Instance -region $region).Instances).InstanceId
$SSMInstances=(Get-SSMInstanceInformation -region $region).InstanceId
Compare-Object -ReferenceObject $SSMInstances -DifferenceObject $AllInstances -IncludeEqual
