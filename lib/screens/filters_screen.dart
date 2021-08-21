import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Function saveFilters;
  final Map<String, bool> filters;

  FiltersScreen({required this.filters, required this.saveFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _glutenFree;
  late bool _vegetarian;
  late bool _vegan;
  late bool _lactoseFree;

  @override
  void initState() {
    super.initState();
    this._glutenFree = widget.filters["gluten"] as bool;
    this._vegetarian = widget.filters["vegetarian"] as bool;
    this._vegan = widget.filters["vegan"] as bool;
    this._lactoseFree = widget.filters["lactose"] as bool;
  }

  Widget _buildSwitchStyle(
      String title, String subTitle, bool currentValue, ValueChanged update) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  "gluten": this._glutenFree,
                  "lactose": this._lactoseFree,
                  "vegan": this._vegan,
                  "vegetarian": this._vegetarian
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchStyle("Gluten Free",
                  "Only include gluten free meals.", this._glutenFree, (value) {
                setState(() {
                  this._glutenFree = value;
                });
              }),
              _buildSwitchStyle("Vegetarian", "Only include vegetarian meals.",
                  this._vegetarian, (value) {
                setState(() {
                  this._vegetarian = value;
                });
              }),
              _buildSwitchStyle(
                  "Vegan", "Only include vegan meals.", this._vegan, (value) {
                setState(() {
                  this._vegan = value;
                });
              }),
              _buildSwitchStyle(
                  "Lactose Free",
                  "Only include lactose free meals.",
                  this._lactoseFree, (value) {
                setState(() {
                  this._lactoseFree = value;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
