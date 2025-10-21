//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

var $data : Object
$data:=$params.context

var $dataClassName : Text
$dataClassName:=$data.dataClassName

var $primaryKey : Text
$primaryKey:=$data.primaryKey

var $attributeName : Text
$attributeName:=$data.attributeName

var $entity : 4D:C1709.Entity
$entity:=ds:C1482[$dataClassName].get($primaryKey)

If ($entity#Null:C1517)
	
	If ($worker.responseError#"")
		$entity[$attributeName]:=Null:C1517
	Else 
		$entity[$attributeName]:={values: JSON Parse:C1218($worker.response; Is collection:K8:32)}
	End if 
	
	$entity.save()
	
End if 