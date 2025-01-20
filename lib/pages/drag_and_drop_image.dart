import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class DragAndDropImage extends StatefulWidget {
  const DragAndDropImage({super.key});

  @override
  State<DragAndDropImage> createState() => _DragAndDropImageState();
}

class _DragAndDropImageState extends State<DragAndDropImage> {
  final List<String> images = [
    "assets/images/cat1.jpg",
    "assets/images/cat2.jpg",
    "assets/images/cat3.jpeg",
    "assets/images/cat4.jpeg",
    "assets/images/cat5.jpeg",
  ];

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? selectedImage;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    String? savedImagePath = await storage.read(key: 'capturedImage');
    if (savedImagePath != null) {
      setState(() {
        images.insert(0, savedImagePath);
      });
    }
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final savedImagePath =
          "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final savedImage = await File(pickedFile.path).copy(savedImagePath);

      await storage.write(key: 'capturedImage', value: savedImage.path);

      setState(() {
        images.insert(0, savedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag and Drop Image"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: _captureImage,
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(Icons.add, color: Colors.black),
                    ),
                  );
                }

                final imagePath = images[index - 1];
                return Draggable<String>(
                  data: imagePath,
                  feedback: imagePath.startsWith('assets')
                      ? Image.asset(
                          imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                  childWhenDragging: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: imagePath.startsWith('assets')
                        ? Image.asset(
                            imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.5),
                          )
                        : Image.file(
                            File(imagePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.5),
                          ),
                  ),
                  onDragStarted: () {
                    setState(() {
                      isDragging = true;
                    });
                  },
                  onDragEnd: (details) {
                    setState(() {
                      isDragging = false;
                    });
                  },
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      isDragging = false;
                    });
                  },
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: imagePath.startsWith('assets')
                          ? Image.asset(
                              imagePath,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DragTarget<String>(
              onAcceptWithDetails: (image) {
                setState(() {
                  selectedImage = image.data;
                  images.remove(image.data);
                });
              },
              onWillAcceptWithDetails: (image) => true,
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: selectedImage != null
                      ? Draggable<String>(
                          data: selectedImage,
                          feedback: selectedImage!.startsWith('assets')
                              ? Image.asset(
                                  selectedImage!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(selectedImage!),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          childWhenDragging: const SizedBox.shrink(),
                          child: selectedImage!.startsWith('assets')
                              ? Image.asset(
                                  selectedImage!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(selectedImage!),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        )
                      : const Center(
                          child: Text(
                            'Drag an image here',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (selectedImage != null)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  images.add(selectedImage!);
                  selectedImage = null;
                });
              },
              child: const Text('Send Back to List'),
            ),
        ],
      ),
    );
  }
}
