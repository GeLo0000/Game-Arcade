extends Activatable
class_name OutlineActivatable

var affected_mesh :MeshInstance3D
var outline_material :=preload("res://Assets/Materials/OutlineMaterial.tres")

func _ready() -> void:
	for child in get_parent().get_children():
		if child is MeshInstance3D:
			affected_mesh=child
			return

func activate():
	affected_mesh.material_override.next_pass=outline_material

func deactivate():
	affected_mesh.material_override.next_pass=null
