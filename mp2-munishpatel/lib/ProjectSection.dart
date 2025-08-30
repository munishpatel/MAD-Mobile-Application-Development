import 'package:cs442_mp2/UserInfo.dart';
import 'package:flutter/material.dart';

class ProjectSection extends StatelessWidget {
  final List<ProjectInfo> projects;

  ProjectSection({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[100], // Background color for the whole container
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16), // Padding inside the container to add spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 16), // Space between the heading and the grid content
          
          // Grid of projects
          GridView.builder(
            physics: NeverScrollableScrollPhysics(), // Disable scrolling since it's in a ScrollView
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 projects per row
              crossAxisSpacing: 10, // Space between columns
              mainAxisSpacing: 10,  // Space between rows
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey, // Background color for each card
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    // Background image
                    Expanded(
                      child: Image.asset(
                        projects[index].imagePath,
                        fit: BoxFit.cover,  
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        projects[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
