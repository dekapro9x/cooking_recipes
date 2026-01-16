import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dinhhaitrieu/core/DI/injection.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_detail_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_detail_state.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_detail_event.dart';
import 'package:dinhhaitrieu/features/domain/entities/meal_detail.dart';

class DetailScreen extends StatelessWidget {
  final String mealId;

  const DetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MealDetailBloc>()..add(MealDetailEvent.started(mealId)),
      child: const DetailView(),
    );
  }
}

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: BlocBuilder<MealDetailBloc, MealDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (detail) => _buildContent(context, detail),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lỗi: $message'),
                    ElevatedButton(
                      onPressed: () {
                        final bloc = context.read<MealDetailBloc>();
                        bloc.add(const MealDetailEvent.started('52772'));
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, MealDetail detail) {
    final thumbs = List.generate(8, (_) => detail.thumb);
    final steps = detail.instructions
        .split('\n')
        .where((String step) => step.trim().isNotEmpty)
        .toList();

    return CustomScrollView(
      slivers: [
        // ===== HEADER IMAGE =====
        SliverToBoxAdapter(
          child: _HeaderImage(
            imagePath: detail.thumb,
            onBack: () => Navigator.pop(context),
          ),
        ),

        // ===== CONTENT =====
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title + heart
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        detail.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  detail.category,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // rating row
                Row(
                  children: const [
                    Icon(Icons.star, size: 18, color: Color(0xFFC9A227)),
                    SizedBox(width: 6),
                    Text(
                      "4.2",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      " | ",
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "120 đánh giá",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // author row
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFECECEC),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      detail.area,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFC9A227),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 2,
                      width: 90,
                      color: const Color(0xFFC9A227),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // tabs
                _TabsBar(tabController: _tabController),

                const SizedBox(height: 14),

                SizedBox(
                  height: 420,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _IngredientsView(instructions: detail.instructions),
                      _StepsView(items: steps),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // video button
                _VideoButton(
                  onTap: () {
                    if (detail.youtube != null) {
                      // TODO: Mở YouTube video
                    }
                  },
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ====================== WIDGETS ======================

class _HeaderImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const _HeaderImage({required this.imagePath, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          // overlay tối nhẹ
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x33000000),
                    Color(0x00000000),
                    Color(0x22000000),
                  ],
                ),
              ),
            ),
          ),

          // back + title
          Positioned(
            left: 8,
            top: 10,
            child: Row(
              children: [
                IconButton(
                  onPressed: onBack,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Chi tiết",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
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

class _ThumbStrip extends StatelessWidget {
  final List<String> items;
  const _ThumbStrip({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 70,
              color: const Color(0xFFF3F3F3),
              child: Image.network(
                items[i],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TabsBar extends StatelessWidget {
  final TabController tabController;
  const _TabsBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              color: const Color(0xFFC9A227),
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFFC9A227),
            labelStyle: const TextStyle(fontWeight: FontWeight.w800),
            tabs: const [
              Tab(text: "Nguyên liệu"),
              Tab(text: "Chế biến"),
            ],
          ),
        ),
      ],
    );
  }
}

class _IngredientsView extends StatelessWidget {
  final String instructions;
  const _IngredientsView({required this.instructions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const Text(
          "Hướng dẫn chế biến",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Text(
          instructions,
          style: const TextStyle(
            fontSize: 13,
            height: 1.35,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StepsView extends StatelessWidget {
  final List<String> items;
  const _StepsView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: const Color(0xFFC9A227),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                "${i + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                items[i],
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VideoButton extends StatelessWidget {
  final VoidCallback onTap;
  const _VideoButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF4EFD7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ondemand_video, size: 18, color: Color(0xFFC9A227)),
            SizedBox(width: 8),
            Text(
              "Xem video",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFFC9A227),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
