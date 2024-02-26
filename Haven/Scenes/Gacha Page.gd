extends Control

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")

func give_money():
	var old = await get_currency()
	Global.UserMoney["currency"] = old + 1000
	await Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)

func get_currency():
	var money = await Global.get_doc_fields("UserMoney", Global.userID)
	return money["currency"]
	
func update_currency(NEW : int):
	Global.UserMoney["currency"] = NEW
	await Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)
	return NEW
	
func has_furniture(RAND : int):
	if(Global.UserFurniture["furniture"].has(Global.FurnitureDict[RAND])):
		return true
	else:
		return false
		
func roll_gacha():
	var old = await get_currency()
	var new = old - 100
	update_currency(new)
	var random = rng.randi_range(0, 8)
	if (!has_furniture(random)):
		Global.UserFurniture["furniture"].append(Global.FurnitureDict[random])
		await Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
		print("furniture added")
	else:
		update_currency(old)
		print("furniture was already there")
		


func _on_gacha_button_pressed():
	roll_gacha()


func _on_button_pressed():
	give_money()
