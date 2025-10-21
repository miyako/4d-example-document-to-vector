//%attributes = {}
/*
OpenAI API key stored in file
*/
var $keyFile : 4D:C1709.File
$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("OpenAI.token")
ASSERT:C1129($keyFile.exists)
Use (Storage:C1525)
	Storage:C1525.API:=New shared object:C1526("OpenAI"; $keyFile.getText())
End use 

CONFIRM:C162("are you sure you want to create records?")

If (OK=1)
	
	TRUNCATE TABLE:C1051([Document:1])
	SET DATABASE PARAMETER:C642([Document:1]; Table sequence number:K37:31; 0)
	
	TRUNCATE TABLE:C1051([Embeddings:2])
	SET DATABASE PARAMETER:C642([Embeddings:2]; Table sequence number:K37:31; 0)
	
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
	
End if 