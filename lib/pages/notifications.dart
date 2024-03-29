import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:tween_wellness/pages/post_screen.dart';
import 'package:tween_wellness/pages/profile.dart';
import 'package:tween_wellness/widgets/header.dart';
import 'package:tween_wellness/widgets/progress.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  String display_text = '';
  final database1 = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    //get_HealthTips();
  }

  void get_HealthTips() {
    database1
        .child('users')
        .child('dXW7J3c8HXYYiWDcp1rZhO7wq3I3')
        .child('HTips')
        .orderByKey()
        .limitToLast(10)
        //.child('1656227187')
        .onValue
        .listen((event) {
      //.child('tips')

      //final String tips = event.snapshot.value.toString();
      final data =
          new Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final tips = data['tips'] as String;
      final tips_image = data['tips_image'] as String;
      setState(() {
        display_text = 'Hi $tips, $tips_image';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber ,
        appBar: header(context, titleText: 'Notifications'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Text(
                  'Health Tips',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                StreamBuilder(
                  stream: database1
                      .child('users')
                      .child('dXW7J3c8HXYYiWDcp1rZhO7wq3I3')
                      .child('HTips')
                      .orderByKey()
                      .limitToLast(10)
                      .onValue,
                  builder: (context, snapshot) {
                    final tilesList = <ListTile>[];
                    if (snapshot.hasData) {
                      final myTips = Map<String, dynamic>.from(
                          (snapshot.data! as DatabaseEvent).snapshot.value
                              as Map);
                      myTips.forEach((key, value) {
                        final nextTips = Map<String, dynamic>.from(value);
                        final tipsTile = ListTile(
                            leading: Image.network(nextTips['url'],
                                height: 100,
                                width: 100), //Icon(Icons.local_cafe)
                            title: Text(nextTips['tips']),
                            subtitle: Text(nextTips['tips_desc']));
                        tilesList.add(tipsTile);
                      });
                    }
                    return Expanded(
                      child: ListView(children: tilesList),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

//body
// SafeArea(
//           child: Container(
//             width: 115,
//             height: 145,
//             margin: EdgeInsets.fromLTRB(80, 20, 20, 20),
//             padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xFF959595)),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               color: Color(0xFFB2FFA6),
//             ),
//             alignment: Alignment.topCenter,
//             child: Text(
//               'Health Tips\n\n' + display_text,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         )

// getActivityFeed() async {
//   QuerySnapshot snapshot = await activityFeedRef
//       .doc(currentUser.id)
//       .collection('feedItems')
//       .orderBy('timestamp', descending: true)
//       .limit(50)
//       .get();
//   List<ActivityFeedItem> feedItems = [];
//   snapshot.docs.forEach((doc) {
//     feedItems.add(ActivityFeedItem.fromDocument(doc));
//     // print('Activity Feed Item: ${doc.data}');
//   });
//   return feedItems;
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.orange,
//     appBar: header(context, titleText: "Notifications"),
//     body: Container(
//         child: FutureBuilder(
//       future: getActivityFeed(),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (!snapshot.hasData) {
//           return circularProgress();
//         }
//         return ListView(
//           children: snapshot.data,
//         );
//       },
//     )),
//   );
// }

// Widget? mediaPreview;
// String? activityItemText;

// class ActivityFeedItem extends StatelessWidget {
//   final String? username;
//   final String? userId;
//   final String? type; // 'like', 'follow', 'comment'
//   final String? mediaUrl;
//   final String? postId;
//   final String? userProfileImg;
//   final String? commentData;
//   final Timestamp? timestamp;

//   ActivityFeedItem({
//     this.username,
//     this.userId,
//     this.type,
//     this.mediaUrl,
//     this.postId,
//     this.userProfileImg,
//     this.commentData,
//     this.timestamp,
//   });

//   factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
//     return ActivityFeedItem(
//       username: doc['username'],
//       userId: doc['userId'],
//       type: doc['type'],
//       postId: doc['postId'],
//       userProfileImg: doc['userProfileImg'],
//       commentData: doc['commentData'],
//       timestamp: doc['timestamp'],
//       mediaUrl: doc['mediaUrl'],
//     );
//   }

//   showPost(context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PostScreen(
//           postId: postId!,
//           userId: userId!,
//         ),
//       ),
//     );
//   }

//   configureMediaPreview(context) {
//     if (type == "like" || type == 'comment') {
//       mediaPreview = GestureDetector(
//         onTap: () => showPost(context),
//         child: Container(
//           height: 50.0,
//           width: 50.0,
//           child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: CachedNetworkImageProvider(mediaUrl!),
//                   ),
//                 ),
//               )),
//         ),
//       );
//     } else {
//       mediaPreview = Text('');
//     }

//     if (type == 'like') {
//       activityItemText = "liked your post";
//     } else if (type == 'follow') {
//       activityItemText = "is following you";
//     } else if (type == 'comment') {
//       activityItemText = 'replied: $commentData';
//     } else {
//       activityItemText = "Error: Unknown type '$type'";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     configureMediaPreview(context);

//     return Padding(
//       padding: EdgeInsets.only(bottom: 2.0),
//       child: Container(
//         color: Colors.white54,
//         child: ListTile(
//           title: GestureDetector(
//             onTap: () => showProfile(context, profileId: userId),
//             child: RichText(
//               overflow: TextOverflow.ellipsis,
//               text: TextSpan(
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.black,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: username,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     TextSpan(
//                       text: ' $activityItemText',
//                     ),
//                   ]),
//             ),
//           ),
//           leading: CircleAvatar(
//             backgroundImage: CachedNetworkImageProvider(userProfileImg!),
//           ),
//           subtitle: Text(
//             timeago.format(timestamp!.toDate()),
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: mediaPreview,
//         ),
//       ),
//     );
//   }
// }

showProfile(BuildContext context, {String? profileId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Profile(
        profileId: profileId!,
      ),
    ),
  );
}
