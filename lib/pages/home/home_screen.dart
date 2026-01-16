import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_event.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/recipe_home_bloc.dart';
import 'package:dinhhaitrieu/pages/home/widgets/banner_list.dart';
import 'package:dinhhaitrieu/pages/home/widgets/category_chips.dart';
import 'package:dinhhaitrieu/pages/home/widgets/category_list.dart';
import 'package:dinhhaitrieu/pages/home/widgets/location_row.dart';
import 'package:dinhhaitrieu/pages/home/widgets/recent_recipes_section.dart';
import 'package:dinhhaitrieu/pages/home/widgets/section_header.dart';
import 'package:dinhhaitrieu/pages/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dinhhaitrieu/core/DI/injection.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealSearchBloc>(create: (context) => sl<MealSearchBloc>()),
        BlocProvider<CategoriesBloc>(
          create: (context) => sl<CategoriesBloc>()..add(CategoriesStarted()),
        ),
        BlocProvider<RecipeHomeBloc>(create: (context) => sl<RecipeHomeBloc>()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print("DINHAITRIEU");
    return Scaffold(
      backgroundColor: AppColors.neuture50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBarWidget(),
              SizedBox(height: 10),
              LocationRow(),
              SizedBox(height: 10),
              BannerList(),
              SizedBox(height: 10),
              SectionHeader(title: "Danh Mục", isSeeAll: true),
              SizedBox(height: 10),
              CategoryChips(),
              SizedBox(height: 10),
              CategoryList(),
              SizedBox(height: 10),
              SectionHeader(title: "Công thức gần đây", isSeeAll: false),
              SizedBox(height: 10),
              // BlocBuilder<MealSearchBloc, MealSearchState>(
              //   builder: (context, state) {
              //     return state.when(
              //       initial: () =>
              //           const Center(child: CircularProgressIndicator()),
              //       loading: () =>
              //           const Center(child: CircularProgressIndicator()),
              //       loaded: (items) => RecentRecipesSection(recipes: items),
              //       empty: () => const Center(child: Text('No recipes found')),
              //       error: (message) => Center(child: Text(message)),
              //     );
              //   },
              // ),
              SizedBox(height: 30),
              SectionHeader(title: "Nguyên liệu", isSeeAll: false),
              CategoryChips(),
              SizedBox(height: 10),
              CategoryChips(),
            ],
          ),
        ),
      ),
    );
  }
}
