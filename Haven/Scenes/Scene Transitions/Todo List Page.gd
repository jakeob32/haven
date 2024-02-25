extends Control
# Called when the node enters the scene tree for the first time.
var _task_entry_scene = preload("res://Scenes/TaskEntry.tscn")
var one_task = {
	"currency" : 0,
	"description" : "",
	"name" : ""
}
func import_tasks():
	Global.UserTodo["userID"] = Global.userID
	Global.UserTodo["tasks"].append("do_work")
	Global.UserTodo["tasks"].append("drink_water")
	Global.UserTodo["tasks"].append("eat_fruit")
	Global.UserTodo["tasks"].append("exercise_daily")
	Global.UserTodo["tasks"].append("go_offline")
	Global.UserTodo["tasks"].append("take_vitamins")
	for i in range(len(Global.UserTodo["tasks"])):
		Global.UserTodo["isComplete"].append(false)
	Global.update_doc_fields("UserTodo", Global.userID, Global.UserTodo)

func update_one_task(i: int):
	one_task = await Global.get_doc_fields("Task", Global.UserTodo["tasks"][i])
	return one_task
	
func _ready():
	if (Global.UserTodo["tasks"] == []):
		import_tasks()
	print(Global.UserTodo)
	Global.update_doc_fields("UserTodo", Global.userID, Global.UserTodo)
	Global.update_doc_fields("UserMoney", Global.userID, Global.UserMoney)
	for i in range(len(Global.UserTodo["tasks"])):
		await update_one_task(i)
		one_task = await update_one_task(i)
		var task = _task_entry_scene.instantiate()
		$Panel/Control/task_container.add_child(task)
		task.current_task = i
		if (Global.UserTodo["isComplete"][i] == true):
			task.isComplete = true
		task.currency_label.text = str(one_task["currency"])
		task.name_label.text = one_task["name"]
		task.description_label.text = one_task["description"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")
