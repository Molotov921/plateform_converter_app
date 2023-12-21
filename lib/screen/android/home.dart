import 'dart:io';
import 'package:platform_converter_ios_android/components/android/calls.dart';
import 'package:platform_converter_ios_android/components/android/chats.dart';
import 'package:platform_converter_ios_android/components/android/settings.dart';
import 'package:platform_converter_ios_android/provider/contact_provider.dart';
import 'package:platform_converter_ios_android/provider/theme_provider.dart';
import 'package:platform_converter_ios_android/screen/android/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeA extends StatefulWidget {
  const HomeA({super.key});

  @override
  State<HomeA> createState() => _HomeAState();
}

class _HomeAState extends State<HomeA> with SingleTickerProviderStateMixin {
  late TabController tabController;
  PageController pageController = PageController();

  String platform = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: allComponants.length, vsync: this);
  }

  List<Widget> allComponants = [
    const ChatDesign(),
    const CallDesign(),
    const SettingsDesign(),
  ];
  bool isNotSettings = false;

  @override
  Widget build(BuildContext context) {
    var themePro = Provider.of<ThemeChangeAppProvider>(context);
    var themeProFalse =
        Provider.of<ThemeChangeAppProvider>(context, listen: false);
    return DefaultTabController(
      length: allComponants.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Platform Convertor',
          ),
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Switch(
                inactiveTrackColor: Colors.white54,
                thumbIcon: const MaterialStatePropertyAll(
                  Icon(
                    Icons.android_rounded,
                    color: Colors.green,
                  ),
                ),
                value: !themePro.isAndroid,
                onChanged: (value) {
                  themeProFalse.platFromCheck();
                },
              ),
            ),
          ],
          bottom: TabBar(
              onTap: (val) {
                if (val == 2) {
                  isNotSettings = true;
                  setState(() {});
                } else {
                  isNotSettings = false;
                  setState(() {});
                }
                pageController.animateToPage(
                  val,
                  duration: const Duration(microseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              controller: tabController,
              tabs: const <Tab>[
                Tab(
                  text: 'Chat',
                ),
                Tab(
                  text: 'Calls',
                ),
                Tab(
                  text: 'Settings',
                ),
              ]),
        ),
        floatingActionButton: (!isNotSettings)
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Alert();
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              )
            : Container(),
        drawer: const Navbar(),
        body: Container(
          alignment: Alignment.center,
          child: PageView(
            onPageChanged: (val) {
              tabController.animateTo(val);
            },
            controller: pageController,
            children: allComponants,
          ),
        ),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<ContactProvider>(context);
    return AlertDialog(
      title: const Text(
        'Add Contact',
      ),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Stepper(
          controlsBuilder: (context, details) {
            if (addDataP.cs.currentStep == 0) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              );
            } else if (addDataP.cs.currentStep == 3) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkFillData();
                      addDataP.checkContinueState();
                      Navigator.pop(context);
                      addDataP.cs.currentStep = 0;
                    },
                    child: const Text('Finish'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            }
          },
          currentStep: addDataP.cs.currentStep,
          steps: <Step>[
            Step(
              state: (addDataP.cs.currentStep == 0)
                  ? StepState.editing
                  : (addDataP.convar.nameC.text.isEmpty)
                      ? StepState.error
                      : StepState.complete,
              title: const Text('Profile Image'),
              content: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.black54,
                              ),
                            ),
                            child: (addDataP.pickImage != null)
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        FileImage(File(addDataP.pickImage!)),
                                  )
                                : const CircleAvatar(
                                    radius: 40,
                                    child: FlutterLogo(),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  addDataP.imagePicCamera();
                                },
                                child: const Icon(Icons.camera),
                              ),
                              const SizedBox(height: 10),
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  addDataP.imagePicGalary();
                                },
                                child: const Icon(Icons.photo),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 1)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 1)
                      ? StepState.editing
                      : (addDataP.convar.nameC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Name'),
              content: TextField(
                controller: addDataP.convar.nameC,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 2)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 2)
                      ? StepState.editing
                      : (addDataP.convar.nameC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Email'),
              content: TextField(
                controller: addDataP.convar.emailC,
                decoration: const InputDecoration(hintText: 'Enter your Email'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 3)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 3)
                      ? StepState.editing
                      : (addDataP.convar.nameC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Contact'),
              content: TextField(
                onSubmitted: (val) {
                  addDataP.convar.contactC.text = val;
                },
                keyboardType: TextInputType.phone,
                controller: addDataP.convar.contactC,
                maxLength: 10,
                decoration:
                    const InputDecoration(hintText: 'Enter your Contact'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
