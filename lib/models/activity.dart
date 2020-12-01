import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Activity {
  String docId;
  DocumentReference friendDocRef;
  String avatarPhotoUrl;
  String friendName;
  DateTime time;
  String caption;
  String imageUrl;
  int likes;
  int comments;
  int shares;

  final DateFormat dateFormatter = DateFormat('EEEE hh:mm aa');

  Activity({
    this.docId,
    this.friendDocRef,
    this.avatarPhotoUrl,
    this.friendName,
    this.time,
    this.caption,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
  });

  Map<String, dynamic> toJson() => {
        s_friendDocRef: friendDocRef,
        s_avatarPhotoUrl: avatarPhotoUrl,
        s_time: Timestamp.fromDate(time),
        s_friendName: friendName,
        s_caption: caption,
        s_imageUrl: imageUrl,
        s_likes: likes,
        s_comments: comments,
        s_shares: shares,
      };

  void fromJson(Map<String, dynamic> data, String activityId) {
    this.docId = activityId;

    friendDocRef = data[s_friendDocRef];
    avatarPhotoUrl = data[s_avatarPhotoUrl];
    friendName = data[s_friendName];
    time = (data[s_time] as Timestamp).toDate();
    caption = data[s_caption];
    imageUrl = data[s_imageUrl];
    likes = data[s_likes];
    comments = data[s_comments];
    shares = data[s_shares];
  }

  String getTime() {
    if (time == null) {
      return 'Unknown';
    }
    return dateFormatter.format(time);
  }

  static const String s_friendDocRef = 'friend_doc_ref';
  static const String s_avatarPhotoUrl = 'avatar_photo_url';
  static const String s_friendName = 'friend_name';
  static const String s_time = 'time';
  static const String s_caption = 'caption';
  static const String s_imageUrl = 'image_url';
  static const String s_likes = 'likes';
  static const String s_comments = 'comments';
  static const String s_shares = 'shares';
}
