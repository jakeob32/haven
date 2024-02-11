"""
File: auth.gd
Description: Functions to sign up and login on Login Page
"""

extends Node2D

#var webAPIKey = "AIzaSyC5ySHiHVx4MbVVDYNhINL5gr7ta-_C98g"
#var signupUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
#var loginUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="

# login / signup function: makes http request with user's credentials
#func _loginSignup(url: String, email: String, password: String):
	#var http = $HTTPRequest
	#var jsonObject = JSON.new()
	#var body = jsonObject.stringify({'email' : email, 'password' : password})
	#var headers = ['Content-Type: application/json']
	#var error = await http.request(url, headers, HTTPClient.METHOD_POST, body)

# function that runs after http request: gets users info or prints error message if credentials are not valid
#func _on_http_request_request_completed(result, response_code, headers, body):
	#var response = JSON.parse_string(body.get_string_from_utf8())
	#if (response_code == 200):
		#Global.email = response.email
		#get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")
	#else:
		#print(response.error)
		#$error_message.text = response.error.message

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		$state.text = "Logged in!!!"
		get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")

func _process(delta):
	pass

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
	get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")

func on_signup_succeeded(auth):
	print(auth)
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
