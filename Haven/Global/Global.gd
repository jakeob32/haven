"""
File: Global.gd
Description: Contains all Global variables pulled from firebase after user logs in
Usage: To use variable, type "Global.[VARIABLE NAME]", where [VARIABLE NAME] is the name of the variable :D
"""
extends Control

# UserID
var userID = ""

# UserFurniture
# furniture: string array representing the names of furniture the user has
var furniture = []
# placed: boolean array representing whether the furniture at this index has been placed or not 
var location = []
var UserFurniture = {
	"userID" : userID,
	"furniture" : furniture,
	"location" : location,
}

# UserMoney
# currency: int representing how much money the user has
var currency = 0
var UserMoney = {
	"userID" : userID,
	"currency" : currency,
}

# UserTodo
# tasks: string array representing which tasks the user has
var tasks = []
# isComplete: boolean array representing which tasks have been completed
var isComplete = []
var UserTodo = {
	"userID" : userID,
	"tasks" : tasks,
	"isComplete" : isComplete,
}

# get_doc_fields: returns a dictionary with the the given document's fields
# usage: fields = await Global.get_doc_fields("collection_name", "document_name")
func get_doc_fields(COLLECTION_ID: String, DOCUMENT_ID: String):
	var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
	var task: FirestoreTask = collection.get_doc(DOCUMENT_ID)
	var document: FirestoreDocument = await task.get_document
	return document.doc_fields

# update_doc_fields: puts given fields dictionary into document
# usage: await update_doc_fields("collection_name", "document_name", fields)
func update_doc_fields(COLLECTION_ID: String, DOCUMENT_ID: String, fields: Dictionary):
	var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
	var up_task: FirestoreTask = collection.update(DOCUMENT_ID, fields)
	var document = await up_task.update_document

# save data function
func save_data(COLLECTION_ID: String, data: Dictionary):
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var task: FirestoreTask = collection.update(auth.localid, data)

# load data function
func load_data():
	pass


