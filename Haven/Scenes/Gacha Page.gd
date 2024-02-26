extends Control

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	currency_label_update(Global.UserMoney.currency)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_home_button_pressed():
	await Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")

func give_money():
	var old = await get_currency()
	Global.UserMoney["currency"] = old + 1000
	await Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)

func get_currency():
	return Global.UserMoney.currency
	
func update_currency(NEW : int):
	Global.UserMoney["currency"] = NEW
	return NEW
	
func currency_label_update(CURRENCY : int):
	$CanvasLayer3/Currency.set_text("$" + str(CURRENCY))

func has_furniture(RAND : int):
	if(Global.UserFurniture["furniture"].has(Global.FurnitureDict[RAND])):
		return true
	else:
		return false
		
func roll_gacha():
	if (get_currency() >= 100):
		var old = get_currency()
		var new = old - 100
		update_currency(new)
		currency_label_update(Global.UserMoney.currency)
		var random = rng.randi_range(5, 6)
		if (!has_furniture(random)):
			Global.UserFurniture["furniture"].append(Global.FurnitureDict[random])
			await Global.update_doc_fields("UserFurniture", Global.userID, Global.UserFurniture)
			print("furniture added")
			$CanvasLayer/Bottom_Text.set_text("You got a " + Global.FurnitureDict[random] + "!")
		else:
			await get_tree().create_timer(1.0).timeout
			update_currency(old)
			currency_label_update(old)
			print("furniture was already there")
			$CanvasLayer/Bottom_Text.set_text("You already have a " + Global.FurnitureDict[random] + "!")
			
	else:
		$CanvasLayer/Bottom_Text.set_text("You don't have enough money to roll the gacha!")

func _on_gacha_button_pressed():
	roll_gacha()
