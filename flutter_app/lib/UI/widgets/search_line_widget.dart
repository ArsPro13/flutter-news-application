import 'package:flutter/material.dart';
import 'package:flutter_app/Domain/searching_articles_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchLineWidget extends ConsumerStatefulWidget {
  const SearchLineWidget({
    super.key,
    required this.shrinkOffset,
  });

  final double shrinkOffset;

  @override
  ConsumerState<SearchLineWidget> createState() => SearchLineWidgetState();
}

class SearchLineWidgetState extends ConsumerState<SearchLineWidget> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.shrinkOffset < 50 ? TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: 'Search',
        suffixIcon: widget.shrinkOffset < 20 ? IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            String req = searchController.text;
            await ref.watch(searchingProvider).updateSearch(req);
          },
        ) : null,
      ),
    ) : Container();
  }
}
