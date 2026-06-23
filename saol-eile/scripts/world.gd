extends Node3D

@onready var camera: Camera3D = $cameraPivot/Camera3D
@onready var player: CharacterBody3D = $player

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mousePos = get_viewport().get_mouse_position()
			
			var rayOrigin = camera.project_ray_origin(mousePos)
			var rayDir = camera.project_ray_normal(mousePos)
			var rayEnd = rayOrigin + rayDir * 1000.0
			
			var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
			var result = get_world_3d().direct_space_state.intersect_ray(query)
			
			if result:
				player.move_to_position(result.position)
