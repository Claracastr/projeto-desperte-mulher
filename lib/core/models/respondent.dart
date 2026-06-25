class Respondent {
  final String name;
  final String age;
  final String phone;
  final String city;
  final String state;

  const Respondent({
    required this.name,
    required this.age,
    required this.phone,
    required this.city,
    required this.state,
  });

  factory Respondent.empty() {
    return const Respondent(
      name: '',
      age: '',
      phone: '',
      city: '',
      state: '',
    );
  }

  bool get isIdentified => name.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phone': phone,
      'city': city,
      'state': state,
    };
  }

  factory Respondent.fromJson(Map<String, dynamic> json) {
    return Respondent(
      name: json['name'] as String? ?? '',
      age: json['age'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
    );
  }
}
