import 'package:dinhhaitrieu/core/DI/injection.dart';
import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_event.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_state.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealSearchBloc>(create: (context) => sl<MealSearchBloc>()),
        BlocProvider<CategoriesBloc>(
          create: (context) => sl<CategoriesBloc>()..add(CategoriesStarted()),
        ),
      ],

      child: SizedBox(
        height: 25,
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading || state is CategoriesInitial) {
              return const Center(
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            if (state is CategoriesError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }

            if (state is CategoriesLoaded) {
              final items = state.categories;
              final selectedIndex = state.selectedIndex;

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final selected = index == selectedIndex;
                  final name = items[index];

                  return GestureDetector(
                    onTap: () {
                      context.read<CategoriesBloc>().add(
                        CategoriesSelected(name),
                      );

                      // NOTE: Nếu sau này bạn implement API filter theo category (filter.php?c=...),
                      // bạn có thể trigger thêm bloc khác ở đây.
                      // context.read<MealSearchBloc>().add(MealSearchEvent.categorySelected(name));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary600 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            // fallback (hiếm khi chạy)
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
