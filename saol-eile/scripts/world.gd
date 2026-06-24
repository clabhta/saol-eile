extends Node3D

@onready var camera: Camera3D = $cameraPivot/Camera3D
@onready var player: CharacterBody3D = $player
@onready var targetMarker = $targetMarker

func _ready():
	player.targetMarkerFalse.connect(targetMarkerFalsify)
	
func targetMarkerFalsify():
	targetMarker.visible = false

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
				var target = result.position
				
				target.x = floor(target.x) + 0.5
				target.z = floor(target.z) + 0.5
				target.y = player.global_position.y
				
				targetMarker.global_position = Vector3(target.x, 0.03, target.z)
				targetMarker.visible = true
				
				player.move_to_position(target)
