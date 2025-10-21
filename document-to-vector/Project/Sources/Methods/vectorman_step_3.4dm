//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($task : Object)

var $vectorman : 4D:C1709.Function
$vectorman:=Formula:C1597(vectorman_step_4)

var $text_splitter : cs:C1710.text_splitter.text_splitter
$text_splitter:=cs:C1710.text_splitter.text_splitter.new()
$text_splitter.chunk($task; $vectorman)