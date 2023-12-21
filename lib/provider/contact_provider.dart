import 'package:platform_converter_ios_android/model/contact_controller.dart';
import 'package:platform_converter_ios_android/model/contact_model.dart';
import 'package:platform_converter_ios_android/model/current_step.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contactList = [
    Contact(
      name: 'Neel',
      contact: '93281 19097',
      email: 'kalarianeel249@gmail.com',
      assetPic: 'assets/img/Neel.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Pranav',
      contact: '94294 65002',
      email: 'pranav@gmail.com',
      assetPic: 'assets/img/pranav.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Jeet',
      contact: '97445 45621',
      email: 'jeet@gmail.com',
      assetPic: 'assets/img/jeet.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Pankaj Muchhadiya',
      contact: '85554 92616',
      email: 'pankaj@gmail.com',
      assetPic: 'assets/img/pankaj.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Vraj Godhani',
      contact: '85552 38284',
      email: 'vraj@gmail.com',
      assetPic: 'assets/img/vraj.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Raj',
      contact: '85550 06322',
      email: 'raj@gmail.com',
      assetPic: 'assets/img/raj.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Harsh',
      contact: '85558 56691',
      email: 'harsh@gmail.com',
      assetPic: 'assets/img/harsh.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Manav',
      contact: '97555 58289',
      email: 'manav@gmail.com',
      assetPic: 'assets/img/manav.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Deep',
      contact: '85558 54253',
      email: 'deep@gmail.com',
      assetPic: 'assets/img/deep.jpg',
      time: 'Yesterday,11:20 AM',
    ),
    Contact(
      name: 'Preet Jagani',
      contact: '75672 66601',
      email: 'preetjagani@gmail.com',
      assetPic: 'assets/img/preet.jpg',
      time: 'Yesterday,11:20 AM',
    ),
  ];

  CurrentStep cs = CurrentStep(currentStep: 0);

  ControllerVar convar = ControllerVar(
      nameC: TextEditingController(text: ''),
      emailC: TextEditingController(text: ''),
      contactC: TextEditingController(text: ''));

  void addContact(String name, String contact, String email) {
    Contact data = Contact(
      name: name,
      contact: contact,
      email: email,
      pic: pickImage!,
      time: 'Just Now',
    );
    contactList.add(data);
    notifyListeners();
  }

  void addData(String name, String contact, String email) {
    Contact data = Contact(
      pic: pickImage!,
      name: name,
      contact: contact,
      email: email,
      time: 'Just Now',
    );
    contactList.add(data);
    notifyListeners();
  }

  String? pickImage;

  imagePicCamera() async {
    ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.camera);
    String? path = res!.path;
    pickImage = path;
    notifyListeners();
  }

  imagePicGalary() async {
    ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.gallery);
    String? path = res!.path;
    pickImage = path;
    notifyListeners();
  }

  checkFillData() {
    if (convar.nameC.text.isNotEmpty &&
        convar.emailC.text.isNotEmpty &&
        convar.contactC.text.isNotEmpty) {
      addData(
        convar.nameC.text,
        convar.contactC.text,
        convar.emailC.text,
      );
      convar.contactC.clear();
      convar.nameC.clear();
      convar.emailC.clear();
    } else if (convar.nameC.text.isNotEmpty &&
        convar.emailC.text.isNotEmpty &&
        convar.contactC.text.isNotEmpty) {
      addContact(convar.nameC.text, convar.contactC.text, convar.emailC.text);

      convar.contactC.clear();
      convar.nameC.clear();
      convar.emailC.clear();
    }
    notifyListeners();
  }

  checkContinueState() {
    if (cs.currentStep < 3) {
      cs.currentStep++;
    }
    notifyListeners();
  }

  checkCancelState() {
    if (cs.currentStep > 0) {
      cs.currentStep--;
    }
    notifyListeners();
  }

  Contact? _selectedContact;

  Contact? get selectedContact => _selectedContact;

  void deleteSelectedContact() {
    if (_selectedContact != null) {
      contactList.remove(_selectedContact);
      _selectedContact = null; // Clear the selected contact after deletion
      notifyListeners();
    }
  }
}
