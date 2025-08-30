import 'package:cs442_mp2/UserInfo.dart';
import 'package:flutter/material.dart';

class UserProfileHeader extends StatelessWidget {
  final UserInfo userInfo;

  UserProfileHeader({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16), // Adds padding inside the background
      decoration: BoxDecoration(
        color: Colors.orange[100], // Background color
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(12.0), // Rounded corners for the border
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile_pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrapped text for user name
                Text(
                  userInfo.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2, // Allow text to wrap if it's too long
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  userInfo.position,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  userInfo.company,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
