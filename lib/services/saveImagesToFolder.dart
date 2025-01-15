import 'dart:convert';
import 'dart:io';
import "package:path_provider/path_provider.dart";

Future<String> writeTempImagesToFile({required List<File> tempImages}) async {
  try {
    final Directory storage = await getApplicationDocumentsDirectory();
    final String storageLocation = storage.path;
    final List<String> storedImages = [];
    for (var file in tempImages) {
      String saveFileAt = '$storageLocation/${file.uri.pathSegments.last}';
      final File savedFile = await file.copy(saveFileAt);
      storedImages.add(savedFile.path);
    }
    final String storedImagesJSON = jsonEncode(storedImages);
    return storedImagesJSON;
  } on MissingPlatformDirectoryException {
    throw Exception("Error opening storage file for the app");
  } catch (e) {
    throw Exception("Error Saving Gallery Images to Storage");
  }
}
