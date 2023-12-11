import 'package:flutter/material.dart';
import '../lists/category.dart';
import '../lists/category_thumbnail.dart';

List<String> selectedCategories = [];
List<bool> selectedItems =
    List<bool>.generate(categories.length, (index) => false);

List<String> getSelectedCategories() {
  List<String> selectedCategories = [];
  for (int i = 0; i < categories.length; i++) {
    if (selectedItems[i]) {
      selectedCategories.add(categories[i]);
    }
  }
  return selectedCategories;
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        // ignore: unused_local_variable
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedItems[index] = !selectedItems[index];
              selectedCategories = getSelectedCategories();
            });
          },
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(thumbnails[index]),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: selectedItems[index]
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 35,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
