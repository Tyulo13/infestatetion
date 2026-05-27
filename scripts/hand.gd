extends Area2D

@export var disabled : bool = false
@export var slapped : bool = false
@export var slapcooldown = 0.3


var slappedtime = 0.0
var disabledtime = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("slap"):
		if slapped == false and disabled == false:
			$Swat.play()
			slappedtime = slapcooldown
			slapped = true
			for body in get_overlapping_bodies():
				if body.has_meta("bug"):
					body.slapped.emit()
					if body.has_meta("pokey"):
						disabled = true
						$Poke.play()
						disabledtime = 1.0
	if slappedtime < 0:
		slappedtime = 0
		slapped = false
	if disabledtime > 0:
		disabledtime -= delta
		$AnimatedSprite2D.play("stung")
	else:
		disabled = false
		
		
	if slapped == false and disabled == false:
		$AnimatedSprite2D.play("default")
		global_position = global_position.lerp(get_global_mouse_position(), 0.9) 
	else:
		slappedtime -= delta
		if disabled == false:
			
			$AnimatedSprite2D.play("flat")
			
			



func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("wasp"):
		body.queue_free()
		disabled = true
		$Poke.play()
		disabledtime = 1.0
