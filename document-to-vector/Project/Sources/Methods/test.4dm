//%attributes = {}
TRUNCATE TABLE:C1051([Document:1])
SET DATABASE PARAMETER:C642([Document:1]; Table sequence number:K37:31; 0)

var $file : 4D:C1709.File
$file:=File:C1566("/RESOURCES/EULA.pdf")

If ($file.exists)
	
	var $document : cs:C1710.DocumentEntity
	$document:=ds:C1482.Document.new()
	$document.name:=$file.fullName
	$document.data:=$file.getContent()
	var $status : Object
	$status:=$document.save()
	
End if 