extends Control
var furniture_button_scene = preload("res://furniture_button.tscn")
var furniture_doc_names = ["dorm_bed", "dorm_chair", "dorm_closet", "dorm_lamp", "dorm_painting", 
						"dorm_plant", "dorm_poster", "dorm_round_mirror", "dorm_rug", "dorm_shelf", 
						"dorm_square_mirror", "dorm_table"]

var furniture

# Called when the node enters the scene tree for the first time.
func _ready():
	var layer_dict = {
		"rug": $background/room/parentlayer1/layer1,
		"poster": $background/room/parentlayer1/layer2,
		"painting": $background/room/parentlayer1/layer3,
		"round mirror": $background/room/parentlayer1/layer4,
		"bed": $background/room/parentlayer1/parentlayer2/layer5,
		"table": $background/room/parentlayer1/parentlayer2/layer6,
		"closet": $background/room/parentlayer1/parentlayer2/parentlayer3/layer7, 
		"chair": $background/room/parentlayer1/parentlayer2/parentlayer3/layer8, 
		"shelf": $background/room/parentlayer1/parentlayer2/parentlayer3/layer9,
		"lamp": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer10, 
		"plant": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer11, 
		"square mirror": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer12,
	}
	var background = await Global.get_doc_fields("Furniture", "dorm_room")
	# create http request
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	# perform request
	var error = http_request.request(background.get("image"))
	if error != OK:
		push_error("error occurred in the HTTP request.")
	
	# loading in furniture edit buttons
	$background/top_bar/currency.text = "$" + str(Global.UserMoney["currency"])
	for i in range(len(furniture_doc_names)):
		furniture = await Global.get_doc_fields("Furniture", furniture_doc_names[i])
		var furniture_button = furniture_button_scene.instantiate()
		print(furniture["name"])
		$background/ColorRect/ScrollContainer/GridContainer.add_child(furniture_button)
		furniture_button.furniture_name.text = furniture["name"]
		if (!(furniture["name"] in Global.UserFurniture["furniture"])):
			furniture_button.disabled = false
		if (furniture["name"] in Global.UserFurniture["placed"]):
			layer_dict[furniture["name"]].visible = true

func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("image couldn't be downloaded")
	
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("could't load image")
	
	var texture = ImageTexture.create_from_image(image)
	$background/room.texture = texture

func _on_gacha_button_pressed():
	await Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
	get_tree().change_scene_to_file("res://Scenes/Gacha Page.tscn");

func _on_todo_button_pressed():
	await Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
	get_tree().change_scene_to_file("res://Scenes/Todo List Page.tscn");

func _on_logout_button_pressed():
	await Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/Login Page.tscn")

func _on_edit_button_pressed():
	$background/ColorRect.visible = true

func _on_exit_edit_button_pressed():
	$background/ColorRect.visible = false

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
		push_error("could't load image")

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

func set_visibility(name: String):
	var layer_dict = {
		"rug": $background/room/parentlayer1/layer1,
		"poster": $background/room/parentlayer1/layer2,
		"painting": $background/room/parentlayer1/layer3,
		"round mirror": $background/room/parentlayer1/layer4,
		"bed": $background/room/parentlayer1/parentlayer2/layer5,
		"table": $background/room/parentlayer1/parentlayer2/layer6,
		"closet": $background/room/parentlayer1/parentlayer2/parentlayer3/layer7, 
		"chair": $background/room/parentlayer1/parentlayer2/parentlayer3/layer8, 
		"shelf": $background/room/parentlayer1/parentlayer2/parentlayer3/layer9,
		"lamp": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer10, 
		"plant": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer11, 
		"square mirror": $background/room/parentlayer1/parentlayer2/parentlayer3/parentlayer4/layer12,
	}
	print(Global.UserFurniture["placed"])
	if (name in Global.UserFurniture["placed"]):
		var index = Global.UserFurniture["placed"].find(name)
		Global.UserFurniture["placed"].remove_at(index)
		layer_dict[name].visible = false
		print(Global.UserFurniture["placed"])
	else:
		Global.UserFurniture["placed"].append(name)
		layer_dict[name].visible = true
		print(Global.UserFurniture["placed"])
