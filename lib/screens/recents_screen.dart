import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Recents',
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
            // All/Missed toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.systemGrey5,
                thumbColor: CupertinoColors.systemBackground,
                groupValue: 0,
                children: const {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'Missed',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  // Handle segment change
                },
              ),
            ),
            
            // Call history list
            Expanded(
              child: ListView.builder(
                itemCount: _getRecentCalls().length,
                itemBuilder: (context, index) {
                  final call = _getRecentCalls()[index];
                  return _buildCallItem(call);
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

  Widget _buildCallItem(Map<String, dynamic> call) {
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
            color: call['color'],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              call['name'][0].toUpperCase(),
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        title: Text(
          call['name'],
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: CupertinoColors.label,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              call['type'] == 'incoming' 
                  ? CupertinoIcons.arrow_down_left
                  : call['type'] == 'outgoing'
                      ? CupertinoIcons.arrow_up_right
                      : CupertinoIcons.phone_down_fill,
              size: 16,
              color: call['type'] == 'missed' 
                  ? CupertinoColors.systemRed 
                  : CupertinoColors.systemGrey,
            ),
            const SizedBox(width: 4),
            Text(
              call['time'],
              style: const TextStyle(
                fontSize: 15,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.info_circle,
            color: CupertinoColors.systemBlue,
            size: 22,
          ),
          onPressed: () {
            // Show call details
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getRecentCalls() {
    return [
      {
        'name': 'John Doe',
        'number': '+91 98765 43210',
        'time': '2 minutes ago',
        'type': 'incoming',
        'color': CupertinoColors.systemBlue,
      },
      {
        'name': 'Sarah Wilson',
        'number': '+91 87654 32109',
        'time': '15 minutes ago',
        'type': 'outgoing',
        'color': CupertinoColors.systemGreen,
      },
      {
        'name': 'Mike Johnson',
        'number': '+91 76543 21098',
        'time': '1 hour ago',
        'type': 'missed',
        'color': CupertinoColors.systemRed,
      },
      {
        'name': 'Emma Davis',
        'number': '+91 65432 10987',
        'time': '2 hours ago',
        'type': 'incoming',
        'color': CupertinoColors.systemPurple,
      },
      {
        'name': 'Alex Brown',
        'number': '+91 54321 09876',
        'time': 'Yesterday',
        'type': 'outgoing',
        'color': CupertinoColors.systemOrange,
      },
      {
        'name': 'Lisa Garcia',
        'number': '+91 43210 98765',
        'time': 'Yesterday',
        'type': 'incoming',
        'color': CupertinoColors.systemTeal,
      },
      {
        'name': 'David Miller',
        'number': '+91 32109 87654',
        'time': '2 days ago',
        'type': 'missed',
        'color': CupertinoColors.systemIndigo,
      },
      {
        'name': 'Jennifer Taylor',
        'number': '+91 21098 76543',
        'time': '3 days ago',
        'type': 'outgoing',
        'color': CupertinoColors.systemPink,
      },
    ];
  }
}

