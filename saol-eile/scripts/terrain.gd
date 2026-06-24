extends MeshInstance3D

@export var width = 32
@export var height = 32
@export var tileSize = 1.0

func _ready():
	if mesh == null:
		generate_mesh()

func generate_mesh():
	var vertices = PackedVector3Array()
	var indices = PackedInt32Array()
	var uvs = PackedVector2Array()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	
	for a in range(height + 1):
		for b in range(width + 1):
			vertices.append(Vector3(b * tileSize, 0, a * tileSize))
			uvs.append(Vector2(b, a))
	
	for a in range(height):
		for b in range(width):
			var i = a * (width + 1) + b
			indices.append_array([
				i, i + 1, i + width + 1,
				i + 1, i + width + 2, i + width + 1
			])
			
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	
	var meshNew = ArrayMesh.new()
	meshNew.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var mat = StandardMaterial3D.new()
	mat.albedo_texture = load("res://sprites/image.png")
	
	# too sharp hurts eyes when idle; stay linear (default)
	#mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	
	meshNew.surface_set_material(0, mat)
	mesh = meshNew
