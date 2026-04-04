extends MeshInstance3D

@export var wire_width_scale: float = 1.002
@export var deduplicate_edges := true

var _wire_instance: MeshInstance3D

func _ready() -> void:
	if mesh == null:
		push_warning("No mesh assigned.")
		return

	_build_wire_overlay()

func _build_wire_overlay() -> void:
	# Remove old overlay if rebuilding.
	if is_instance_valid(_wire_instance):
		_wire_instance.queue_free()

	var line_mesh := ArrayMesh.new()
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Global.GRID_HIGHLIGHT_COLOR
	material.vertex_color_use_as_albedo = false
	material.no_depth_test = false
	material.cull_mode = BaseMaterial3D.CULL_DISABLED

	var edge_keys := {}
	var all_vertices := PackedVector3Array()

	for surface_i in range(mesh.get_surface_count()):
		var arrays := mesh.surface_get_arrays(surface_i)
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var indices: PackedInt32Array = arrays[Mesh.ARRAY_INDEX]

		if vertices.is_empty():
			continue

		if indices.is_empty():
			# Assume triangles are laid out sequentially.
			for i in range(0, vertices.size(), 3):
				if i + 2 >= vertices.size():
					break
				_add_triangle_edges(vertices, i, i + 1, i + 2, all_vertices, edge_keys)
		else:
			for i in range(0, indices.size(), 3):
				if i + 2 >= indices.size():
					break
				_add_triangle_edges(vertices, indices[i], indices[i + 1], indices[i + 2], all_vertices, edge_keys)

	if all_vertices.is_empty():
		push_warning("Could not generate wireframe edges.")
		return

	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = all_vertices
	line_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)

	_wire_instance = MeshInstance3D.new()
	_wire_instance.name = "WireOverlay"
	_wire_instance.mesh = line_mesh
	_wire_instance.material_override = material
	_wire_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Slightly enlarge so the lines sit above the planet surface.
	_wire_instance.scale = Vector3.ONE * wire_width_scale

	add_child(_wire_instance)

func _add_triangle_edges(
		vertices: PackedVector3Array,
		a: int,
		b: int,
		c: int,
		out_vertices: PackedVector3Array,
		edge_keys: Dictionary
	) -> void:
	_add_edge(vertices, a, b, out_vertices, edge_keys)
	_add_edge(vertices, b, c, out_vertices, edge_keys)
	_add_edge(vertices, c, a, out_vertices, edge_keys)

func _add_edge(
		vertices: PackedVector3Array,
		a: int,
		b: int,
		out_vertices: PackedVector3Array,
		edge_keys: Dictionary
	) -> void:
	if deduplicate_edges:
		var lo := mini(a, b)
		var hi := maxi(a, b)
		var key := str(lo) + ":" + str(hi)
		if edge_keys.has(key):
			return
		edge_keys[key] = true

	out_vertices.push_back(vertices[a])
	out_vertices.push_back(vertices[b])
