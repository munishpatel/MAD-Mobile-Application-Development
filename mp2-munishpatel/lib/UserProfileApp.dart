import 'package:cs442_mp2/ContactInfo.dart';
import 'package:cs442_mp2/EducationSection.dart';
import 'package:cs442_mp2/ExperienceSection.dart'; // Import ExperienceSection
import 'package:cs442_mp2/ProjectSection.dart';
import 'package:cs442_mp2/UserInfo.dart';
import 'package:cs442_mp2/UserProfileHeader.dart';
import 'package:flutter/material.dart';

class UserProfileApp extends StatelessWidget {
  final UserInfo userInfo;

  UserProfileApp({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 125, 182, 210),
        appBar: AppBar(title: Text('${userInfo.name}\'s Profile')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileHeader(userInfo: userInfo),
                SizedBox(height: 16),
                ContactInfo(userInfo: userInfo),
                SizedBox(height: 16),
                EducationSection(education: userInfo.education),
                SizedBox(height: 16),
                ExperienceSection(experience: userInfo.experience), // Added Experience Section
                SizedBox(height: 16),
                ProjectSection(projects: userInfo.projects),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

