import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/service.dart';
import 'models/projects.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const LebedevDevApp());
}

class LebedevDevApp extends StatelessWidget {
  const LebedevDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LebedevDev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020617),
        primaryColor: const Color(0xFF38BDF8),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF0EA5E9),
          surface: Color(0xFF0F172A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF020617),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF0F172A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF020617),
          indicatorColor: const Color(0xFF38BDF8).withOpacity(0.18),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  
  final screens = const [
    HomeScreen(),
    ServicesScreen(),
    ProjectsScreen(),
    CooperationScreen(),
  ];

  void goToTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: goToTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.design_services_outlined),
            selectedIcon: Icon(Icons.design_services),
            label: 'Услуги',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Проекты',
          ),
          NavigationDestination(
            icon: Icon(Icons.send_outlined),
            selectedIcon: Icon(Icons.send),
            label: 'Заявка',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();

  late Future<Map<String, dynamic>> homeFuture;

  @override
  void initState() {
    super.initState();
    homeFuture = api.getHome();
  }

  void _goToTab(BuildContext context, int index) {
    context.findAncestorStateOfType<_MainScreenState>()?.goToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFF1E293B)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF38BDF8).withOpacity(0.12),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LebedevDev',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Разработка сайтов, мобильных приложений и digital-решений под бизнес.',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  '{ Laravel • Flutter • API }',
                  style: TextStyle(
                    color: Color(0xFF38BDF8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Почему со мной',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 14),

          const _HomeBenefitCard(
            title: 'Делаю под задачу бизнеса',
            text:
                'Не просто рисую страницы, а собираю решение, которое помогает получать заявки и клиентов.',
          ),
          const _HomeBenefitCard(
            title: 'Backend + Frontend + Mobile',
            text:
                'Могу закрыть проект полностью: сайт, API, админка, мобильное приложение и деплой.',
          ),
          const _HomeBenefitCard(
            title: 'Запуск и поддержка',
            text:
                'Помогаю не только разработать проект, но и довести его до запуска.',
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                _goToTab(context, 3);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF38BDF8),
                foregroundColor: const Color(0xFF020617),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Обсудить проект',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Что делаю',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 14),

          const _HomeFeatureCard(
            icon: Icons.language,
            title: 'Сайты и веб-сервисы',
            text:
                'Корпоративные сайты, каталоги, интернет-магазины и личные кабинеты.',
          ),
          const _HomeFeatureCard(
            icon: Icons.phone_android,
            title: 'Мобильные приложения',
            text:
                'Приложения на Flutter для Android и iOS с подключением к backend.',
          ),
          const _HomeFeatureCard(
            icon: Icons.api,
            title: 'API и интеграции',
            text:
                'Интеграции с VK, CRM, оплатами, уведомлениями и внешними сервисами.',
          ),

          const SizedBox(height: 28),

          FutureBuilder<Map<String, dynamic>>(
            future: homeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.redAccent),
                );
              }

              final data = snapshot.data ?? {};

              final services = (data['services'] as List? ?? [])
                  .map((e) => ServiceModel.fromJson(e))
                  .toList();

              final projects = (data['projects'] as List? ?? [])
                  .map((e) => ProjectModel.fromJson(e))
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeSectionHeader(
                    title: 'Услуги',
                    buttonText: 'Все услуги',
                    onTap: () {
                      _goToTab(context, 1);
                    },
                  ),

                  const SizedBox(height: 12),

                  ...services.take(3).map((service) {
                    return _HomeSmallCard(
                      title: service.title,
                      text: service.shortDescription,
                      icon: service.icon ?? '{}',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(
                              slug: service.slug,
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  const SizedBox(height: 28),

                  _HomeSectionHeader(
                    title: 'Проекты',
                    buttonText: 'Все проекты',
                    onTap: () {
                      _goToTab(context, 2);
                    },
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 290,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: projects.take(3).length,
                      itemBuilder: (context, index) {
                        final project = projects[index];

                        return _HomeProjectCard(project: project);
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0F172A),
                  Color(0xFF082F49),
                ],
              ),
            ),
            child: const Text(
              'Собираю проекты от идеи до запуска: дизайн, backend, frontend, мобильное приложение и деплой.',
              style: TextStyle(
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const _HomeContactsBlock(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}


class _HomeContactsBlock extends StatelessWidget {
  const _HomeContactsBlock();

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _openEmail() async {
    final uri = Uri.parse('mailto:info@lebedevdev.ru');

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Контакты',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _ContactCard(
            icon: Icons.alternate_email,
            title: 'VK',
            subtitle: 'Страница в ВК',
            onTap: () => _openUrl('https://vk.com/lebedew136'),
          ),
          _ContactCard(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: 'info@lebedevdev.ru',
            onTap: _openEmail,
          ),
          _ContactCard(
            icon: Icons.message_outlined,
            title: 'MAX',
            subtitle: 'Связаться в MAX',
            onTap: () => _openUrl('https://max.ru/u/f9LHodD0cOK9n-v97Q7-qWM0_T6O_7ccyih09CP6Zsn7MDS0v9ti8sDeGRI'),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF38BDF8),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.open_in_new,
                  color: Color(0xFF38BDF8),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _HomeProjectCard({
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProjectDetailScreen(slug: project.slug),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.image != null && project.image!.isNotEmpty)
              Image.network(
                project.image!,
                width: double.infinity,
                height: 145,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 145,
                width: double.infinity,
                color: const Color(0xFF020617),
                child: const Icon(
                  Icons.folder,
                  color: Color(0xFF38BDF8),
                  size: 42,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.shortDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Text(
                        'Открыть проект',
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Color(0xFF38BDF8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _HomeSectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onTap;

  const _HomeSectionHeader({
    required this.title,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class _HomeSmallCard extends StatelessWidget {
  final String title;
  final String text;
  final String icon;
  final VoidCallback? onTap;

  const _HomeSmallCard({
    required this.title,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Подробнее',
                      style: TextStyle(
                        color: Color(0xFF38BDF8),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeBenefitCard extends StatelessWidget {
  final String title;
  final String text;

  const _HomeBenefitCard({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF38BDF8),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _HomeFeatureCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF38BDF8).withOpacity(0.13),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF38BDF8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ApiService api = ApiService();

  late Future<List<ServiceModel>> servicesFuture;

  @override
  void initState() {
    super.initState();
    servicesFuture = api.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Услуги'),
      ),
      body: FutureBuilder<List<ServiceModel>>(
        future: servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final services = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ServiceDetailScreen(
                        slug: service.slug,
                      ),
                    ),
                  );
                },
                child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFF1E293B),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF38BDF8).withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF38BDF8).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          service.icon ?? '{}',
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service.shortDescription,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ServiceDetailScreen extends StatefulWidget {
  final String slug;

  const ServiceDetailScreen({
    super.key,
    required this.slug,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final ApiService api = ApiService();

  late Future<ServiceModel> serviceFuture;

  @override
  void initState() {
    super.initState();
    serviceFuture = api.getService(widget.slug);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ServiceModel>(
        future: serviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final service = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: const Color(0xFF020617),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    service.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0F172A),
                          Color(0xFF082F49),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        service.icon ?? '💻',
                        style: const TextStyle(fontSize: 72),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (service.shortDescription.isNotEmpty)
                        Text(
                          service.shortDescription,
                          style: const TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        child: Text(
                          service.description,
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 15,
                            height: 1.55,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      if (service.advantages.isNotEmpty) ...[
                      const SizedBox(height: 24),

                      const Text(
                        'Преимущества',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...service.advantages.map((item) {
                        return _ServicePoint(text: item);
                      }),
                    ],

                    if (service.stages.isNotEmpty) ...[
                      const SizedBox(height: 24),

                      const Text(
                        'Этапы работы',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...service.stages.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;

                        return _ServiceStagePoint(
                          number: index,
                          text: item,
                        );
                      }),
                    ],
                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                           Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CooperationScreen(),
                            ),
                          );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF38BDF8),
                            foregroundColor: const Color(0xFF020617),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Обсудить проект',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ServicePoint extends StatelessWidget {
  final String text;

  const _ServicePoint({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF38BDF8),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFCBD5E1),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceStagePoint extends StatelessWidget {
  final int number;
  final String text;

  const _ServiceStagePoint({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF38BDF8).withOpacity(0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Color(0xFF38BDF8),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFCBD5E1),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ApiService api = ApiService();

  late Future<List<ProjectModel>> projectsFuture;

  @override
  void initState() {
    super.initState();
    projectsFuture = api.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Проекты'),
      ),
      body: FutureBuilder<List<ProjectModel>>(
        future: projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final projects = snapshot.data ?? [];

          if (projects.isEmpty) {
            return const Center(
              child: Text('Проекты пока не добавлены'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProjectDetailScreen(
                        slug: project.slug,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF1E293B),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (project.image != null && project.image!.isNotEmpty)
                        Image.network(
                          project.image!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      else
                        Container(
                          height: 160,
                          width: double.infinity,
                          color: const Color(0xFF020617),
                          child: const Center(
                            child: Icon(
                              Icons.folder,
                              size: 44,
                              color: Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (project.subtitle.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                project.subtitle,
                                style: const TextStyle(
                                  color: Color(0xFF38BDF8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            Text(
                              project.shortDescription,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                height: 1.4,
                              ),
                            ),
                            if (project.technologies.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: project.technologies.map((tech) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF38BDF8)
                                          .withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      tech,
                                      style: const TextStyle(
                                        color: Color(0xFF7DD3FC),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 12),
                            const Row(
                              children: [
                                Text(
                                  'Подробнее',
                                  style: TextStyle(
                                    color: Color(0xFF38BDF8),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Color(0xFF38BDF8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProjectDetailScreen extends StatefulWidget {
  final String slug;

  const ProjectDetailScreen({
    super.key,
    required this.slug,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final ApiService api = ApiService();

  late Future<ProjectModel> projectFuture;

  @override
  void initState() {
    super.initState();
    projectFuture = api.getProject(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProjectModel>(
        future: projectFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final project = snapshot.data!;

          final galleryItems = project.files.where((file) {
            return _isImageFile(file.name);
          }).toList();

          final documentItems = project.files.where((file) {
            return !_isImageFile(file.name);
          }).toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: const Color(0xFF020617),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: project.image != null && project.image!.isNotEmpty
                      ? Image.network(
                          project.image!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: const Color(0xFF0F172A),
                          child: const Center(
                            child: Icon(
                              Icons.folder,
                              size: 64,
                              color: Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (project.subtitle.isNotEmpty)
                        Text(
                          project.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      const SizedBox(height: 14),
                      Text(
                        project.description.isNotEmpty
                            ? project.description
                            : project.shortDescription,
                        style: const TextStyle(
                          color: Color(0xFFCBD5E1),
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                      if (project.technologies.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Технологии',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.technologies.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF38BDF8)
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                tech,
                                style: const TextStyle(
                                  color: Color(0xFF7DD3FC),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      if (project.image != null && project.image!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Галерея проекта',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ProjectImageCard(imageUrl: project.image!),
                      ],

                      if (galleryItems.isNotEmpty) ...[
                        if (project.image == null || project.image!.isEmpty) ...[
                          const SizedBox(height: 24),
                          const Text(
                            'Галерея проекта',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: galleryItems.length,
                            itemBuilder: (context, index) {
                              final file = galleryItems[index];

                              return _ProjectGalleryItem(
                                imageUrl: file.url,
                              );
                            },
                          ),
                        ),
                      ],

                      if (documentItems.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Документы',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...documentItems.map((file) {
                          return _ProjectDocumentCard(file: file);
                        }),
                      ],

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


bool _isImageFile(String fileName) {
  final lower = fileName.toLowerCase();

  return lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png') ||
      lower.endsWith('.webp') ||
      lower.endsWith('.gif');
}

Future<void> _openExternalLink(String url) async {
  final uri = Uri.parse(url);

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}

class _ProjectImageCard extends StatelessWidget {
  final String imageUrl;

  const _ProjectImageCard({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProjectGalleryItem extends StatelessWidget {
  final String imageUrl;

  const _ProjectGalleryItem({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1E293B),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProjectDocumentCard extends StatelessWidget {
  final dynamic file;

  const _ProjectDocumentCard({
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            _openExternalLink(file.url);
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.download_outlined,
                    color: Color(0xFF38BDF8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    file.name,
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.open_in_new,
                  color: Color(0xFF38BDF8),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CooperationScreen extends StatefulWidget {
  const CooperationScreen({super.key});

  @override
  State<CooperationScreen> createState() => _CooperationScreenState();
}

class _CooperationScreenState extends State<CooperationScreen> {
  final ApiService api = ApiService();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final descriptionController = TextEditingController();
  final examplesController = TextEditingController();

  String siteType = '';
  String design = '';
  String budget = '';
  String deadline = '';

  final List<String> features = [];

  bool isLoading = false;

  final featureItems = const [
    'Админ-панель',
    'Уведомления в месседжерах или соц сетях',
    'Онлайн-оплата',
    'Каталог товаров',
    'Личный кабинет',
    'API',
    'Мобильное приложение',
  ];

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    descriptionController.dispose();
    examplesController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
      filled: true,
      fillColor: const Color(0xFF0F172A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF1E293B)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF1E293B)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF38BDF8)),
      ),
    );
  }

  Future<void> sendBrief() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await api.sendCooperationBrief(
        name: nameController.text.trim(),
        contact: contactController.text.trim(),
        siteType: siteType,
        design: design,
        features: features,
        description: descriptionController.text.trim(),
        budget: budget,
        deadline: deadline,
        examples: examplesController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Бриф отправлен'),
          backgroundColor: Color(0xFF16A34A),
        ),
      );

      nameController.clear();
      contactController.clear();
      descriptionController.clear();
      examplesController.clear();

      setState(() {
        siteType = '';
        design = '';
        budget = '';
        deadline = '';
        features.clear();
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget step(String number, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF38BDF8),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFCBD5E1),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionChip({
    required String value,
    required String groupValue,
    required Function(String) onTap,
  }) {
    final active = value == groupValue;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF38BDF8).withOpacity(0.18)
              : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: active
                ? const Color(0xFF38BDF8)
                : const Color(0xFF1E293B),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: active ? const Color(0xFF7DD3FC) : const Color(0xFFCBD5E1),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Заявка'),
    ),
    body: SafeArea(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF082F49),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Color(0xFF1E293B)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Начать проект',
                    style: TextStyle(
                      color: Color(0xFF38BDF8),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Сотрудничество',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Заполните короткий бриф на разработку сайта. Это поможет понять задачу, цели проекта и примерный объём работ.',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            sectionTitle('Как проходит работа'),

            step('01', 'Вы заполняете заявку'),
            step('02', 'Я изучаю задачу и уточняю детали'),
            step('03', 'Обсуждаем сроки, стоимость и этапы'),
            step('04', 'Запускаем разработку'),

            const SizedBox(height: 28),

            sectionTitle('Бриф на разработку сайта'),

            TextFormField(
              controller: nameController,
              decoration: inputDecoration('Ваше имя'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Введите имя';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: contactController,
              decoration: inputDecoration(
                'Телефон, Email, Месседжеры, Социальные сети',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Укажите контакт';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: siteType.isEmpty ? null : siteType,
              dropdownColor: const Color(0xFF0F172A),
              decoration: inputDecoration('Какой сайт нужен?'),
              items: const [
                DropdownMenuItem(value: 'Лендинг', child: Text('Лендинг')),
                DropdownMenuItem(value: 'Сайт-визитка', child: Text('Сайт-визитка')),
                DropdownMenuItem(value: 'Корпоративный', child: Text('Корпоративный сайт')),
                DropdownMenuItem(value: 'Интернет-магазин', child: Text('Интернет-магазин')),
                DropdownMenuItem(value: 'Веб-сервис', child: Text('Веб-сервис')),
                DropdownMenuItem(value: 'Другое', child: Text('Другое')),
              ],
              onChanged: (value) {
                setState(() {
                  siteType = value ?? '';
                });
              },
            ),

            const SizedBox(height: 20),

            sectionTitle('Есть ли дизайн?'),

            Wrap(
              children: [
                optionChip(
                  value: 'Да',
                  groupValue: design,
                  onTap: (value) => setState(() => design = value),
                ),
                optionChip(
                  value: 'Нет',
                  groupValue: design,
                  onTap: (value) => setState(() => design = value),
                ),
                optionChip(
                  value: 'В разработке',
                  groupValue: design,
                  onTap: (value) => setState(() => design = value),
                ),
              ],
            ),

            const SizedBox(height: 20),

            sectionTitle('Что нужно в проекте?'),

            ...featureItems.map((item) {
              final active = features.contains(item);

              return CheckboxListTile(
                value: active,
                activeColor: const Color(0xFF38BDF8),
                title: Text(item),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      features.add(item);
                    } else {
                      features.remove(item);
                    }
                  });
                },
              );
            }),

            const SizedBox(height: 14),

            TextFormField(
              controller: descriptionController,
              maxLines: 5,
              decoration: inputDecoration('Опишите задачу'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Опишите задачу';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: budget.isEmpty ? null : budget,
              dropdownColor: const Color(0xFF0F172A),
              decoration: inputDecoration('Бюджет'),
              items: const [
                DropdownMenuItem(value: 'До 50 000 ₽', child: Text('До 50 000 ₽')),
                DropdownMenuItem(value: '50 000 – 100 000 ₽', child: Text('50 000 – 100 000 ₽')),
                DropdownMenuItem(value: '100 000 – 200 000 ₽', child: Text('100 000 – 200 000 ₽')),
                DropdownMenuItem(value: 'От 200 000 ₽', child: Text('От 200 000 ₽')),
              ],
              onChanged: (value) {
                setState(() {
                  budget = value ?? '';
                });
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: deadline.isEmpty ? null : deadline,
              dropdownColor: const Color(0xFF0F172A),
              decoration: inputDecoration('Сроки'),
              items: const [
                DropdownMenuItem(value: 'Срочно', child: Text('Срочно')),
                DropdownMenuItem(value: 'В течение месяца', child: Text('В течение месяца')),
                DropdownMenuItem(value: 'Сроки гибкие', child: Text('Сроки гибкие')),
              ],
              onChanged: (value) {
                setState(() {
                  deadline = value ?? '';
                });
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: examplesController,
              decoration: inputDecoration('Есть ли примеры сайтов?'),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendBrief,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38BDF8),
                  foregroundColor: const Color(0xFF020617),
                  disabledBackgroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Отправить бриф',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
    );
  }
}

class PageWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const PageWrapper({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}