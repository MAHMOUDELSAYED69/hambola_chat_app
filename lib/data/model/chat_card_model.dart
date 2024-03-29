class ChatCardModel {
  final String email;
  final String uid;
  final String? image;
  final String? name;
  final bool isFriend;

  ChatCardModel(
      {this.image,
      this.name,
      required this.email,
      required this.uid,
      required this.isFriend});

  factory ChatCardModel.fromJson(dynamic jsonData) {
    return ChatCardModel(
        email: jsonData['email'],
        uid: jsonData['uid'],
        image: jsonData['image'],
        name: jsonData['name'],
        isFriend: jsonData['isFriend']);
  }
}
