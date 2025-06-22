extends Resource
class_name DialogData

@export var locutor: String # Quem está falando
@export_file(".png", ".jpg") var faceset_path: String
@export_multiline var dialog: String
