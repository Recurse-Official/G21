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
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _loadStreakDays();
  }

  Future<void> _loadStreakDays() async {
    final prefs = await SharedPreferences.getInstance();
    final streakDaysString = prefs.getStringList('streakDays') ?? [];
    final streakDays = streakDaysString.map((e) => DateTime.parse(e)).toList();

    setState(() {
      _streakDays = streakDays;
    });
  }

  Future<void> _addStreakDay(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_streakDays.contains(day)) {
      setState(() {
        _streakDays.add(day);
      });
      await prefs.setStringList(
        'streakDays',
        _streakDays.map((e) => e.toIso8601String()).toList(),
      );
    }
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
                'Your Streak Calendar',
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
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _addStreakDay(selectedDay);
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
