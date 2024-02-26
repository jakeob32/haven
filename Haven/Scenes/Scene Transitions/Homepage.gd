extends Control

var furniture

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
		push_error("error occurred in the HTTP request")
		
	var furniture_doc_names = ["dorm_bed", "dorm_chair", "dorm_closet", "dorm_lamp", "dorm_painting", "dorm_plant", "dorm_poster", "dorm_round_mirror", "dorm_rug", "dorm_shelf", "dorm_square_mirror", "dorm_table"]
	for i in range(len(furniture_doc_names)):
		furniture_button_pressed(furniture_doc_names[i])


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


# testing
func _on_button_pressed():
	furniture_button_pressed("dorm_chair")


func furniture_button_pressed(furniture_name: String):
	furniture = await Global.get_doc_fields("Furniture", furniture_name)
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._furniture_http_request_completed)
	
	# perform request
	var error = http_request.request(furniture.get("image"))
	if error != OK:
		push_error("error occurred in the HTTP request.")


func _furniture_http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("image couldn't be downloaded")
	
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("couldn't load image")

	var layer_dict = {
		"rug": $background/room/layer1,
		"poster": $background/room/layer2,
		"painting": $background/room/layer3,
		"round mirror": $background/room/layer4,
		"bed": $background/room/layer4/layer5,
		"table": $background/room/layer4/layer6,
		"closet": $background/room/layer4/layer6/layer7, 
		"chair": $background/room/layer4/layer6/layer8, 
		"shelf": $background/room/layer4/layer6/layer9,
		"lamp": $background/room/layer4/layer6/layer9/layer10, 
		"plant": $background/room/layer4/layer6/layer9/layer11, 
		"square mirror": $background/room/layer4/layer6/layer9/layer12,
	}

	var texture = ImageTexture.create_from_image(image)
	var target = layer_dict[furniture.get("name")]
	target.texture = texture




