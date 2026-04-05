extends TileMapLayer

const MACHINE = preload("uid://dtrebi3nc5gry")

func _ready():
	update_internals()
	var index: int = Global.COMPONENT.NUM_TYPES
	var machines = []
	for child in get_children():
		if child is Machine:
			machines.append(child)
	machines.shuffle()
	for child in machines:
		child.input_index = index
		child.output_index = index + 10
		var children = child.get_children()
		for i in children:
			if i is MeshInstance2D:
				i.modulate = Color(Global.COMPONENT.COLORS[index % 10])
		if index > 0:
			index -= 1
