import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({Key? key}) : super(key: key);

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  final TextEditingController _itemController = TextEditingController();
  final List<GroceryItem> _items = [];

  void _addItem(String itemName) {
    if (itemName.isNotEmpty) {
      setState(() {
        _items.add(GroceryItem(name: itemName));
      });
    }
  }

  void _toggleItemCompletion(int index) {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a grocery item'),
          content: TextField(
            controller: _itemController,
            decoration: const InputDecoration(
              hintText: 'Enter an item',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(204, 39, 39, 39)),
              ),
            ),
            TextButton(
              onPressed: () {
                _addItem(_itemController.text);
                _itemController.clear();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(),
              child: const Text(
                'Add',
                style: TextStyle(color: Color.fromARGB(255, 143, 199, 142)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Grocery List",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D4D), // Adjusted text color
            ),
          ),
        ),
        backgroundColor: const Color(0xFFDDEFDD),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _items.isEmpty
            ? const Center(
                child: Text('No items yet!'),
              )
            : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _items[index].isCompleted,
                      onChanged: (bool? value) {
                        _toggleItemCompletion(index);
                      },
                      checkColor: Colors.white,
                      activeColor: const Color.fromARGB(255, 188, 227, 187),
                    ),
                    title: Text(
                      _items[index].name,
                      style: TextStyle(
                        decoration: _items[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: const Color(0xFF4D4D4D),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 188, 227, 187),
        foregroundColor: const Color(0xFF4D4D4D),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroceryItem {
  String name;
  bool isCompleted;

  GroceryItem({required this.name, this.isCompleted = false});
}
