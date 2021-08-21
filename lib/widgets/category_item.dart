import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(
      {required this.id, required this.title, required this.color});

  void selectCategory(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return CategoryMeanlsScreen(
    //     categoryId: this.id,
    //     categoryTitle: this.title,
    //   );
    // }));
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName,
        arguments: {"id": this.id, "title": this.title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            color: this.color,
            gradient: LinearGradient(
                colors: [this.color.withOpacity(0.7), this.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
