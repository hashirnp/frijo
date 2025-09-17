import 'package:flutter/material.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/provider/feed_provider.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:noviindus/view/Widgets/feed_item_widget.dart';
import 'package:noviindus/view/Widgets/profile_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 32,
        backgroundColor: Color(0xffC70000),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.addVideo);
          },
          icon: Icon(Icons.add, color: Colors.white, size: 48),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getIt<FeedProvider>().init();
        },
        child: SafeArea(
          child: Consumer<FeedProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading!) {
                return Center(
                  child: CircularProgressIndicator(color: AppConstants.red),
                );
              } else {
                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    (provider.categoryResponse == null)
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade700,
                            child: ListTile(
                              title: Text("Hello.... "),
                              subtitle: Text("Welcome back to Section"),
                              trailing: CircleAvatar(),
                            ),
                          )
                        : ProfileHeaderWidget(
                            selectedIndex: provider.getSelectedCategoryIndex!,
                            categories: provider.categoryResponse!.categories!,
                          ),
                    if (provider.videos.isNotEmpty)
                      ...provider.videos.map(
                        (video) => FeedItemWidget(video: video),
                      ),

                    if (provider.videos.isEmpty)
                      ...[1, 2, 3].map((e) {
                        return Shimmer(
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.red.withValues(alpha: 0.5),
                              Colors.grey.shade800,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xff171717),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User Info
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        "assets/images/user_placeholder.jpg",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12,
                                            width: 100,
                                            color: Colors.white24,
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            height: 10,
                                            width: 50,
                                            color: Colors.white24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // Video Placeholder
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      color: Colors.white12,
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black45,
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Text placeholders
                                Container(
                                  height: 12,
                                  width: double.infinity,
                                  color: Colors.white24,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  color: Colors.white24,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
