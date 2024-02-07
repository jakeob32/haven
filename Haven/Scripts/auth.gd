"""
File: auth.gd
Description: Functions to sign up and login on Login Page
"""

extends Node2D

var webAPIKey = "AIzaSyC5ySHiHVx4MbVVDYNhINL5gr7ta-_C98g"
var signupUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
var loginUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="

# login / signup function: makes http request with user's credentials
func _loginSignup(url: String, email: String, password: String):
	var http = $HTTPRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email' : email, 'password' : password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url, headers, HTTPClient.METHOD_POST, body)

# function that runs after http request: gets users info or prints error message if credentials are not valid
func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	if (response_code == 200):
		Global.email = response.email
		get_tree().change_scene_to_file("res://Scenes/Homepage.tscn")
	else:
		print(response.error)
		$error_message.text = response.error.message

# signup button function: calls loginSignup function with the email and password label input
func _on_signup_button_pressed():
	var url = signupUrl + webAPIKey
	var email = $email.text
	var password = $password.text
	_loginSignup(url, email, password)

# login button function: calls loginSignup function with the email and password label input
func _on_login_button_pressed():
	var url = loginUrl + webAPIKey
	var email = $email.text
	var password = $password.text
	_loginSignup(url, email, password)
