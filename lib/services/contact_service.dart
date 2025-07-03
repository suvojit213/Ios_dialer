import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/contact.dart';

class ContactService {
  static const MethodChannel _channel = MethodChannel('phone_dialer/contacts');
  
  // Mock data for demonstration
  static final List<Contact> _mockContacts = [
    Contact(
      id: '1',
      name: 'Alice Johnson',
      phoneNumber: '+91 98765 43210',
      email: 'alice@example.com',
      isFavorite: true,
      label: 'mobile',
    ),
    Contact(
      id: '2',
      name: 'Bob Smith',
      phoneNumber: '+91 87654 32109',
      email: 'bob@example.com',
      isFavorite: false,
      label: 'work',
    ),
    Contact(
      id: '3',
      name: 'Charlie Brown',
      phoneNumber: '+91 76543 21098',
      email: 'charlie@example.com',
      isFavorite: true,
      label: 'home',
    ),
    Contact(
      id: '4',
      name: 'Diana Prince',
      phoneNumber: '+91 65432 10987',
      email: 'diana@example.com',
      isFavorite: false,
      label: 'mobile',
    ),
    Contact(
      id: '5',
      name: 'Edward Norton',
      phoneNumber: '+91 54321 09876',
      email: 'edward@example.com',
      isFavorite: true,
      label: 'work',
    ),
    Contact(
      id: '6',
      name: 'Fiona Apple',
      phoneNumber: '+91 43210 98765',
      email: 'fiona@example.com',
      isFavorite: false,
      label: 'mobile',
    ),
    Contact(
      id: '7',
      name: 'George Lucas',
      phoneNumber: '+91 32109 87654',
      email: 'george@example.com',
      isFavorite: true,
      label: 'home',
    ),
    Contact(
      id: '8',
      name: 'Helen Mirren',
      phoneNumber: '+91 21098 76543',
      email: 'helen@example.com',
      isFavorite: false,
      label: 'mobile',
    ),
  ];

  /// Get all contacts
  static Future<List<Contact>> getAllContacts() async {
    try {
      // In a real app, this would fetch from device contacts
      // For now, return mock data
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      return List.from(_mockContacts);
    } catch (e) {
      print('Error fetching contacts: $e');
      return [];
    }
  }

  /// Get favorite contacts
  static Future<List<Contact>> getFavoriteContacts() async {
    try {
      final contacts = await getAllContacts();
      return contacts.where((contact) => contact.isFavorite).toList();
    } catch (e) {
      print('Error fetching favorite contacts: $e');
      return [];
    }
  }

  /// Search contacts by name or phone number
  static Future<List<Contact>> searchContacts(String query) async {
    try {
      final contacts = await getAllContacts();
      final lowercaseQuery = query.toLowerCase();
      
      return contacts.where((contact) {
        return contact.name.toLowerCase().contains(lowercaseQuery) ||
               contact.phoneNumber.contains(query);
      }).toList();
    } catch (e) {
      print('Error searching contacts: $e');
      return [];
    }
  }

  /// Get contact by phone number
  static Future<Contact?> getContactByPhoneNumber(String phoneNumber) async {
    try {
      final contacts = await getAllContacts();
      return contacts.firstWhere(
        (contact) => contact.phoneNumber.replaceAll(RegExp(r'[^\d+]'), '') ==
                    phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
        orElse: () => throw StateError('Contact not found'),
      );
    } catch (e) {
      return null;
    }
  }

  /// Add contact to favorites
  static Future<bool> addToFavorites(String contactId) async {
    try {
      final index = _mockContacts.indexWhere((c) => c.id == contactId);
      if (index != -1) {
        _mockContacts[index] = _mockContacts[index].copyWith(isFavorite: true);
        return true;
      }
      return false;
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  /// Remove contact from favorites
  static Future<bool> removeFromFavorites(String contactId) async {
    try {
      final index = _mockContacts.indexWhere((c) => c.id == contactId);
      if (index != -1) {
        _mockContacts[index] = _mockContacts[index].copyWith(isFavorite: false);
        return true;
      }
      return false;
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  /// Create new contact
  static Future<Contact?> createContact({
    required String name,
    required String phoneNumber,
    String? email,
    String label = 'mobile',
  }) async {
    try {
      final newContact = Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        label: label,
      );
      
      _mockContacts.add(newContact);
      return newContact;
    } catch (e) {
      print('Error creating contact: $e');
      return null;
    }
  }

  /// Update existing contact
  static Future<bool> updateContact(Contact contact) async {
    try {
      final index = _mockContacts.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        _mockContacts[index] = contact;
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating contact: $e');
      return false;
    }
  }

  /// Delete contact
  static Future<bool> deleteContact(String contactId) async {
    try {
      _mockContacts.removeWhere((c) => c.id == contactId);
      return true;
    } catch (e) {
      print('Error deleting contact: $e');
      return false;
    }
  }

  /// Get contact initials for avatar
  static String getContactInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '?';
    
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
  }

  /// Sort contacts alphabetically
  static List<Contact> sortContactsAlphabetically(List<Contact> contacts) {
    final sortedContacts = List<Contact>.from(contacts);
    sortedContacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return sortedContacts;
  }
}

