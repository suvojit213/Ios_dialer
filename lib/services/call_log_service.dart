import '../models/call_log.dart';

class CallLogService {
  // Mock data for demonstration
  static final List<CallLog> _mockCallLogs = [
    CallLog(
      id: '1',
      name: 'John Doe',
      phoneNumber: '+91 98765 43210',
      callType: CallType.incoming,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      duration: 120,
      contactId: '1',
    ),
    CallLog(
      id: '2',
      name: 'Sarah Wilson',
      phoneNumber: '+91 87654 32109',
      callType: CallType.outgoing,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      duration: 300,
      contactId: '2',
    ),
    CallLog(
      id: '3',
      name: 'Mike Johnson',
      phoneNumber: '+91 76543 21098',
      callType: CallType.missed,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      duration: 0,
      contactId: '3',
    ),
    CallLog(
      id: '4',
      name: 'Emma Davis',
      phoneNumber: '+91 65432 10987',
      callType: CallType.incoming,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      duration: 180,
      contactId: '4',
    ),
    CallLog(
      id: '5',
      name: 'Alex Brown',
      phoneNumber: '+91 54321 09876',
      callType: CallType.outgoing,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      duration: 450,
      contactId: '5',
    ),
    CallLog(
      id: '6',
      name: 'Lisa Garcia',
      phoneNumber: '+91 43210 98765',
      callType: CallType.incoming,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      duration: 90,
      contactId: '6',
    ),
    CallLog(
      id: '7',
      name: 'David Miller',
      phoneNumber: '+91 32109 87654',
      callType: CallType.missed,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      duration: 0,
      contactId: '7',
    ),
    CallLog(
      id: '8',
      name: 'Jennifer Taylor',
      phoneNumber: '+91 21098 76543',
      callType: CallType.outgoing,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      duration: 600,
      contactId: '8',
    ),
  ];

  /// Get all call logs
  static Future<List<CallLog>> getAllCallLogs() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate delay
      return List.from(_mockCallLogs)..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } catch (e) {
      print('Error fetching call logs: $e');
      return [];
    }
  }

  /// Get missed calls only
  static Future<List<CallLog>> getMissedCalls() async {
    try {
      final allLogs = await getAllCallLogs();
      return allLogs.where((log) => log.callType == CallType.missed).toList();
    } catch (e) {
      print('Error fetching missed calls: $e');
      return [];
    }
  }

  /// Get call logs for a specific contact
  static Future<List<CallLog>> getCallLogsForContact(String contactId) async {
    try {
      final allLogs = await getAllCallLogs();
      return allLogs.where((log) => log.contactId == contactId).toList();
    } catch (e) {
      print('Error fetching call logs for contact: $e');
      return [];
    }
  }

  /// Add new call log entry
  static Future<bool> addCallLog({
    required String name,
    required String phoneNumber,
    required CallType callType,
    int duration = 0,
    String? contactId,
  }) async {
    try {
      final newLog = CallLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phoneNumber: phoneNumber,
        callType: callType,
        timestamp: DateTime.now(),
        duration: duration,
        contactId: contactId,
      );
      
      _mockCallLogs.insert(0, newLog); // Add to beginning for recent first
      return true;
    } catch (e) {
      print('Error adding call log: $e');
      return false;
    }
  }

  /// Delete call log entry
  static Future<bool> deleteCallLog(String logId) async {
    try {
      _mockCallLogs.removeWhere((log) => log.id == logId);
      return true;
    } catch (e) {
      print('Error deleting call log: $e');
      return false;
    }
  }

  /// Clear all call logs
  static Future<bool> clearAllCallLogs() async {
    try {
      _mockCallLogs.clear();
      return true;
    } catch (e) {
      print('Error clearing call logs: $e');
      return false;
    }
  }

  /// Get call statistics
  static Future<Map<String, int>> getCallStatistics() async {
    try {
      final allLogs = await getAllCallLogs();
      
      int totalCalls = allLogs.length;
      int incomingCalls = allLogs.where((log) => log.callType == CallType.incoming).length;
      int outgoingCalls = allLogs.where((log) => log.callType == CallType.outgoing).length;
      int missedCalls = allLogs.where((log) => log.callType == CallType.missed).length;
      
      int totalDuration = allLogs.fold(0, (sum, log) => sum + log.duration);
      
      return {
        'totalCalls': totalCalls,
        'incomingCalls': incomingCalls,
        'outgoingCalls': outgoingCalls,
        'missedCalls': missedCalls,
        'totalDuration': totalDuration,
      };
    } catch (e) {
      print('Error getting call statistics: $e');
      return {};
    }
  }

  /// Search call logs by name or number
  static Future<List<CallLog>> searchCallLogs(String query) async {
    try {
      final allLogs = await getAllCallLogs();
      final lowercaseQuery = query.toLowerCase();
      
      return allLogs.where((log) {
        return log.name.toLowerCase().contains(lowercaseQuery) ||
               log.phoneNumber.contains(query);
      }).toList();
    } catch (e) {
      print('Error searching call logs: $e');
      return [];
    }
  }

  /// Get recent calls (last 24 hours)
  static Future<List<CallLog>> getRecentCalls() async {
    try {
      final allLogs = await getAllCallLogs();
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      
      return allLogs.where((log) => log.timestamp.isAfter(yesterday)).toList();
    } catch (e) {
      print('Error fetching recent calls: $e');
      return [];
    }
  }

  /// Group call logs by date
  static Map<String, List<CallLog>> groupCallLogsByDate(List<CallLog> callLogs) {
    final Map<String, List<CallLog>> grouped = {};
    
    for (final log in callLogs) {
      final dateKey = _getDateKey(log.timestamp);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(log);
    }
    
    return grouped;
  }

  static String _getDateKey(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final logDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (logDate == today) {
      return 'Today';
    } else if (logDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}

