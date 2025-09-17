import 'package:flutter/material.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:noviindus/view/Widgets/feed_item_widget.dart';
import 'package:noviindus/view/Widgets/profile_header_widget.dart';

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
        onRefresh: () async {},
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileHeaderWidget(),
              FeedItemWidget(
                videoUrl:
                    'https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4',
                thumbnailUrl:
                    'https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png',
                userName: 'Frijo',
                timeAgo: '2024-06-12T10:46:15.817244Z',
                description: 'GENDER AND SOCIETY',
              ),
              FeedItemWidget(
                videoUrl:
                    "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
                thumbnailUrl:
                    "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
                userName: "Michel Jhon",
                timeAgo: "5 days ago",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
