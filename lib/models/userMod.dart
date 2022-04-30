class userMod {
  String id;
  String name;
  String profile;
  userMod({required this.id, required this.name, required this.profile});
  static userMod fromJson(Map<String, dynamic> json) {
    return userMod(
      name: json['name'],
      id: json['id'],
      profile: json['profile'],
    );
    print('MODUSSSS*');
  }
}
