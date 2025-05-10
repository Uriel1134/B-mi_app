class UserModel {
  String? id;
  String? name;
  String? email;
  int balance;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.balance = 0,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? balance,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
    );
  }

  void addPoints(int points) {
    balance += points;
  }
} 