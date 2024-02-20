extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gacha_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Gacha Page.tscn");


func _on_todo_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Todo List Page.tscn");


func _on_logout_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/Login Page.tscn")

# testing update_doc_fields()
func _on_button_pressed():
	Global.furniture = ["abc"]
	Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
	
