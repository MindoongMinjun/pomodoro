import 'package:flutter/material.dart';
import 'dart:async';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  static const int twentyFive = 1500;
  int totalSeconds = twentyFive;
  int totalPomodoros = 0;
  bool isRunning = true;
  Icon icon = const Icon(Icons.play_circle_outline_outlined);
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        timer.cancel();
        icon = const Icon(Icons.play_circle_outline_outlined);
        totalPomodoros += 1;
        totalSeconds = twentyFive;
        isRunning = true;
      });
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onPressed() {
    if (isRunning == true) {
      setState(() {
        icon = const Icon(Icons.pause_circle_outline_outlined);
        timer = Timer.periodic(const Duration(seconds: 1), onTick);
        isRunning = false;
      });
    } else if (isRunning == false) {
      setState(() {
        icon = const Icon(Icons.play_circle_outline_outlined);
        timer.cancel();
        isRunning = true;
      });
    }
  }

  void onStopPressed() {
    setState(() {
      icon = const Icon(Icons.play_circle_outline_outlined);
      totalSeconds = twentyFive;
      timer.cancel();
      isRunning = true;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 90,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: onPressed,
                  icon: icon,
                ),
                IconButton(
                  onPressed: onStopPressed,
                  icon: const Icon(
                    Icons.stop_circle_outlined,
                  ),
                  color: Theme.of(context).cardColor,
                  iconSize: 50,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
