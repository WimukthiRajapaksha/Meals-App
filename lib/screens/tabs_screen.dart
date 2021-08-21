import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> list;
  int selectedPageIndex = 0;

  @override
  void initState() {
    this.list = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {"page": FavoritesScreen(widget.favoriteMeals), "title": "Your Favorites"}
    ];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   initialIndex: 0,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Meals"),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: "Categories",
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: "Favorite",
    //           )
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [CategoriesScreen(), FavoritesScreen()],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(list[selectedPageIndex]["title"] as String),
      ),
      drawer: MainDrawer(),
      body: list[selectedPageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: this.selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text("Categories")),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text("Favorites"))
        ],
      ),
    );
  }
}
