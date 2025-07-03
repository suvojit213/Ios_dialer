import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class PhoneService {
  static const MethodChannel _channel = MethodChannel('phone_dialer/phone');

  /// Make a phone call to the given number
  static Future<bool> makeCall(String phoneNumber) async {
    try {
      // Clean the phone number
      final cleanNumber = _cleanPhoneNumber(phoneNumber);
      
      // Create the tel URI
      final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);
      
      // Check if the device can handle phone calls
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
        return true;
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      print('Error making call: $e');
      return false;
    }
  }

  /// Send SMS to the given number
  static Future<bool> sendSMS(String phoneNumber, [String? message]) async {
    try {
      final cleanNumber = _cleanPhoneNumber(phoneNumber);
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: cleanNumber,
        queryParameters: message != null ? {'body': message} : null,
      );
      
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        return true;
      } else {
        throw 'Could not launch SMS app';
      }
    } catch (e) {
      print('Error sending SMS: $e');
      return false;
    }
  }

  /// Check if the device supports phone calls
  static Future<bool> canMakePhoneCalls() async {
    try {
      final Uri testUri = Uri(scheme: 'tel', path: '');
      return await canLaunchUrl(testUri);
    } catch (e) {
      return false;
    }
  }

  /// Format phone number for display
  static String formatPhoneNumber(String phoneNumber) {
    final cleaned = _cleanPhoneNumber(phoneNumber);
    
    // Indian phone number formatting
    if (cleaned.startsWith('+91') && cleaned.length == 13) {
      return '+91 ${cleaned.substring(3, 8)} ${cleaned.substring(8)}';
    }
    
    // US phone number formatting
    if (cleaned.startsWith('+1') && cleaned.length == 12) {
      return '+1 (${cleaned.substring(2, 5)}) ${cleaned.substring(5, 8)}-${cleaned.substring(8)}';
    }
    
    // Default formatting for 10-digit numbers
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
    }
    
    return phoneNumber;
  }

  /// Clean phone number by removing non-digit characters except +
  static String _cleanPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  /// Validate phone number format
  static bool isValidPhoneNumber(String phoneNumber) {
    final cleaned = _cleanPhoneNumber(phoneNumber);
    
    // Check for common phone number patterns
    final patterns = [
      RegExp(r'^\+91\d{10}$'), // Indian format
      RegExp(r'^\+1\d{10}$'),  // US format
      RegExp(r'^\d{10}$'),     // 10-digit format
      RegExp(r'^\+\d{10,15}$'), // International format
    ];
    
    return patterns.any((pattern) => pattern.hasMatch(cleaned));
  }

  /// Get country code from phone number
  static String? getCountryCode(String phoneNumber) {
    final cleaned = _cleanPhoneNumber(phoneNumber);
    
    if (cleaned.startsWith('+91')) return 'IN';
    if (cleaned.startsWith('+1')) return 'US';
    if (cleaned.startsWith('+44')) return 'GB';
    if (cleaned.startsWith('+49')) return 'DE';
    if (cleaned.startsWith('+33')) return 'FR';
    
    return null;
  }

  /// Add haptic feedback for dialer buttons
  static void addHapticFeedback() {
    HapticFeedback.lightImpact();
  }

  /// Add selection haptic feedback
  static void addSelectionFeedback() {
    HapticFeedback.selectionClick();
  }
}

