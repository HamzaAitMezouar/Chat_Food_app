class Message {
  final String userName;
  final String receiveName;
  final String message;
  final DateTime sendDate;
  Message(
      {required this.message,
      required this.receiveName,
      required this.sendDate,
      required this.userName});
  static Message fromJson(Map<String, dynamic> json) {
    return Message(
        message: json['message'],
        receiveName: json['receiveName'],
        sendDate: DateTime.parse(json['sendDate']),
        userName: json['userName']);
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'receiveName': receiveName,
        'message': message,
        'sendDate': sendDate.toIso8601String(),
      };
}
