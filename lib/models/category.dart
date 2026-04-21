import '../core/assets_manager/assets_manager.dart';

class CategoryModel {
  final String id;
  final String name;
  final String imagePath;
  final String? darkImagePath;
  bool isRightAligned;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imagePath,
    this.darkImagePath,
    this.isRightAligned = true,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: "general",
      name: "General",
      imagePath: ImageManager.general,
      darkImagePath: ImageManagerInDark.general,
    ),
    CategoryModel(
      id: "business",
      name: "Business",
      imagePath: ImageManager.business,
      darkImagePath: ImageManagerInDark.business,
      isRightAligned: false,
    ),
    CategoryModel(
      id: "sports",
      name: "Sports",
      imagePath: ImageManager.sports,
      darkImagePath: ImageManagerInDark.sports,
    ),
    CategoryModel(
      id: "health",
      name: "Health",
      imagePath: ImageManager.health,
      darkImagePath: ImageManagerInDark.health,
      isRightAligned: false,
    ),
    CategoryModel(
      id: "science",
      name: "Science",
      imagePath: ImageManager.science,
      darkImagePath: ImageManagerInDark.science,
    ),
    CategoryModel(
      id: "technology",
      name: "Technology",
      imagePath: ImageManager.technology,
      darkImagePath: ImageManagerInDark.technology,
      isRightAligned: false,
    ),
    CategoryModel(
      id: "entertainment",
      name: "Entertainment",
      imagePath: ImageManager.entertainment,
      darkImagePath: ImageManagerInDark.entertainment,
    ),
  ];
}
