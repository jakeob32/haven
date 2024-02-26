extends Control
var furniture_button_scene = preload("res://furniture_button.tscn")
var furniture_doc_names = ["dorm_chair", "dorm_closet", "dorm_lamp", "dorm_painting", "dorm_poster", 
							"dorm_round_mirror", "dorm_shelf", "dorm_square_mirror", "dorm_table"]
var furniture

# Called when the node enters the scene tree for the first time.
func _ready():
	$background/top_bar/currency.text = "$" + str(Global.UserMoney["currency"])
	for i in range(len(furniture_doc_names)):
		furniture = await Global.get_doc_fields("Furniture", furniture_doc_names[i])
		var furniture_button = furniture_button_scene.instantiate()
		print(furniture["name"])
		$background/ColorRect/ScrollContainer/GridContainer.add_child(furniture_button)
		furniture_button.furniture_name.text = furniture["name"]

func _on_gacha_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Gacha Page.tscn");

func _on_todo_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Todo List Page.tscn");

func _on_logout_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/Login Page.tscn")

func _on_edit_button_pressed():
	$background/ColorRect.visible = true

func _on_exit_edit_button_pressed():
	$background/ColorRect.visible = false
