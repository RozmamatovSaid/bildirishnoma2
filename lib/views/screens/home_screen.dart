import 'package:nottification_2/index.dart';
import 'package:nottification_2/views/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  const HomeScreen({super.key, required this.flutterLocalNotificationsPlugin});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _todosRef = FirebaseDatabase.instance.ref().child(
    'masseges',
  );

  final controller = TextEditingController();

  void showSimpleNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          "your_channel_id",
          "your_channel_name",
          channelDescription: "your channel description",
          importance: Importance.max,
          priority: Priority.high,
          ticker: "ticker",
        );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await widget.flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Lesson 61",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                controller: controller,
                borderRadius: 20,
                fillColor: Colors.amber,
                hint: 'Send Notification...',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,

        child: Icon(Icons.send, color: Colors.black),
        onPressed: () async {
          showSimpleNotification(title: controller.text, body: "Birinchi App");
          if (controller.text.isNotEmpty) {
            final Map data = {"body": "Birinchi App", "title": controller.text};
            await _todosRef.push().set(data);
          }
        },
      ),
    );
  }
}
