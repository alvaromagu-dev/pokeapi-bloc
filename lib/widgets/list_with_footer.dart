import 'package:flutter/material.dart';

class ListWithFooter extends StatelessWidget {
  const ListWithFooter({
    Key? key,
    required this.children,
    required this.footer
  }) : super(key: key);

  final List<Widget> children;
  final List<Widget> footer;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(children)
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: footer,
          ),
        ),
      ],
    );
  }
}