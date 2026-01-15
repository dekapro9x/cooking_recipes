import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_event.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealSearchBloc, MealSearchState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (query) {
                    if (query.trim().isNotEmpty) {
                      context.read<MealSearchBloc>().add(
                        MealSearchEvent.queryChanged(query),
                      );
                    }
                  },
                  onSubmitted: (query) {
                    if (query.trim().isNotEmpty) {
                      context.read<MealSearchBloc>().add(
                        MealSearchEvent.submitted(query),
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Tìm kiếm công thức",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
