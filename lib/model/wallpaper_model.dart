class WallpaperModel {
  late String photographer;
  late String photographer_url;
  late int photographer_id;

  late SrcModel src;

  WallpaperModel(
      {required this.src,
      required this.photographer,
      required this.photographer_url,
      required this.photographer_id});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        src: SrcModel.fromMap(jsonData["src"]),
        photographer_url: jsonData["photographer_url"],
        photographer_id: jsonData["photographer_id"],
        photographer: jsonData["photographer"]);
  }
}

class SrcModel {
  late String original;
  late String small;
  late String portrait;

  SrcModel({
    required this.portrait,
    required this.original,
    required this.small,
  });

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"],
    );
  }
}
