import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false
  };

  void _setFilters(Map<String, bool> filter) {
    setState(() {
      this._filters = filter;
      availableMeals = DUMMY_MEALS.where((element) {
        if (this._filters["gluten"] as bool && !element.isGlutenFree) {
          return false;
        } else if (this._filters["vegan"] as bool && !element.isVegan) {
          return false;
        } else if (this._filters["lactose"] as bool && !element.isLactoseFree) {
          return false;
        } else if (this._filters["vegetarian"] as bool &&
            !element.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void toggleFavorite(String id) {
    int index = this._favoriteMeals.indexWhere((element) => element.id == id);
    if (index < 0) {
      setState(() {
        this
            ._favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    } else {
      setState(() {
        this._favoriteMeals.removeAt(index);
      });
    }
  }

  bool isFavorite(String id) {
    return this._favoriteMeals.any((element) => id == element.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meals App",
      theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: "Releway",
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                    fontSize: 20,
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold),
              )),
      // home: CategoriesScreen(),
      initialRoute: "/",
      routes: {
        "/": (ctx) => TabsScreen(this._favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(this.availableMeals),
        MealDetailsScreen.routeName: (ctx) =>
            MealDetailsScreen(this.toggleFavorite, isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
            saveFilters: this._setFilters, filters: this._filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
