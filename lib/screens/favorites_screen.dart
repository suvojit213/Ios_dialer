import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Favorites',
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
          child: const Text(
            'Edit',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 17,
            ),
          ),
          onPressed: () {
            // Handle edit action
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Quick dial section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Dial',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _getQuickDialContacts().length,
                      itemBuilder: (context, index) {
                        final contact = _getQuickDialContacts()[index];
                        return _buildQuickDialItem(contact);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(
              color: CupertinoColors.systemGrey4,
              height: 1,
            ),
            
            // Favorites list
            Expanded(
              child: ListView.builder(
                itemCount: _getFavoriteContacts().length,
                itemBuilder: (context, index) {
                  final contact = _getFavoriteContacts()[index];
                  return _buildFavoriteItem(contact);
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

  Widget _buildQuickDialItem(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Make call
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: contact['color'],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  contact['name'][0].toUpperCase(),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 60,
            child: Text(
              contact['name'].split(' ')[0],
              style: const TextStyle(
                fontSize: 12,
                color: CupertinoColors.label,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(Map<String, dynamic> contact) {
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
        subtitle: Row(
          children: [
            const Icon(
              CupertinoIcons.star_fill,
              size: 14,
              color: CupertinoColors.systemYellow,
            ),
            const SizedBox(width: 4),
            Text(
              contact['label'],
              style: const TextStyle(
                fontSize: 15,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ],
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
                CupertinoIcons.videocam,
                color: CupertinoColors.systemGreen,
                size: 22,
              ),
              onPressed: () {
                // Video call
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getQuickDialContacts() {
    return [
      {
        'name': 'Mom',
        'number': '+91 98765 43210',
        'color': CupertinoColors.systemPink,
      },
      {
        'name': 'Dad',
        'number': '+91 87654 32109',
        'color': CupertinoColors.systemBlue,
      },
      {
        'name': 'Sarah',
        'number': '+91 76543 21098',
        'color': CupertinoColors.systemGreen,
      },
      {
        'name': 'John',
        'number': '+91 65432 10987',
        'color': CupertinoColors.systemOrange,
      },
      {
        'name': 'Emma',
        'number': '+91 54321 09876',
        'color': CupertinoColors.systemPurple,
      },
    ];
  }

  List<Map<String, dynamic>> _getFavoriteContacts() {
    return [
      {
        'name': 'Mom',
        'number': '+91 98765 43210',
        'label': 'mobile',
        'color': CupertinoColors.systemPink,
      },
      {
        'name': 'Dad',
        'number': '+91 87654 32109',
        'label': 'mobile',
        'color': CupertinoColors.systemBlue,
      },
      {
        'name': 'Sarah Wilson',
        'number': '+91 76543 21098',
        'label': 'work',
        'color': CupertinoColors.systemGreen,
      },
      {
        'name': 'John Doe',
        'number': '+91 65432 10987',
        'label': 'home',
        'color': CupertinoColors.systemOrange,
      },
      {
        'name': 'Emma Davis',
        'number': '+91 54321 09876',
        'label': 'mobile',
        'color': CupertinoColors.systemPurple,
      },
      {
        'name': 'Mike Johnson',
        'number': '+91 43210 98765',
        'label': 'work',
        'color': CupertinoColors.systemTeal,
      },
      {
        'name': 'Lisa Garcia',
        'number': '+91 32109 87654',
        'label': 'mobile',
        'color': CupertinoColors.systemIndigo,
      },
      {
        'name': 'Alex Brown',
        'number': '+91 21098 76543',
        'label': 'home',
        'color': CupertinoColors.systemRed,
      },
    ];
  }
}

