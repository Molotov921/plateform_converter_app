import 'package:platform_converter_ios_android/provider/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDesign extends StatelessWidget {
  const SettingsDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var monthProvider = Provider.of<MonthProvider>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      (monthProvider.dateChecked)
                          ? monthProvider.dateModel.date
                          : monthProvider.dateFind(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 50,
                  width: double.infinity,
                  color: Colors.blue,
                  child: TextButton(
                    onPressed: () {
                      monthProvider.dateFind1(context);
                    },
                    child: const Text(
                      'Change Date',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    (monthProvider.timeChecked)
                        ? monthProvider.timeModel.timeOfDay
                        : monthProvider.timeFind(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 50,
                width: double.infinity,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () async {
                    monthProvider.timeFind1(context);
                  },
                  child: const Text(
                    'Change Time',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
