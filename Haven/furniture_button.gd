extends Button
@onready var furniture_img: TextureRect = $TextureRect
@onready var furniture_name: Label = $furniture_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print("furniture button pressed")
