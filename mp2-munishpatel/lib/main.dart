import 'package:cs442_mp2/UserInfo.dart';
import 'package:cs442_mp2/UserProfileApp.dart';
import 'package:flutter/material.dart';

void main() {
  
UserInfo user = UserInfo(
    name: 'Munish Patel',
    position: 'Software Developer',
    company: 'Apple California',
    phone: '(970) 833-1513',
    email: 'mpatel176@hawk.iit.edu',
    address: '3335 S Indiana Ave, Chicago, Illinois. 60616',
    education: [
      EducationInfo(
        logo: 'assets/images/iit.png',
        name: 'Illinois institute of Technology',
        gpa: 3.50,
      ),
      EducationInfo(
        logo: 'assets/images/srm.png',
        name: 'SRM University',
        gpa: 3.92,
      ),
    ],
    experience: [
      ExperienceInfo(
        logo: 'assets/images/tcs.png',
        name: 'Tata Consultancy Services',
        position: 'Software Developer',
        duration: 'June 2022 - May 2023',
      ),
      ExperienceInfo(
        logo: 'assets/images/innover.jpeg',
        name: 'Innover Digital',
        position: 'Associate Software Developer',
        duration: 'June 2021 - May 2022',
      ),
    ],
    projects: [
      ProjectInfo(
        title: 'Merchandise Project ',
        description: 'A Multi-Cloud Devops & AI Application.',
        imagePath: 'assets/images/multi_cloud.jpeg'
      ),
      ProjectInfo(
        title: 'SmartHomes Web App',
        description: 'A web application that helps to control the home appliances.',
        imagePath: 'assets/images/smarthomes.jpeg'
      ),
      ProjectInfo(
        title: 'Payment Date ',
        description: 'A Payment date prediction model with age buckets.',
        imagePath: 'assets/images/payment_date.jpeg'
      ),
      ProjectInfo(
        title: 'COPD Prediction',
        description: ' A Machine Learning model that predicts the COPD disease.',
        imagePath: 'assets/images/copd.jpeg'
      ),
    ],
  );

  runApp(UserProfileApp(userInfo: user));
}
