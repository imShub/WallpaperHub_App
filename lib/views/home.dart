import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub_app/data/data.dart';
import 'package:wallpaperhub_app/model/categories_model.dart';
import 'package:wallpaperhub_app/model/wallpaper_model.dart';
import 'package:wallpaperhub_app/views/search.dart';
import 'package:wallpaperhub_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];

  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var url = Uri.parse('https://api.pexels.com/v1/curated?per_page=15?page=1');
    var responce = await http.get(url, headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(responce.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel;

      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search Wallpaper",
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(
                                  searchQuery: searchController.text,
                                ),
                              ));
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorieTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorieTile extends StatelessWidget {
  final String imgUrl, title;

  CategorieTile({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imgUrl,
                  height: 50, width: 100, fit: BoxFit.cover)),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ))),
        ],
      ),
    );
  }
}
