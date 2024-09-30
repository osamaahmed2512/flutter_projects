import 'dart:typed_data';

import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
   UploadImage(
      {super.key, this.image, this.selectImage, this.deleteImage});
  final Uint8List? image;
  final VoidCallback? selectImage;
  final VoidCallback? deleteImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (image != null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Image.memory(
                              image ?? Uint8List(0),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Show bottom sheet with options
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text('Delete Image'),
                                        onTap: ()  {
                                           Navigator.of(context).pop(); // Close bottom sheet
                                          Navigator.of(context).pop(); // Close the dialog
                                          if (deleteImage != null) {
                                            // ImageCache().clear()
                                          
                                            deleteImage!(); // Safely call the delete function
                                            print("Image deleted");
                                         }
                                          

                                          // Call delete function
                                        },
                                      ),
                                      // Add more options here if needed
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          child: CircleAvatar(
            radius: 70,
            backgroundImage: image != null
                ? MemoryImage(image!)
                : AssetImage("assets/images/default_png_for_email.png")
                    as ImageProvider,
          ),
        ),
        Positioned(
          bottom: -10,
          left: 100,
          child: IconButton(
            onPressed: selectImage,
            icon: const Icon(Icons.add_a_photo),
          ),
        ),
        
      ],
    );
  }
}
