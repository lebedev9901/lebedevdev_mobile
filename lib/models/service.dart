class ServiceModel {
  final int id;
  final String title;
  final String? subtitle;
  final String slug;
  final String shortDescription;
  final String description;
  final String? icon;
  final List<String> advantages;
  final List<String> stages;
  final String? status;

  ServiceModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.slug,
    required this.shortDescription,
    required this.description,
    this.icon,
    this.status,
    this.advantages = const [],
    this.stages = const [],
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      slug: json['slug'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'],
      status: json['status'],
      advantages: List<String>.from(json['advantages'] ?? []),
      stages: List<String>.from(json['stages'] ?? []),
    );
  }
}