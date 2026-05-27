extends RigidBody2D

@export var speed: float = 35
@export var randomspeed: float = 20
@export var target : Area2D
@export var dead : bool = false

var noise = FastNoiseLite.new()
var time_passed: float = 0.0

signal slapped

func _on_slapped():
	if dead == false:
		dead = true
		$Buzz.stop()
		$AnimatedSprite2D.play("dead")
		linear_velocity = Vector2(0,-30)
		
func _ready():
	slapped.connect(_on_slapped) # Connects to a function in 'self'
	$Buzz.play()
	$AnimatedSprite2D.play("default")
	noise.seed = randi()
	noise.frequency = 1 # Controls how erratic the flight is

func _physics_process(delta):
	time_passed += delta
	if linear_velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	
	if dead == false:
		# Get a smooth, randomly fluctuating angle (-1 to 1) multiplied by Pi
		var noise_val = noise.get_noise_1d(time_passed) * PI
		if target:
			var target_direction = (target.global_position - global_position).normalized()
		
			linear_velocity = target_direction * speed
			linear_velocity += Vector2(cos(noise_val), sin(noise_val)) * randomspeed

		else:
			linear_velocity = Vector2(cos(noise_val), sin(noise_val)) * speed
		# Calculate direction and move
	else:
		linear_velocity += Vector2(0,-1) * delta
		gravity_scale = 1


		
		
