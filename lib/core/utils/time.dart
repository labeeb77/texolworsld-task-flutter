import 'package:intl/intl.dart';

String formatTime(String time) {
  try {
    // Parse the string to a DateTime object
    DateTime parsedTime = DateTime.parse(time);

    // Format the time to 'hh:mm a' format (e.g., 10:40 PM)
    return DateFormat('hh:mm a').format(parsedTime);
  } catch (e) {
    // If parsing fails, return the original string or a default value
    return time;
  }
}