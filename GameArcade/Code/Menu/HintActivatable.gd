extends Activatable
class_name HintActivatable

@export var hint_text :="[E] Use"
@onready var hint_node := %UseHint

func activate():
	hint_node.visible=true
	hint_node.text=hint_text

func deactivate():
	hint_node.visible=false
