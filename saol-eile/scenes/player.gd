extends CharacterBody3D

@export var speed := 5.0
@export var gravity := 20.0

func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO
	
	if Input.is_key_pressed(KEY_W):
		input_dir.z -= 1
		print('w')
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1
		print('a')
	if Input.is_key_pressed(KEY_S):
		input_dir.z += 1
		print('s')
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1
		print('d')
	
	input_dir = input_dir.normalized()
	
	if input_dir.length() > 0:
		rotation.y = atan2(input_dir.x, input_dir.z)
	
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

#

	move_and_slide()
