import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_intro_bloc/app_intro_bloc.dart';
import '../home/home_screen.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});

  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AppIntroBloc, AppIntroState>(
          listener: (context, state) {
            final target = state.currentPage;
            final current = _pageController.hasClients
                ? _pageController.page?.round() ?? 0
                : 0;
            if (target != current && _pageController.hasClients) {
              _pageController.animateToPage(
                target,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 4,
                    onPageChanged: (index) {
                      context.read<AppIntroBloc>().add(PageChangedEvent(index));
                    },
                    itemBuilder: (context, index) {
                      return _buildIntroPage(index);
                    },
                  ),
                ),
                _buildBottomNavigation(context, state),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _buildIntroPage(int index) {
  switch (index) {
    case 0:
      return _IntroPageWidget(
        title: 'Chào mừng đến với ứng dụng',
        description:
            'Khám phá thế giới ẩm thực đa dạng với công thức nấu ăn tuyệt vời',
        imagePath: 'assets/images/background.png',
      );
    case 1:
      return _IntroPageWidget(
        title: 'Khám phá công thức',
        description: 'Hàng ngàn công thức nấu ăn từ khắp nơi trên thế giới',
        imagePath: 'assets/images/banner1.jpg',
      );
    case 2:
      return _IntroPageWidget(
        title: 'Danh mục đa dạng',
        description:
            'Tìm kiếm công thức theo danh mục, nguyên liệu và sở thích của bạn',
        imagePath: 'assets/images/avata.png',
      );
    case 3:
      return _IntroPageWidget(
        title: 'Bắt đầu ngay!',
        description: 'Sẵn sàng khám phá và nấu những món ăn ngon',
        imagePath: 'assets/images/background.png',
      );
    default:
      return Container();
  }
}

Widget _buildBottomNavigation(BuildContext context, AppIntroState state) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute<void>(builder: (context) => const HomeScreen()),
            );
          },
          child: const Text('Bỏ qua'),
        ),
        Row(
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: state.currentPage == index ? 12 : 8,
              height: state.currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.currentPage == index
                    ? Colors.blue
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (state.isLastPage) {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (context) => const HomeScreen(),
                ),
              );
            } else {
              context.read<AppIntroBloc>().add(NextPageEvent());
            }
          },
          child: Text(state.isLastPage ? 'Bắt đầu' : 'Tiếp theo'),
        ),
      ],
    ),
  );
}

class _IntroPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const _IntroPageWidget({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              imagePath,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    size: 100,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
