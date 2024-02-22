extends Control
@export var task_entry_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var control_instance: Control = task_entry_scene.instantiate() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")
