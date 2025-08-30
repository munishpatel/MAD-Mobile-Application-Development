import 'package:cs442_mp2/UserInfo.dart';
import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  final List<EducationInfo> education;

  EducationSection({required this.education});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.green[100],
        border: Border.all(
          color: Colors.white, 
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Education',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),

          const SizedBox(height: 16), // Space between the heading and content
          Column(
            children: education.map((edu) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0), // Adds vertical padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(edu.logo, width: 40, height: 40),
                        SizedBox(width: 8),
                        Text(
                          edu.name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      '${edu.gpa} GPA',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
