import 'package:cs442_mp2/UserInfo.dart';
import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  final List<ExperienceInfo> experience;

  ExperienceSection({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0), 
      decoration: BoxDecoration(
        color: Colors.red[100],
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Experience',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 16), 
          Column(
            children: experience.map((exp) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(exp.logo, width: 40, height: 40),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                            Text(
                              exp.position,
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      exp.duration,
                      style: TextStyle(fontSize: 14, color: Colors.black),
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
