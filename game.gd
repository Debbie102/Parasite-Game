extends Control
@onready var player = %parasite
@onready var Camera_id 
var in_body = false
var current_body 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%parasite/Camera2D.make_current()
	SignalBus.possessing.connect(_on_body_possessed)
	SignalBus.game_over.connect(_on_game_over)
	pass # Replace with function body.
func _on_body_possessed(is_body : bool, body_id: int, pos: Vector2):
	if instance_from_id(body_id) != null:
		instance_from_id(body_id).get_node_or_null("Camera2D").make_current()
	else:
		%parasite/Camera2D.make_current()
	pass
	if is_body == true:
		in_body = true
		$CanvasLayer/Label.visible = true
		current_body = instance_from_id(body_id)
	else:
		in_body = false
		$CanvasLayer.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func get_mob_id(object,body_id):
	for i in range(object.get_child_count()):
		if object.get_child(i).get_instance_id() == body_id:
			print(object.get_child(i))
			return object.get_child(i)
		else:
			get_mob_id(object.get_child(i),body_id)
		pass
func _on_game_over():
	get_tree().change_scene_to_file("res://game_over.tscn")
	pass
func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed("leave_body") and in_body == true:
		print(current_body)
		print(current_body.get("global_position.x"))
		SignalBus.possessing.emit(false,1,Vector2(current_body.global_position.x - 100,current_body.global_position.y-100))
		pass
