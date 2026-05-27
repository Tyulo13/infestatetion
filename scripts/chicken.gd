extends Area2D
@export var health : float = 10
var maxhealth = health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _process(delta):
	for body in get_overlapping_bodies():
		if body.has_meta("bug") and body.has_meta("evil") and health > 0:
			$ChompSFX.play()
			health -= 2
			body.queue_free()
			if health > 0:
				if health / maxhealth < 0.7:
					$AnimatedSprite2D.play("wounded")
				if health / maxhealth < 0.5:
					$AnimatedSprite2D.play("wounded_bad")
				if health / maxhealth < 0.3:
					$AnimatedSprite2D.play("wounded_worse")
			else:
				$AnimatedSprite2D.play("gone")
			if health <= 0:
				$FailSFX.play()
				await get_tree().create_timer(4).timeout
				get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
			
