extends Node2D
@export var fly : PackedScene
@export var bee : PackedScene
@export var mosquito : PackedScene
@export var cockroach : PackedScene
@export var wasp : PackedScene

var rng = RandomNumberGenerator.new()

var time_passed = 0
var difficulty = 0.5

var waspnum = 0


func _ready():
	rng.randomize() # Randomizes the seed based on time

		
func _process(delta: float) -> void:
	time_passed += delta
	if time_passed > 1:
		difficulty += 0.01
		time_passed = 0
		if rng.randi_range(1, 3 / difficulty) == 1:
			var clone = fly.instantiate()
			add_child(clone)
			clone.target = self.get_parent().get_node("Chicken")
			
			clone.position = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
		if rng.randi_range(1, 7 / difficulty) == 1:
			var clone = bee.instantiate()
			add_child(clone)
			clone.target = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
			
			clone.position = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
			
		if rng.randi_range(1, 7 / difficulty) == 1:
			var clone = mosquito.instantiate()
			add_child(clone)
			clone.target = self.get_parent().get_node("Chicken")
			clone.position = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
		if rng.randi_range(1, 5 / difficulty) == 1:
			var clone = cockroach.instantiate()
			add_child(clone)
			clone.target = self.get_parent().get_node("Chicken")
			clone.position = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
		if rng.randi_range(1, (15 / difficulty) + 15) == 1 and not get_node("Wasp"):
			var clone = wasp.instantiate()
			add_child(clone)
			clone.target = self.get_parent().get_node("Hand")
			clone.position = Vector2(180 * [1, -1].pick_random(),randi_range(-90,90))
			
	
