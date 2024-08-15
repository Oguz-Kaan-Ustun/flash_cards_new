class FolderModel {
  String name;
  List contents;

  FolderModel({
    required this.name,
    required this.contents,
  });

  FolderModel.fromJson(Map<String, Object?> json)
      : this(
    name: json['name']! as String,
    contents: json['contents']! as List,
  );

  FolderModel copyWith({
    String? name,
    List? contents
  }) {
    return FolderModel(
      name: name ?? this.name,
      contents: contents ?? this.contents
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'contents': contents
    };
  }
}