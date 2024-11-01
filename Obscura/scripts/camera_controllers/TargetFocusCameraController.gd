class_name TargetFocusCameraController
extends CameraControllerBase

@export var followSpeedFactor: float = 25.0
@export var leashDistance: float = 5.0
@export var idleDuration: float = 0.1
@export var returnSpeed: float = 50.0
@export var leadSpeedMultiplier: float = 5.0
@export var leadMaxDistance: float = 2.0


var idle_timer: float = 0.0
var is_idle: bool = false
var camera_position: Vector3

func _ready() -> void:
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()

	var tpos = target.global_position
	var cpos = global_position
	var is_target_moving = target.velocity.length() > 0.01
	var distance_to_target = Vector2(cpos.x, cpos.z).distance_to(Vector2(tpos.x, tpos.z))

	# Setting and resetting the idle timer
	if is_target_moving:
		idle_timer = 0.0
		is_idle = false

		var lead_direction = target.velocity.normalized()
		camera_position = tpos + (lead_direction * leadMaxDistance * leadSpeedMultiplier)
	else:
		idle_timer += delta
		if idle_timer >= idleDuration:
			is_idle = true

	if is_target_moving and distance_to_target <= leadMaxDistance:
		cpos.x = lerp(cpos.x, camera_position.x, delta * followSpeedFactor)
		cpos.z = lerp(cpos.z, camera_position.z, delta * followSpeedFactor)
		
	elif is_idle:
		cpos.x = lerp(cpos.x, tpos.x, returnSpeed * delta)
		cpos.z = lerp(cpos.z, tpos.z, returnSpeed * delta)
		
	global_position = cpos
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Draw a 5x5 cross
	var line_length: float = 5.0

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# Horizontal line (centered at the screen)
	immediate_mesh.surface_add_vertex(Vector3(line_length / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-line_length / 2, 0, 0))

	# Vertical line (centered at the screen)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, line_length / 2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -line_length / 2))

	immediate_mesh.surface_end()

	# Set material properties
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLUE_VIOLET

	# Add the mesh instance to the scene
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	# Free the mesh instance after one frame update
	await get_tree().process_frame
	mesh_instance.queue_free()
