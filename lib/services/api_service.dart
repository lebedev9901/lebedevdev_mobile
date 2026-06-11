import 'package:dio/dio.dart';
import '../models/service.dart';
import '../models/projects.dart';

class ApiService {
  static const String baseUrl = 'http://lebedevdev.ru/api';

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Future<List<ServiceModel>> getServices() async {
  final response = await dio.get('/services');

    return (response.data as List)
        .map((e) => ServiceModel.fromJson(e))
        .toList();
  }

  Future<ServiceModel> getService(String slug) async{
    final response = await dio.get('/services/$slug');

    return ServiceModel.fromJson(response.data);
  } 

  Future<List<ProjectModel>> getProjects() async {
    final response = await dio.get('/projects');

    return (response.data as List)
        .map((item) => ProjectModel.fromJson(item))
        .toList();
  }

  Future<ProjectModel> getProject(String slug) async {
    final response = await dio.get('/projects/$slug');

    return ProjectModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getHome() async {
    final response = await dio.get('/home');

    return Map<String, dynamic>.from(response.data);
  }
  Future<void> sendCooperationBrief({
    required String name,
    required String contact,
    required String siteType,
    required String design,
    required List<String> features,
    required String description,
    required String budget,
    required String deadline,
    required String examples,
  }) async {
    final response = await dio.post(
      '/cooperation',
      data: {
        'name': name,
        'contact': contact,
        'site_type': siteType,
        'design': design,
        'features': features,
        'description': description,
        'budget': budget,
        'deadline': deadline,
        'examples': examples,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Не удалось отправить бриф');
    }
  }
}