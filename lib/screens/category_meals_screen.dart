import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> meals;
  CategoryMealsScreen(this.meals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String mealId;
  late String title;
  late List<Meal> categoryMeals;
  bool loadedData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loadedData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      this.mealId = routeArgs["id"] as String;
      this.title = routeArgs["title"] as String;
      this.categoryMeals = widget.meals
          .where((element) => element.categories.contains(mealId))
          .toList();
      this.loadedData = true;
    }
    super.didChangeDependencies();
  }

  void removeItem(String itemId) {
    setState(() {
      this.categoryMeals.removeWhere((element) {
        if (element.id == itemId) {
          print("true");
          return true;
        } else {
          print("false");
          return false;
        }
      });
      print(this.categoryMeals.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
