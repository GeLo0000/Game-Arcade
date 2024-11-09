extends CharacterBody3D
class_name PlayerMainMenu

@export var speed_walk := 5.0
@export var speed_run := 10.0
@export var jump_velocity := 4.5
@export var mouse_sensitivity := .05

var previous_frame_hover :PlayerHoverTrigger


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_raycast()


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		%Camera3D.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		self.rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
		var camera_rot = %Camera3D.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		%Camera3D.rotation_degrees = camera_rot

func handle_raycast():
	handle_raycast_hover()
	handle_raycast_use()

func handle_raycast_hover():
	if %RayCast3D.is_colliding() and %RayCast3D.get_collider().has_method("hover_enter"):
		if previous_frame_hover == %RayCast3D.get_collider():
			return
		if previous_frame_hover!=null:
			previous_frame_hover.hover_exit()
		previous_frame_hover=%RayCast3D.get_collider()
		%RayCast3D.get_collider().hover_enter()
	else:
		if previous_frame_hover!=null:
			previous_frame_hover.hover_exit()
		previous_frame_hover=null

func handle_raycast_use():
	if previous_frame_hover!=null and Input.is_action_just_pressed("first_person_use"):
		previous_frame_hover.use_enter()
	elif previous_frame_hover!=null and Input.is_action_just_released("first_person_use"):
		previous_frame_hover.use_exit()

func handle_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("first_person_move_left", "first_person_move_right", "first_person_move_forward", "first_person_move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * get_speed()
		velocity.z = direction.z * get_speed()
	else:
		velocity.x = move_toward(velocity.x, 0, get_speed())
		velocity.z = move_toward(velocity.z, 0, get_speed())
	move_and_slide()

func get_speed():
	if Input.is_action_pressed("first_person_sprint"):
		return speed_run
	else:
		return speed_walk
