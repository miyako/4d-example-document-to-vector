//%attributes = {}
/*

in the sample data file 

we have 1 record in ds.Document
which is the pdf file in /RESOURCES/EULA.pdf

we have 111 records in ds.Embeddings
which was generated from chunked pieces of the pdf text

*/

var $GPTFolder : 4D:C1709.Folder
$GPTFolder:=Folder:C1567("/RESOURCES/GPT")
$GPTFolder.create()

var $searchText : Text
$searchText:="the condition under which the evaluation license ends"

CONFIRM:C162("are you sure you want to create vectors?")

If (OK=1)
	
	If (Storage:C1525.API.OpenAI=Null:C1517)
		throw:C1805({errCode: -1; message: "OpenAI API key is missing!"})
	End if 
	
	var $AIClient : cs:C1710.AIKit.OpenAI
	$AIClient:=cs:C1710.AIKit.OpenAI.new(Storage:C1525.API.OpenAI)
	
	var $status : Object
	$status:=$AIClient.embeddings.create($searchText; "text-embedding-3-large")
	
	If ($status.success)
		$vector:=$status.vector
		VARIABLE TO BLOB:C532($vector; $data)
		$GPTFolder.file($searchText).setContent($data)
	End if 
	
End if 