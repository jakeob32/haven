extends Button
@onready var furniture_img: TextureRect = $TextureRect
@onready var furniture_name: Label = $furniture_name
var furniture_doc_names = ["dorm_bed", "dorm_chair", "dorm_closet", "dorm_lamp", "dorm_painting", 
						"dorm_plant", "dorm_poster", "dorm_round_mirror", "dorm_rug", "dorm_shelf", 
						"dorm_square_mirror", "dorm_table"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	# if furniture is already placed, the dont show it anymore; else show the furniture
	print("furniture button pressed")
	var ref = self.get_parent().get_parent().get_parent().get_parent().get_parent()
	ref.set_visibility($furniture_name.text)
