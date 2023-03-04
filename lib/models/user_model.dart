class UserModel {
  int? id;
  String? name;
  String? nopol;
  // late String username;
  int? point;
  String? token;
  String? profilePhotoUrl;

  UserModel({
    this.id,
    this.name,
    this.nopol,
    // required this.username,t1234jrr
    this.point,
    this.token,
    this.profilePhotoUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nopol = json['nopol'];
    // username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nopol': nopol,
      // 'username':  username,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
      'point': point,
    };
  }
}
