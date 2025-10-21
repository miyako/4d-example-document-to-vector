//%attributes = {}
var $GPTFolder : 4D:C1709.Folder
$GPTFolder:=Folder:C1567("/RESOURCES/GPT")
$GPTFolder.create()

var $searchText : Text
$searchText:="the condition under which the evaluation license ends"

var $data : Blob
var $vector : 4D:C1709.Vector

var $GPTFile : 4D:C1709.File
$GPTFile:=$GPTFolder.file($searchText)

If ($GPTFile.exists)
	
	$data:=$GPTFile.getContent()
	BLOB TO VARIABLE:C533($data; $vector)
	
	var $queryParams : Object
	$queryParams:={queryPath: True:C214; queryPlan: True:C214}
	
	var $results; $documents : 4D:C1709.EntitySelection
	$results:=ds:C1482.Embeddings.query(Formula:C1597(This:C1470.embedding.cosineSimilarity($vector)>0.5); $queryParams)
	//$results:=ds.Embeddings.query("embedding > :1"; {metric: mk cosine; threshold: 0.5; vector: $vector}; $queryParams)
	
	$indexes:=$results.extract("index"; "pos"; "documentId"; "Id")
	
	$details:=[]
	
	var $document : cs:C1710.DocumentEntity
	For each ($index; $indexes)
		$document:=ds:C1482.Document.get($index.Id)
		$chunk:=$document.chunk.values[$index.pos]
		$details.push({chunk: $chunk; name: $document.name})
	End for each 
	
	ALERT:C41(JSON Stringify:C1217($details))
	
End if 