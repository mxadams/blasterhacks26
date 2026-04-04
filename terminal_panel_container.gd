extends PanelContainer

@onready var rich_text_label : RichTextLabel = $TerminalMarginContainer/TerminalVBoxContainer/CommandHistoryRichTextLabel
@onready var line_edit : LineEdit = $TerminalMarginContainer/TerminalVBoxContainer/CommandPromptPanelContainer/CommandPromptMarginContainer/CommandPromptLineEdit

func _ready():
	line_edit.text_submitted.connect(_on_command_entered)
	
func _on_command_entered(text: String) -> void:
	var command = text.strip_edges().to_lower().split(" ", false)
	if command.size() == 0:
		return
	match command[0]:
		"exit":
			get_tree().quit()
		_:
			rich_text_label.text += "\n\nUnknown Command: " + text
	line_edit.clear()
