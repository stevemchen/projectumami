import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User_Model extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String userEmail;
  @HiveField(3)
  bool loginComplete;

  User_Model({this.id, this.name, this.userEmail, this.loginComplete = false});
}
