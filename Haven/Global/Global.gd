"""
File: Global.gd
Description: Contains all Global variables pulled from firebase after user logs in
Usage: To use variable, type "Global.[VARIABLE NAME]", where [VARIABLE NAME] is the name of the variable :D
"""

extends Control

# might remove these because idk if we really need them
# btw this is set in the auth.gd file in _on_http_request_request_completed function
var email = ""
var password = ""

# the following variables are from the backend figma stuff
# UserID: might set it to this token id that you get from logging in? check rest api docs
var userId = 0

# UserMoney
# currency: int of how much money the user currently has
var currency = 0

# UserTodo
# tasks: int Array of the taskIds of tasks that have been completed
var tasks = []

# TaskObject (not shore how this works for firebase; also have no idea how dictionary works for godot lmao)
# var Task = {taskId : 0, name : "", desc: "", cost : 0}

# UserFurniture
# funiture: int Array of the furnitureIds of items that have been purchased by user
var furniture = []

# FunitureObject (tbd.... whenever task object is figured out lol)
