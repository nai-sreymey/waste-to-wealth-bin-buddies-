import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/schedule_pickup_controller.dart';
import '../models/schedule_pickup.dart';
import '../screen/home_screen_page.dart';  // Import the home page

class SchedulePickupScreen extends StatefulWidget {
  @override
  _SchedulePickupScreenState createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  final controller = SchedulePickupController();
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String selectedTime = "09:00 AM";
  int selectedWeek = 1;
  Set<String> wasteTypes = {};
  final TextEditingController weightController = TextEditingController();

  bool isPickupScheduled = false;

  List<String> availableTimes = ["09:00 AM", "10:00 AM", "11:00 AM", "02:00 PM"];
  List<String> wasteOptions = ["Plastic", "Metal", "Paper", "Glass", "Electronics"];

  void schedulePickup() {
    double? weight = double.tryParse(weightController.text);
    if (weight == null || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid weight in kg.")));
      return;
    }

    SchedulePickup newPickup = SchedulePickup(
      id: controller.pickups.length + 1,
      userId: "user123",
      pickupDate: selectedDate,
      pickupTime: selectedTime,
      pickupWeight: weight, // Add pickupWeight to the new pickup
      deliveryWeek: selectedWeek,
      wasteTypes: wasteTypes.toList(),
      createdAt: DateTime.now(),
    );
    controller.addPickup(newPickup);

    setState(() {
      isPickupScheduled = true;
    });

    // Show success alert
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Pickup Scheduled successfully!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigate to home page after the alert is dismissed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenPage()),
                );
              },
              child: Text("OK"),
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
        title: Text("Schedule Pickup"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Select Week", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<int>(
            value: selectedWeek,
            onChanged: (value) => setState(() => selectedWeek = value!),
            items: [1, 2, 3, 4].map((week) => DropdownMenuItem(value: week, child: Text("$week week${week > 1 ? 's' : ''}"))).toList(),
          ),
          SizedBox(height: 20),
          Text("Select Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime(2099, 12, 31),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            onDaySelected: (selected, focused) => setState(() {
              selectedDate = selected;
              focusedDay = focused;
            }),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(color: Colors.orange.shade300, shape: BoxShape.circle),
            ),
          ),
          SizedBox(height: 20),
          Text("Select Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: availableTimes.map((time) {
              return ChoiceChip(
                label: Text(time),
                selected: selectedTime == time,
                selectedColor: Colors.orange,
                onSelected: (_) => setState(() => selectedTime = time),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text("Waste Types", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: wasteOptions.map((waste) {
              return ChoiceChip(
                label: Text(waste),
                selected: wasteTypes.contains(waste),
                selectedColor: Colors.orange,
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      wasteTypes.add(waste);
                    } else {
                      wasteTypes.remove(waste);
                    }
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text("Enter Pickup Weight (kg)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter weight",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isPickupScheduled || wasteTypes.isEmpty || weightController.text.isEmpty 
                ? null 
                : schedulePickup,
            child: isPickupScheduled 
                ? Text("Pickup Scheduled!") 
                : Text("Schedule Pickup"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: isPickupScheduled || wasteTypes.isEmpty || weightController.text.isEmpty
                  ? Colors.grey
                  : Colors.orange,
            ),
          ),
        ]),
      ),
    );
  }
}
