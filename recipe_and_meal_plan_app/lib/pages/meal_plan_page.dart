import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_meal_plan_app/main.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  // final DatesProvider _datesProvider = DatesProvider();
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meal Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color.fromARGB(255, 86, 77, 74))),
        backgroundColor: const Color.fromARGB(255, 239, 244, 250),
      ),
      body: Column(
        children: [
          buildWeekView(),
          const Expanded(
            child: Text('Breakfast'),
          )
        ],
      ),
    );
  }

  Widget buildCapsuleView(DateTime date) {
    final day = DateFormat("ccccc").format(date);
    final formattedDate = DateFormat("d").format(date);
    // final today = DateTime.now();
    // final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
    final isSelected = _selectedDate != null && date.year == _selectedDate!.year && date.month == _selectedDate!.month && date.day == _selectedDate!.day;

    final double availableWidth = MediaQuery.of(context).size.width - 32.0;
    final double capsuleWidth = availableWidth / 7.0;

    Color capsuleColor;
    if (isSelected) {
      capsuleColor = const Color.fromARGB(255, 143, 199, 142);
    } else {
      capsuleColor = Colors.transparent;
    }

    TextStyle textStyle = TextStyle(
      fontSize: 24.0,
      // fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

    TextStyle dateStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 86, 77, 74)
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: GestureDetector(
        onTap: () => _onDateSelected(date),
        child: Container(
          height: 120.0,
          width: capsuleWidth.floorToDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: capsuleColor,
            // gradient: const LinearGradient(
            //   colors: [Color.fromARGB(255, 86, 77, 74), Color.fromARGB(255, 239, 244, 250)],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(day, style: textStyle),
                Text(formattedDate, style: dateStyle),
              ],
            ),
          )
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  Widget buildWeekView() {
    return Consumer<DatesProvider>(
      builder: (context, datesProvider, child) {
        final dates = datesProvider.dates;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                return buildCapsuleView(date);
              },
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
            ),
          ),
        );
      }
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      final datesProvider = Provider.of<DatesProvider>(context, listen: false);
      datesProvider.loadMoreDates(10);
    }
  }
}