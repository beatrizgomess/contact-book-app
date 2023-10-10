import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageService {
  takeImage(XFile? photo) async {
    final ImagePicker imagePicker = ImagePicker();
    photo = await imagePicker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      String path =
          (await path_provider.getApplicationDocumentsDirectory()).path;
      String name = basename(photo!.path);
      photo!.saveTo("$path/$name");
      await GallerySaver.saveImage(photo!.path);
    }
  }

  saveImageGallery(XFile? photo) async {
    final ImagePicker imagePicker = ImagePicker();
    photo = await imagePicker.pickImage(source: ImageSource.gallery);
  }
}
