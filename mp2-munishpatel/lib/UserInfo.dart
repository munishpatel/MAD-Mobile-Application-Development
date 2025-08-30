class UserInfo {
  final String name;
  final String position;
  final String company;
  final String phone;
  final String email;
  final String address;
  final List<EducationInfo> education;
  final List<ExperienceInfo> experience; // Added experience list
  final List<ProjectInfo> projects;

  UserInfo({
    required this.name,
    required this.position,
    required this.company,
    required this.phone,
    required this.email,
    required this.address,
    required this.education,
    required this.experience, // Added to constructor
    required this.projects,
  });
}

class EducationInfo {
  final String logo;
  final String name;
  final double gpa;

  EducationInfo({
    required this.logo, 
    required this.name, 
    required this.gpa
  });
}

class ExperienceInfo {
  final String logo;
  final String name;
  final String position;
  final String duration;

  ExperienceInfo({
    required this.logo,
    required this.name,
    required this.position,
    required this.duration,
  });
}

class ProjectInfo {
  final String title;
  final String description;
  final String imagePath;

  ProjectInfo({
    required this.title, 
    required this.description, 
    required this.imagePath});
}