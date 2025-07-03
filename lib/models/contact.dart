class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String? photoUrl;
  final bool isFavorite;
  final String label; // mobile, work, home, etc.

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.photoUrl,
    this.isFavorite = false,
    this.label = 'mobile',
  });

  Contact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? photoUrl,
    bool? isFavorite,
    String? label,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'photoUrl': photoUrl,
      'isFavorite': isFavorite,
      'label': label,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      isFavorite: json['isFavorite'] ?? false,
      label: json['label'] ?? 'mobile',
    );
  }

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, phoneNumber: $phoneNumber, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contact && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

