import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeal;

  FavoritesScreen(this._favoriteMeal);

  @override
  Widget build(BuildContext context) {
    print(this._favoriteMeal.length);
    if (this._favoriteMeal.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - try adding some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          print(index);
          print(this._favoriteMeal[index].title);
          return MealItem(
              id: this._favoriteMeal[index].id,
              title: this._favoriteMeal[index].title,
              imageUrl: this._favoriteMeal[index].imageUrl,
              duration: this._favoriteMeal[index].duration,
              complexity: this._favoriteMeal[index].complexity,
              affordability: this._favoriteMeal[index].affordability);
        },
        itemCount: this._favoriteMeal.length,
      );
    }
  }
}
