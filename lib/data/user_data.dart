class User {
  final String name;
  final String username;
  final String phoneNumber;
  final String gender;
  final String password;
  final String profileImage;

  User({
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.gender,
    required this.password,
    required this.profileImage,
  });
}

List<User> users = [
  User(
    name: 'Test',
    username: 'test000',
    phoneNumber: '08******',
    gender: 'Female',
    password: '12345',
    profileImage: '',
  ),
  User(
    name: 'Kevin Joy Nasserino',
    username: 'kevin123',
    phoneNumber: '081356272256',
    gender: 'Male',
    password: 'kevinpass',
    profileImage: 'assets/kevin.jpg',
  ),
  User(
    name: 'Yessy Arye',
    username: 'yessy456',
    phoneNumber: '08******',
    gender: 'Female',
    password: 'yessypass',
    profileImage: 'assets/yessy.jpg',
  ),
  // Add more users here as needed
];

class LoggedInUser {
  static User? user;
}