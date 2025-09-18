import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frijo/core/constants/app_constants.dart';
import 'package:frijo/injection.dart';
import 'package:frijo/provider/feed_provider.dart';
import 'package:frijo/view/Widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final descriptionController = TextEditingController();
  final imagePicker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<FeedProvider>().setVideo(null);
      getIt<FeedProvider>().setThumbnail(null);
      getIt<FeedProvider>().clearSelectedCategories();
    });
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Consumer<FeedProvider>(
        builder: (context, provider, child) {
          if (provider.isUploadStart!) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  CircularProgressIndicator(
                    value: provider.uploadPresent,
                    color: AppConstants.red,
                  ),
                  Text(
                    "${(provider.uploadPresent! * 100).toStringAsFixed(2)} % Completed",
                  ),
                ],
              ),
            );
          }

          if (provider.isLoading!) {
            return Center(
              child: CircularProgressIndicator(color: AppConstants.red),
            );
          }

          if (provider.errorMessage != null &&
              provider.postShareStatus == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.errorMessage!),
                  backgroundColor: AppConstants.red,
                ),
              );
              provider
                  .resetPostStatus(); // Clear the error message after showing
            });
          }

          if (provider.errorMessage == null &&
              provider.postShareStatus == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Feed Uploaded Succesfully"),
                  backgroundColor: AppConstants.red,
                ),
              );
              provider
                  .resetPostStatus(); // Clear the error message after showing
              provider.fetchVideos();
              Navigator.of(context).pop();
            });
          }

          return SafeArea(
            child: Form(
              key: formKey,
              child: CustomScrollView(
                slivers: [
                  /// Top App Bar
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 60,
                    backgroundColor: Colors.black,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Add Feeds",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            provider.sharePost();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppConstants.red.withValues(alpha: 0.5),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Share Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Body
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Video Upload Box
                          GestureDetector(
                            onTap: () async {
                              //select video from galley
                              final selectedvideo = await imagePicker.pickVideo(
                                source: ImageSource.gallery,
                              );

                              if (selectedvideo != null) {
                                getIt<FeedProvider>().setVideo(selectedvideo);
                              }
                            },
                            child: DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                dashPattern: [10, 10],
                                strokeWidth: 1,
                                radius: Radius.circular(16),
                                color: Colors.grey.shade500,
                                padding: EdgeInsets.all(16),
                              ),
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.video != null
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.red,
                                            size: 48,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/upload_video_icon.svg",
                                            height: 40,
                                            colorFilter: ColorFilter.mode(
                                              Colors.white,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                    const SizedBox(height: 8),

                                    Text(
                                      provider.video != null
                                          ? "Video Selected: ${provider.video!.name}"
                                          : "Add a Video",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Thumbnail Upload
                          GestureDetector(
                            onTap: () async {
                              //select thumbnail
                              final selectedImage = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );

                              if (selectedImage != null) {
                                getIt<FeedProvider>().setThumbnail(
                                  selectedImage,
                                );
                              }
                            },
                            child: DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                dashPattern: [10, 10],
                                strokeWidth: 1,
                                radius: Radius.circular(16),
                                color: Colors.grey.shade500,
                                padding: EdgeInsets.all(16),
                              ),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.thumbnail != null
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.red,
                                            size: 48,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/upload_thum_logo.svg",
                                            // height: 40,
                                            colorFilter: ColorFilter.mode(
                                              Colors.white,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                    const SizedBox(height: 8),
                                    Text(
                                      provider.thumbnail != null
                                          ? "Thumbnail Selected: ${provider.thumbnail!.name}"
                                          : "Add Thumbnail",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          /// Description
                          const Text(
                            "Add Description",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // const Text(
                          //   "Lorem ipsum dolor sit amet consectetur. Congue nec lectus "
                          //   "eget fringilla urna viverra integer justo vitae. Tincidunt cum "
                          //   "pellentesque ipsum mi. Posuere at diam lorem est pharetra.",
                          //   style: TextStyle(color: Colors.white70, height: 1.5),
                          // ),
                          TextFormField(
                            controller: descriptionController,
                            maxLines: 5,
                            style: const TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              hintText: "Write description here...",
                              hintStyle: TextStyle(
                                color: Colors.white54.withAlpha(150),
                              ),
                              filled: true,
                              fillColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              provider.setDescription(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Divider(color: Colors.grey.shade800, height: 1),
                          const SizedBox(height: 24),

                          /// Categories
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Categories This Project",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "View All",
                              //       style: TextStyle(
                              //         color: Colors.white70,
                              //         fontSize: 14,
                              //       ),
                              //     ),
                              //     SizedBox(width: 4),
                              //     Icon(
                              //       Icons.arrow_forward_ios,
                              //       size: 14,
                              //       color: Colors.white70,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          /// Category Chips
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...getIt<FeedProvider>()
                                  .categoryResponse!
                                  .categories!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    final e = entry.value;
                                    final index =
                                        entry.key; // index of the category

                                    return CommonWidgets.buildCategoryChip(
                                      category: e,

                                      index: index,
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
