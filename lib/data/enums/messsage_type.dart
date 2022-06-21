enum MessageType {
  text,
  file
}
extension MessageTypeExtention on MessageType {
  String get value {
    switch (this) {
      case MessageType.text:
        return 'text';
      case MessageType.file:
        return 'file';
    }
  }
}