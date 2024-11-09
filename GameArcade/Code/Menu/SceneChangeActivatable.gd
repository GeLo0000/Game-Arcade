extends Activatable
class_name SceneChangeActivatable

@export var scene_name :StringName

func use_enter():
	get_tree().change_scene_to_file(scene_name)
