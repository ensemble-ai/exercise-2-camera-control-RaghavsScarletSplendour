class_name TargetFocusCameraController
extends CameraControllerBase


@export var box_width:float = 10.0
@export var box_height:float = 10.0
@export var idleDuration: float = 1.0
@export var returnSpeed: float = 5.0
@export var leadSpeedMultiplier: float = 2.0
@export var leadMaxDistance: float = 5.0

var idle_timer: float = 0.0
var is_idle: bool = false


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
	var direction = (tpos - cpos).normalized()
	
	# Check if the target is moving
	if tpos != target.position:
		# Calculate lead position and move camera towards it
		var lead_position = tpos + direction * min(leadMaxDistance, target.velocity.length() * leadSpeedMultiplier * delta)
		global_position.x = lerp(cpos.x, lead_position.x, leadSpeedMultiplier * delta)
		global_position.z = lerp(cpos.z, lead_position.z, leadSpeedMultiplier * delta)
		
		# Reset idle timer since target is moving
		idle_timer = 0.0
		is_idle = false
	else:
		# If the target stops, start the idle timer
		idle_timer += delta
		if idle_timer >= idleDuration:
			is_idle = true
	
	# When idle and enough time has passed, return camera to the target
	if is_idle:
		global_position.x = lerp(cpos.x, tpos.x, returnSpeed * delta)
		global_position.z = lerp(cpos.z, tpos.z, returnSpeed * delta)
	
	# Update target's previous position for next frame comparison
	target.position = tpos
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Define the length of the cross lines
	var line_length: float = 0.5 * max(box_width, box_height)

	# Begin drawing lines for the cross
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# Horizontal line
	immediate_mesh.surface_add_vertex(Vector3(line_length / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-line_length / 2, 0, 0))

	# Vertical line 
	immediate_mesh.surface_add_vertex(Vector3(0, 0, line_length / 2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -line_length / 2))

	immediate_mesh.surface_end()

	# Set material properties
	material.shading_mode = BaseMaterial3D.SHADING_MODE_MAX
	material.albedo_color = Color.BLUE_VIOLET

	# Add the mesh instance to the scene
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	# Free the mesh instance after one frame update
	await get_tree().process_frame
	mesh_instance.queue_free()
