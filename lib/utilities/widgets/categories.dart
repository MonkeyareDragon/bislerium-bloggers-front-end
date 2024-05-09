import 'package:flutter/material.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/widgets/sidebar_container.dart';

class Categories extends StatefulWidget {
  final Function(String) onCategorySelected;

  const Categories({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String selectedCategory = 'Random'; // Default category

  @override
  Widget build(BuildContext context) {
    return SidebarContainer(
      title: "Sort By",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Category(
            title: 'Random',
            numOfItems: 5,
            isSelected: selectedCategory == 'Random',
            press: () {
              selectCategory('Random');
            },
          ),
          Category(
            title: 'Popularity',
            numOfItems: 5,
            isSelected: selectedCategory == 'Popularity',
            press: () {
              selectCategory('Popularity');
            },
          ),
          Category(
            title: 'Recency',
            numOfItems: 5,
            isSelected: selectedCategory == 'Recency',
            press: () {
              selectCategory('Recency');
            },
          ),
        ],
      ),
    );
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onCategorySelected(category); // Call the callback function
  }
}

class Category extends StatelessWidget {
  final String title;
  final int numOfItems;
  final bool isSelected;
  final VoidCallback press;

  const Category({
    Key? key,
    required this.title,
    required this.numOfItems,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: BisleriumConstant.kDefaultPadding / 4,
      ),
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: isSelected
              ? MaterialStateProperty.all<Color>(
                  Colors.blue.withOpacity(0.1),
                )
              : null,
        ),
        child: Text.rich(
          TextSpan(
            text: title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
            ),
            children: [
              TextSpan(
                text: " ($numOfItems)",
                style: TextStyle(
                  color:
                      isSelected ? Colors.blue.withOpacity(0.5) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
