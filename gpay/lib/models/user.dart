
class User {

  final String email;

  final String name;

  final String photoUrl;

  final String phone;

  final String id;



  User({

    required this.email,

    required this.name,

    required this.photoUrl,

    required this.phone,

    required this.id,

  });



  factory User.fromJson(Map<String, dynamic> json) {

    return User(

      email: json['email'] ?? '',

      name: json['name'] ?? '',

      photoUrl: json['photoUrl'] ?? '',

      phone: json['phone'] ?? '',

      id: json['id'] ?? '',

    );

  }



  Map<String, dynamic> toJson() {

    return {

      'email': email,

      'name': name,

      'photoUrl': photoUrl,

      'phone': phone,

      'id': id,

    };

  }
}