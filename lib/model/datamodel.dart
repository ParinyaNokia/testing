class ModelData {
  final String slug;
  final String name;
  final String url;

  ModelData({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory ModelData.fromJson(Map<String, dynamic> json) {
    return ModelData(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }
}
