class Video {
  final String url;
  final String title;
  final String description;
  final String category;

  Video({
    required this.url,
    required this.title,
    required this.description,
    required this.category,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json['url'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
    );
  }
}
