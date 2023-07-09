class MessageModel {

  String? message;
  String? time;
  String? id;
  String? imageUrl;

  MessageModel({
      this.message, 
      this.time, 
      this.id,
      this.imageUrl,
  });

  MessageModel.fromJson(dynamic json) {
    message = json['message'];
    time = json['time'];
    id = json['id'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['time'] = time;
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    return map;
  }

}