@tool
extends Area3D
class_name PlayerHoverTrigger

var connected_activatables:Array[Activatable]=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer=2
	collision_mask=2
	for child in get_parent().get_children():
		if child is Activatable:
			connected_activatables.append(child)

func hover_enter():
	for activatable in connected_activatables:
		activatable.activate()

func hover_exit():
	for activatable in connected_activatables:
		activatable.deactivate()

func use_enter():
	for activatable in connected_activatables:
		activatable.use_enter()

func use_exit():
	for activatable in connected_activatables:
		activatable.use_exit()
