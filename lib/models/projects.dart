class ProjectFileModel {
  final int id;
  final String name;
  final String url;

  ProjectFileModel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory ProjectFileModel.fromJson(Map<String, dynamic> json) {
    return ProjectFileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class ProjectModel {
  final int id;
  final String title;
  final String slug;
  final String subtitle;
  final String shortDescription;
  final String description;
  final String status;
  final List<String> technologies;
  final String? image;
  final List<ProjectFileModel> files;

  ProjectModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.subtitle,
    required this.shortDescription,
    required this.description,
    required this.status,
    required this.technologies,
    this.image,
    required this.files,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      subtitle: json['subtitle'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      technologies: json['technologies'] is List
          ? List<String>.from(json['technologies'])
          : [],
      image: json['image'],
      files: json['files'] is List
          ? (json['files'] as List)
              .map((e) => ProjectFileModel.fromJson(e))
              .toList()
          : [],
    );
  }
}