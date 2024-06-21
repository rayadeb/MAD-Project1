import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {

  final CalendarWeekController _controller = CalendarWeekController();
  // Map<DateTime, Item> myDict = {
  //   DateTime.now(): Item('Hello')
  // };
  // DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meal Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Color.fromARGB(255, 86, 77, 74))),
        backgroundColor: const Color.fromARGB(255, 143, 199, 142),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  // color: Colors.black.withOpacity(0.5),
                  color: const Color.fromARGB(255, 86, 77, 74).withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 3)
            ]),
            child: CalendarWeek(
              dayOfWeekStyle: const TextStyle(color: Color.fromARGB(255, 86, 77, 74), fontWeight: FontWeight.w600),
              todayDateStyle: const TextStyle(color: Color.fromARGB(255, 239, 149, 156), fontWeight: FontWeight.w600),
              dateStyle: const TextStyle(color: Color.fromARGB(255, 86, 77, 74), fontWeight: FontWeight.w600),
              pressedDateStyle: const TextStyle(color: Color.fromARGB(255, 86, 77, 74), fontWeight: FontWeight.w600),
              controller: _controller,
              height: 150,
              showMonth: true,
              pressedDateBackgroundColor: const Color.fromARGB(255, 239, 149, 156),
              todayBackgroundColor: const Color.fromARGB(255, 86, 77, 74),
              // dateBackgroundColor: const Color.fromARGB(255, 143, 199, 142),
              backgroundColor: const Color.fromARGB(255, 239, 244, 250),
              minDate: DateTime.now().add(
                const Duration(days: -365),
              ),
              maxDate: DateTime.now().add(
                const Duration(days: 365),
              ),
              onDatePressed: (DateTime datetime) {
                // Do something
                setState(() {
                  
                });
              },
              onDateLongPressed: (DateTime datetime) {
                // Do something
              },
              onWeekChanged: () {
                // Do something
              },
              monthViewBuilder: (DateTime time) => Align(
                alignment: FractionalOffset.center,
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    // child: const Text('Test'),
                    child: Text(
                      DateFormat.yMMMM().format(time),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 86, 77, 74), fontWeight: FontWeight.w600, fontSize: 20.0),
                    )
                  ),
              ),
              decorations: [
                DecorationItem(
                    decorationAlignment: FractionalOffset.bottomRight,
                    date: DateTime.now(),
                    decoration: const Icon(
                      Icons.today,
                      color: Color.fromARGB(255, 239, 149, 156),
                    )),
                DecorationItem(
                    date: DateTime.now().add(const Duration(days: 3)),
                    decoration: const Text(
                      'Holiday',
                      style: TextStyle(
                        color: Color.fromARGB(255, 86, 77, 74),
                        fontWeight: FontWeight.w600,
                        fontSize: 50.0,
                      ),
                    )),
              ],
            )),
        Expanded(
          // child: Test(item: myDict[_controller.selectedDate]),
          child: Center(
            child: Text(
              '${_controller.selectedDate.month}/${_controller.selectedDate.day}/${_controller.selectedDate.year}',
              style: const TextStyle(fontSize: 50),
            ),
          ),
        )
      ]),
    );
  }
}

class Item {
  String name;

  Item(this.name);
}

// class Test extends StatelessWidget {
//   final Item item;
//   const Test({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }