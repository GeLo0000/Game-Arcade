extends Button
class_name SceneChangeButton

@export var scene_name :StringName

func _ready() -> void:
	button_down.connect(change)

func change():
	get_tree().change_scene_to_file(scene_name)
