class UserData {
  static final UserData _userData = new UserData._internal();

  String username = '';

  factory UserData() {
    return _userData;
  }

  UserData._internal();
}

final userData = UserData();
