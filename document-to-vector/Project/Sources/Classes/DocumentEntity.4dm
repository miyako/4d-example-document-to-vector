Class extends Entity

local Function event touched name($event : Object)
	
	If (This:C1470.name=Null:C1517)
		This:C1470.clear(["extension"])
		return 
	End if 
	
	var $extension : Text
	$extension:=Path to object:C1547(This:C1470.name).extension
	
	If ($extension="")
		This:C1470.clear(["extension"])
		return 
	End if 
	
	This:C1470.extension:=$extension
	
local Function clear($attributes : Collection)
	
	var $attribute : Text
	For each ($attribute; $attributes)
		This:C1470[$attribute]:=Null:C1517
	End for each 
	
Function event validateSave($event : Object)
	
Function event saving($event : Object)
	
Function event afterSave($event : Object)
	
	var $task : Object
	var $vectorman : 4D:C1709.Function
	
	Case of 
		: (This:C1470.extension=Null:C1517)
			
			return 
			
		: ($event.savedAttributes.includes("data"))
			
			If (This:C1470.data=Null:C1517) || (This:C1470.data.size=0)
				This:C1470.clear(["text"; "name"; "data"; "extension"; "chunk"])
				return 
			End if 
			
			$vectorman:=Formula:C1597(vectorman_step_1)
			$task:={\
				file: This:C1470.data; \
				data: {\
				extension: This:C1470.extension; \
				dataClassName: $event.dataClassName; \
				attributeName: "text"; \
				primaryKey: This:C1470.getKey(dk key as string:K85:16)}}
			
			CALL WORKER:C1389($vectorman.source; $vectorman; $task)
			
		: ($event.savedAttributes.includes("text"))
			
			If (This:C1470.text=Null:C1517)
				This:C1470.clear(["chunk"])
				return 
			End if 
			
			$vectorman:=Formula:C1597(vectorman_step_3)
			$task:={\
				file: This:C1470.text; \
				capacity: "100..200"; \
				overlap: 70; \
				tiktoken: True:C214; \
				data: {\
				extension: This:C1470.extension; \
				dataClassName: $event.dataClassName; \
				attributeName: "chunk"; \
				primaryKey: This:C1470.getKey(dk key as string:K85:16)}}
			
			CALL WORKER:C1389($vectorman.source; $vectorman; $task)
			
		: ($event.savedAttributes.includes("chunk"))
			
			This:C1470.embeddings.drop()
			
			If (This:C1470.chunk=Null:C1517)
				return 
			End if 
			
			//TODO: generate embeddings
			
			$vectorman:=Formula:C1597(vectorman_step_5)
			
			var $chunk : Object
			var $text : Text
			var $start; $end : Integer
			
			If (Storage:C1525.API.OpenAI=Null:C1517)
				return {errCode: -1; message: "OpenAI API key is missing!"}
			End if 
			
			var $AIClient : cs:C1710.AIKit.OpenAI
			$AIClient:=cs:C1710.AIKit.OpenAI.new(Storage:C1525.API.OpenAI)
			
			var $headers : Object
			$headers:={\
				dataClassName: "Embeddings"; \
				attributeName: "embedding"; \
				foreignKeyAttributeName: "documentId"; \
				foreignKey: This:C1470.getKey(dk key as string:K85:16); \
				indexAttributeName: "index"; \
				modelAttributeName: "model"}
			
			var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
			$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()
			$options.formula:=$vectorman
			$options.extraHeaders:=$headers
			
			var $index : Integer
			$index:=0
			
			For each ($chunk; This:C1470.chunk.values)
				$options.extraHeaders.index:=String:C10($index)
				$text:=$chunk.text
				$AIClient.embeddings.create($text; "text-embedding-3-large"; $options)
				$index+=1
			End for each 
			
		Else 
			
			TRACE:C157
			
	End case 
	
Function event validateDrop($event : Object)
	
Function event dropping($event : Object)
	
Function event afterDrop($event : Object)