extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _http_request_completed)
	
	var error = http_request.request("https://firebasestorage.googleapis.com/v0/b/haven-f687f.appspot.com/o/dorm_assets%2FChair.png?alt=media&token=9ca80b2b-3b2b-4d03-b481-9552c5fb1b7e")
	if error != OK:
		print("bruh theres an errorrrrr")

func _http_request_completed(result, response_code, headers, body) :
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		print("erorrrr")
	
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	$room.texture = texture
	


func _on_gacha_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Gacha Page.tscn");

func _on_todo_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Todo List Page.tscn");

func _on_logout_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/Login Page.tscn")

