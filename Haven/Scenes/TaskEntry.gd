extends HBoxContainer
@onready var currency_label: Label = $currency_label
@onready var name_label: Label = $name_label
@onready var description_label: Label = $description_label
@onready var check_button: TextureButton = $CheckButton
@onready var isComplete = false
@onready var current_task = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isComplete == true:
		$CheckButton.texture_normal = load("res://CheckedBox.png")
		$CheckButton.disabled = true
		set_process(false)

func _on_check_button_toggled(toggled_on):
	if isComplete == false:
		Global.UserTodo["isComplete"][current_task] = true
		Global.update_doc_fields("UserTodo", Global.userID, Global.UserTodo)
		Global.currency += int(currency_label.text)
		Global.UserMoney["userID"] = Global.userID
		Global.UserMoney["currency"] = Global.currency
		Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)
		$CheckButton.texture_normal = load("res://CheckedBox.png")
		$CheckButton.disabled = true
	
