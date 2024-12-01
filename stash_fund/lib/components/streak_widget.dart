import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakWidget extends StatefulWidget {
  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  List<DateTime> _streakDays = [];

  @override
  void initState() {
    super.initState();
    // Focus the calendar on November 9, 2024
    _focusedDay = DateTime(2024, 12, 1);
    _selectedDay = _focusedDay;
    _setFixedStreakDays(); // Initialize fixed streak days
  }

  Future<void> _setFixedStreakDays() async {
    // Fixed dates for the streak
    final fixedDates = [
      DateTime(2024, 11, 29), // 9th November
      DateTime(2024, 11, 30), // 10th November
      DateTime(2024, 11, 28), // 11th November
    ];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'streakDays',
      fixedDates.map((e) => e.toIso8601String()).toList(),
    );

    setState(() {
      _streakDays = fixedDates;
    });
  }

  bool _isStreakDay(DateTime day) {
    return _streakDays.any((streakDay) =>
        streakDay.year == day.year &&
        streakDay.month == day.month &&
        streakDay.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430, // Increased height for a larger card
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Streak Calendar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16), // Increased spacing
              Expanded(
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) =>
                      _selectedDay.year == day.year &&
                      _selectedDay.month == day.month &&
                      _selectedDay.day == day.day,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay; // Update selected day
                      _focusedDay = focusedDay;  // Update focused day
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      if (_isStreakDay(day)) {
                        return Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12, // Slightly larger text
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(fontSize: 12), // Slightly larger text
                    weekendTextStyle: TextStyle(fontSize: 12), // Slightly larger text
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false, // Hide the format button
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 16), // Larger title
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontSize: 12), // Slightly larger weekdays
                    weekendStyle: TextStyle(fontSize: 12), // Slightly larger weekends
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
