"""
File: Global.gd
Description: Contains all Global variables pulled from firebase after user logs in
Usage: To use variable, type "Global.[VARIABLE NAME]", where [VARIABLE NAME] is the name of the variable :D
"""
extends Control

var userID = ""

# Global Furniture Dictionary
var FurnitureDict = {
	0 : "chair",
	1 : "closet",
	2 : "lamp",
	3 : "painting",
	4 : "poster",
	5 : "round_mirror",
	6 : "shelf",
	7 : "square_mirror",
	8 : "dorm_table",
}

# UserFurniture
var UserFurniture = {
	"userID" : "",
	"furniture" : [], # furniture: string array representing the names of furniture the user has
	"placed" : [], # placed: boolean array representing whether the furniture at this index has been placed or not 
}

# UserMoney
var currency = 0
var UserMoney = {
	"userID" : "",
	"currency" : 0, # currency: int representing how much money the user has
}

# UserTodo
var UserTodo = {
	"userID" : "",
	"tasks" : [], # tasks: string array representing which tasks the user has
	"isComplete" : [], # isComplete: boolean array representing which tasks have been completed
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

