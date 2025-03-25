import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePickupScreen extends StatefulWidget {
  @override
  _SchedulePickupScreenState createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String selectedTime = "09:00 AM";
  Set<String> wasteTypes = {}; // Changed to a Set for unique waste types
  List<String> availableTimes = ["09:00 AM", "10:00 AM", "11:00 AM", "02:00 PM", "03:00 PM", "04:00 PM"];
  List<String> wasteOptions = ["Plastic", "Metal", "Paper", "Glass", "Electronics"];

  int selectedWeek = 1; // Default to 1 week



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange, // Orange background for AppBar
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
        title: Text(
          "Schedule Pickup",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white, // White text in the AppBar
          ),
        ),
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week Selection Dropdown
            Text("Select Delivery Week", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: selectedWeek,
              onChanged: (int? newValue) {
                setState(() {
                  selectedWeek = newValue!;
                });
              },
              items: [1, 2, 3, 4] // Added 2-week option back
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value week${value > 1 ? 's' : ''}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Table Calendar
            Text("Select Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime(2099, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDate = selected;
                  focusedDay = focused; // Update the focused day
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.orange, // Orange color for selected day
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange.shade300, // Lighter orange for today
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Time Selection
            Text("Select Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(availableTimes[index]),
                      selected: selectedTime == availableTimes[index],
                      selectedColor: Colors.orange, // Orange color for selected time
                      onSelected: (selected) {
                        setState(() => selectedTime = availableTimes[index]);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Waste Types
            Text("Waste Types", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10, // Add space between rows
              children: wasteOptions.map((waste) {
                return ChoiceChip(
                  label: Text(waste),
                  selected: wasteTypes.contains(waste),
                  selectedColor: Colors.orange, // Orange color for selected waste type
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        wasteTypes.add(waste); // Add waste type if selected
                      } else {
                        wasteTypes.remove(waste); // Remove waste type if deselected
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Button to Schedule Pickup
            ElevatedButton(
              onPressed: wasteTypes.isEmpty ? null : () {
                // Add your action here, e.g., scheduling the pickup
              },
              child: Text("Schedule Pickup"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: wasteTypes.isEmpty ? Colors.grey : Colors.orange, // Orange button when active
              ),
            ),
          ],
        ),
      ),
    );
  }
}
