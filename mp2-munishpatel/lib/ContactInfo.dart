import 'package:cs442_mp2/UserInfo.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  final UserInfo userInfo;

  ContactInfo({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.cyan[100],
        border: Border.all(
          color: Colors.white,
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(12.0),
      ), 
      child: Column(
        children: [
          ContactInfoRow(icon: Icons.phone, info: userInfo.phone),
          ContactInfoRow(icon: Icons.email, info: userInfo.email),
          ContactInfoRow(icon: Icons.home, info: userInfo.address),
        ],
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String info;

  ContactInfoRow({required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 8),
          Text(
            info,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
