extends CharacterBody3D

@export var speed = 5.0
@export var gravity = 20.0

# signal for $targetMarker visibility
signal targetMarkerFalse

# clicked move destination
var targetPos: Vector3
var moving = false

func _ready():
	targetPos = global_position
	
func move_to_position(pos: Vector3):
	targetPos = pos
	moving = true

func _physics_process(delta: float) -> void:
	var dir = targetPos - global_position
	
	#TODO ignore y-axis for now; will adjust when plane isn't 2d
	# ask enea: will gravity n collision cover y coord?
	dir.y = 0
	
	if moving and dir.length() > 0.25:
		dir = dir.normalized()
		
		velocity.x = dir.x * speed
		velocity.z = dir.z * speed
		
		# rotate to face move destination
		rotation.y = lerp_angle(
			rotation.y,
			atan2(dir.x, dir.z),
			delta * 10.0
		)
	else:
		velocity.x = 0
		velocity.z = 0
		moving = false
		targetMarkerFalse.emit()
		#targetPos = global_position
	
	# gravity applied
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	
	
	#print(is_on_floor(), " ", velocity.y)
	move_and_slide()
