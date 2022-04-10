import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class Search extends StatefulWidget {
  late final String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
