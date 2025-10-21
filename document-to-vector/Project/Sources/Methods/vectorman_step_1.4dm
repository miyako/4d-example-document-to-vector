//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($task : Object)

var $vectorman : 4D:C1709.Function
$vectorman:=Formula:C1597(vectorman_step_2)

var $extract : cs:C1710.extract.extract
$extract:=cs:C1710.extract.extract.new($task.data.extension)
$extract.getText($task; $vectorman)