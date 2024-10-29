class_name position_lock
extends CameraControllerBase


@export var box_width:float = 10.0
@export var box_height:float = 10.0


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
	
	global_position.x = target.global_position.x
	global_position.z = target.global_position.z
	
	
	#boundary checks
	#left
	#var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	#if diff_between_left_edges < 0:
		#global_position.x += diff_between_left_edges
	##right
	#var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	#if diff_between_right_edges > 0:
		#global_position.x += diff_between_right_edges
	##top
	#var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	#if diff_between_top_edges < 0:
		#global_position.z += diff_between_top_edges
	##bottom
	#var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	#if diff_between_bottom_edges > 0:
		#global_position.z += diff_between_bottom_edges
		
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
