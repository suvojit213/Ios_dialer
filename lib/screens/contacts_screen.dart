import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredContacts = _getContacts()
        .where((contact) => contact['name']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Contacts',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: CupertinoColors.systemBackground,
        border: const Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.add,
            color: CupertinoColors.systemBlue,
            size: 24,
          ),
          onPressed: () {
            // Handle add contact
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(16),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search contacts',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.label,
                ),
              ),
            ),
            
            // Contacts list
            Expanded(
              child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  return _buildContactItem(contact);
                },
              ),
            ),
            
            // Footer
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Developed by Suvojeet',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 0.5,
          ),
        ),
      ),
      child: CupertinoListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: contact['color'],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              contact['name'][0].toUpperCase(),
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        title: Text(
          contact['name'],
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: CupertinoColors.label,
          ),
        ),
        subtitle: Text(
          contact['number'],
          style: const TextStyle(
            fontSize: 15,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.phone,
                color: CupertinoColors.systemBlue,
                size: 22,
              ),
              onPressed: () {
                // Make call
              },
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.chat_bubble,
                color: CupertinoColors.systemGreen,
                size: 22,
              ),
              onPressed: () {
                // Send message
              },
            ),
          ],
        ),
        onTap: () {
          // Show contact details
          _showContactDetails(contact);
        },
      ),
    );
  }

  void _showContactDetails(Map<String, dynamic> contact) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          contact['name'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        message: Text(
          contact['number'],
          style: const TextStyle(
            fontSize: 16,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Make call
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.phone,
                  color: CupertinoColors.systemBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Call',
                  style: TextStyle(
                    color: CupertinoColors.systemBlue,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Send message
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.chat_bubble,
                  color: CupertinoColors.systemGreen,
                ),
                SizedBox(width: 8),
                Text(
                  'Message',
                  style: TextStyle(
                    color: CupertinoColors.systemGreen,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Edit contact
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.pencil,
                  color: CupertinoColors.systemBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: CupertinoColors.systemBlue,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getContacts() {
    return [
      {
        'name': 'Alice Johnson',
        'number': '+91 98765 43210',
        'color': CupertinoColors.systemBlue,
      },
      {
        'name': 'Bob Smith',
        'number': '+91 87654 32109',
        'color': CupertinoColors.systemGreen,
      },
      {
        'name': 'Charlie Brown',
        'number': '+91 76543 21098',
        'color': CupertinoColors.systemOrange,
      },
      {
        'name': 'Diana Prince',
        'number': '+91 65432 10987',
        'color': CupertinoColors.systemPurple,
      },
      {
        'name': 'Edward Norton',
        'number': '+91 54321 09876',
        'color': CupertinoColors.systemRed,
      },
      {
        'name': 'Fiona Apple',
        'number': '+91 43210 98765',
        'color': CupertinoColors.systemTeal,
      },
      {
        'name': 'George Lucas',
        'number': '+91 32109 87654',
        'color': CupertinoColors.systemIndigo,
      },
      {
        'name': 'Helen Mirren',
        'number': '+91 21098 76543',
        'color': CupertinoColors.systemPink,
      },
      {
        'name': 'Ian McKellen',
        'number': '+91 10987 65432',
        'color': CupertinoColors.systemYellow,
      },
      {
        'name': 'Julia Roberts',
        'number': '+91 09876 54321',
        'color': CupertinoColors.systemBlue,
      },
    ];
  }
}

