extends Control
@export var time : int = 0
var timepassed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timepassed += delta
	time = roundi(timepassed)
	$Label.text = str(time)
