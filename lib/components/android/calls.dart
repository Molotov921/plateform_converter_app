import 'dart:io';
import 'package:platform_converter_ios_android/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallDesign extends StatelessWidget {
  const CallDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context);
    return ListView(
      children: contactProvider.contactList.map((e) {
        return InkWell(
          onTap: () {},
          child: ListTile(
            leading: (e.pic == null)
                ? CircleAvatar(
                    foregroundImage: AssetImage(e.assetPic!),
                    radius: 30,
                  )
                : CircleAvatar(
                    foregroundImage: FileImage(
                      File(e.pic!),
                    ),
                    radius: 30,
                  ),
            title: Text(e.name),
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.call,
                color: Colors.green,
                size: 30,
              ),
            ),
            subtitle: Text(
              e.time,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      }).toList(),
    );
  }
}
