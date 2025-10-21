//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($embeddingsResult : cs:C1710.AIKit.OpenAIEmbeddingsResult)

If ($embeddingsResult.success)
	
	var $headers : Object
	$headers:=$embeddingsResult.request.headers
	
	var $attributeName : Text
	var $dataClassName : Text
	var $indexAttributeName : Text
	var $modelAttributeName : Text
	var $foreignKeyAttributeName : Text
	
	$foreignKeyAttributeName:=$headers.foreignKeyAttributeName
	$attributeName:=$headers.attributeName
	$dataClassName:=$headers.dataClassName
	$indexAttributeName:=$headers.indexAttributeName
	$modelAttributeName:=$headers.modelAttributeName
	
	var $index : Integer
	$index:=Num:C11($headers.index)
	
	var $entity : 4D:C1709.Entity
	$entity:=ds:C1482[$dataClassName].new()
	$entity[$attributeName]:=$embeddingsResult.embedding.embedding
	$entity[$modelAttributeName]:=$embeddingsResult.model
	$entity[$indexAttributeName]:=$index
	$entity[$foreignKeyAttributeName]:=$headers.foreignKey
	
	$entity.save()
	
End if 