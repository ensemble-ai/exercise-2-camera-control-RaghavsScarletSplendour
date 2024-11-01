class_name PositionFollowCameraController
extends CameraControllerBase


@export var box_width:float = 10.0
@export var box_height:float = 10.0
@export var followSpeedFactor:float = 15.0
@export var leashDistance:float = 5.0
@export var catchUpSpeed:float = 50


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	# Create variable for target and camera position
	var tpos = target.global_position
	var cpos = global_position
	
	# Leash logic
	if tpos.x - cpos.x <= leashDistance:
		cpos.z = lerp(cpos.z, tpos.z, followSpeedFactor * delta)
		cpos.x = lerp(cpos.x, tpos.x, followSpeedFactor * delta)
		
	else:
		cpos.x = lerp(cpos.x, tpos.x, catchUpSpeed * delta)
		cpos.z = lerp(cpos.z, tpos.z, catchUpSpeed * delta)
		
	global_position = cpos
		
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
