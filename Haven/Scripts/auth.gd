"""
File: auth.gd
Description: Functions to sign up and login on Login Page
"""

extends Control

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		var auth = Firebase.Auth.auth
		Global.userID = auth.localid
		$state.text = "Logged in!!!"
		await load_data()
		get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")


# signup button function: calls loginSignup function with the email and password label input
func _on_signup_button_pressed():
	#var url = signupUrl + webAPIKey
	var email = $email.text
	var password = $password.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	#_loginSignup(url, email, password)


# login button function: calls loginSignup function with the email and password label input
func _on_login_button_pressed():
	#var url = loginUrl + webAPIKey
	var email = $email.text
	var password = $password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	#_loginSignup(url, email, password)


func on_login_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	Global.userID = auth.localid
	
	if auth.localid:
		load_data()
	
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")


func on_signup_succeeded(auth):
	print(auth)
	Global.userID = auth.localid
	
	var UserFurniture: FirestoreCollection = Firebase.Firestore.collection("UserFurniture")
	var furniture_task: FirestoreTask = UserFurniture.add(Global.userID, Global.UserFurniture)
	var furniture_doc = await furniture_task.add_document
	
	var UserMoney: FirestoreCollection = Firebase.Firestore.collection("UserMoney")
	var money_task: FirestoreTask = UserMoney.add(Global.userID, Global.UserMoney)
	var money_doc = await money_task.add_document
	
	var UserTodo: FirestoreCollection = Firebase.Firestore.collection("UserTodo")
	var todo_task: FirestoreTask = UserTodo.add(Global.userID, Global.UserTodo)
	var todo_doc = await todo_task.add_document
	
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")


func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$state.text = message


func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$state.text = message

func load_data():
	Global.UserFurniture = await Global.get_doc_fields("UserFurniture", Global.userID)
	print(Global.UserFurniture)
	
	Global.UserMoney = await Global.get_doc_fields("UserMoney", Global.userID)
	print(Global.UserMoney)
	
	Global.UserTodo = await Global.get_doc_fields("UserTodo", Global.userID)
	print(Global.UserTodo)
