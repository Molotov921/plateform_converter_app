import 'package:platform_converter_ios_android/components/ios/call.dart';
import 'package:platform_converter_ios_android/components/ios/chat.dart';
import 'package:platform_converter_ios_android/components/ios/setting.dart';
import 'package:platform_converter_ios_android/provider/theme_chenge_app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeI extends StatefulWidget {
  const HomeI({super.key});

  @override
  State<HomeI> createState() => _HomeIState();
}

class _HomeIState extends State<HomeI> {
  @override
  void initState() {
    super.initState();
  }

  List<String> titles = ['Chats', 'Calls', 'Settings'];
  List<Widget> allComponants = [
    const ChatDesign(),
    const CallDesign(),
    const SettingsDesign(),
  ];

  @override
  Widget build(BuildContext context) {
    var themePro = Provider.of<ThemeChangeAppProvider>(context);
    var themeProFalse =
        Provider.of<ThemeChangeAppProvider>(context, listen: false);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Platform Convertor'),
        trailing: CupertinoSwitch(
          value: !themePro.isAndroid,
          onChanged: (value) {
            themeProFalse.platFromCheck();
          },
        ),
        leading: const Icon(CupertinoIcons.list_bullet),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: allComponants[index],
                );
              },
            );
          }),
    );
  }
}
