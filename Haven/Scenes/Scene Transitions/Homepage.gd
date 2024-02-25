extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var background = await Global.get_doc_fields("Furniture", "dorm_room")
	# create http request
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	# perform request
	var error = http_request.request(background.get("image"))
	if error != OK:
		push_error("error occurred in the HTTP request.")

func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("image couldn't be downloaded")
	
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("could't load image")
	
	var texture = ImageTexture.create_from_image(image)
	$background/room.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	Global.UserFurniture["furniture"].append("abc")
	Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)

