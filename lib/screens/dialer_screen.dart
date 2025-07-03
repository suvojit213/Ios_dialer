import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DialerScreen extends StatefulWidget {
  const DialerScreen({super.key});

  @override
  State<DialerScreen> createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> {
  String _phoneNumber = '';

  void _addDigit(String digit) {
    setState(() {
      _phoneNumber += digit;
    });
    HapticFeedback.lightImpact();
  }

  void _deleteDigit() {
    if (_phoneNumber.isNotEmpty) {
      setState(() {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      });
      HapticFeedback.lightImpact();
    }
  }

  void _makeCall() async {
    if (_phoneNumber.isNotEmpty) {
      final Uri phoneUri = Uri(scheme: 'tel', path: _phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Keypad',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: CupertinoColors.systemBackground,
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Phone Number Display
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _phoneNumber.isEmpty ? 'Enter number' : _phoneNumber,
                      style: TextStyle(
                        fontSize: _phoneNumber.length > 12 ? 28 : 36,
                        fontWeight: FontWeight.w300,
                        color: _phoneNumber.isEmpty 
                            ? CupertinoColors.systemGrey 
                            : CupertinoColors.label,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_phoneNumber.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            CupertinoIcons.phone_fill,
                            color: CupertinoColors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: _makeCall,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Keypad
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  children: [
                    // Row 1: 1, 2, 3
                    Expanded(
                      child: Row(
                        children: [
                          _buildKeypadButton('1', ''),
                          _buildKeypadButton('2', 'ABC'),
                          _buildKeypadButton('3', 'DEF'),
                        ],
                      ),
                    ),
                    // Row 2: 4, 5, 6
                    Expanded(
                      child: Row(
                        children: [
                          _buildKeypadButton('4', 'GHI'),
                          _buildKeypadButton('5', 'JKL'),
                          _buildKeypadButton('6', 'MNO'),
                        ],
                      ),
                    ),
                    // Row 3: 7, 8, 9
                    Expanded(
                      child: Row(
                        children: [
                          _buildKeypadButton('7', 'PQRS'),
                          _buildKeypadButton('8', 'TUV'),
                          _buildKeypadButton('9', 'WXYZ'),
                        ],
                      ),
                    ),
                    // Row 4: *, 0, #
                    Expanded(
                      child: Row(
                        children: [
                          _buildKeypadButton('*', ''),
                          _buildKeypadButton('0', '+'),
                          _buildKeypadButton('#', ''),
                        ],
                      ),
                    ),
                    // Row 5: Delete button
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _phoneNumber.isNotEmpty ? _deleteDigit : null,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: _phoneNumber.isNotEmpty 
                                      ? CupertinoColors.systemGrey5 
                                      : CupertinoColors.systemGrey6,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  CupertinoIcons.delete_left,
                                  color: _phoneNumber.isNotEmpty 
                                      ? CupertinoColors.label 
                                      : CupertinoColors.systemGrey3,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

  Widget _buildKeypadButton(String number, String letters) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _addDigit(number),
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: CupertinoColors.systemGrey5,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: CupertinoColors.label,
                  ),
                ),
                if (letters.isNotEmpty)
                  Text(
                    letters,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.secondaryLabel,
                      letterSpacing: 1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

