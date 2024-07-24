import 'package:image_picker/image_picker.dart';

class MediaAdder {
  Future imagePicker(ImageSource source) async {
   final ImagePicker picker = ImagePicker();
    XFile? _image = await picker.pickImage(source: source);
    if (_image != null) {
      return await _image.readAsBytes();
    } else {
      return null;
    }
  }
}
