enum CallType {
  incoming,
  outgoing,
  missed,
}

class CallLog {
  final String id;
  final String name;
  final String phoneNumber;
  final CallType callType;
  final DateTime timestamp;
  final int duration; // in seconds
  final String? contactId;

  CallLog({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.callType,
    required this.timestamp,
    this.duration = 0,
    this.contactId,
  });

  CallLog copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    CallType? callType,
    DateTime? timestamp,
    int? duration,
    String? contactId,
  }) {
    return CallLog(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      callType: callType ?? this.callType,
      timestamp: timestamp ?? this.timestamp,
      duration: duration ?? this.duration,
      contactId: contactId ?? this.contactId,
    );
  }

  String get formattedDuration {
    if (duration == 0) return '';
    
    final hours = duration ~/ 3600;
    final minutes = (duration % 3600) ~/ 60;
    final seconds = duration % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'callType': callType.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'duration': duration,
      'contactId': contactId,
    };
  }

  factory CallLog.fromJson(Map<String, dynamic> json) {
    return CallLog(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      callType: CallType.values.firstWhere(
        (e) => e.toString().split('.').last == json['callType'],
      ),
      timestamp: DateTime.parse(json['timestamp']),
      duration: json['duration'] ?? 0,
      contactId: json['contactId'],
    );
  }

  @override
  String toString() {
    return 'CallLog(id: $id, name: $name, phoneNumber: $phoneNumber, callType: $callType, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CallLog && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

