import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_app/UI/widgets/search_line_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHeaderWidget implements SliverPersistentHeaderDelegate {
  SearchHeaderWidget({
    required this.minExtent,
    required this.maxExtent,
  });

  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 30),
      child: Center(
        child: SizedBox(
          width: 390,
          child: SearchLineWidget(shrinkOffset: shrinkOffset,),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  TickerProvider? get vsync => null;
}