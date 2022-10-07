import 'package:api_post/model/all_user_model.dart';
import 'package:api_post/services/api_servive.dart';
import 'package:api_post/services/delete_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllUserData extends StatefulWidget {
  const AllUserData({Key? key}) : super(key: key);

  @override
  State<AllUserData> createState() => _AllUserDataState();
}

class _AllUserDataState extends State<AllUserData> {
  double a = 2.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiService.getData(),
        builder: (BuildContext context, AsyncSnapshot<AllUserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data!.users!.length,
                itemBuilder: (context, index) {
                  final common = snapshot.data!.users![index];
                  return Dismissible(
                    key: ValueKey(common.username),
                    background: Container(
                      color: Colors.blue,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        DeleteUserService.deleteUser(
                            {'username': common.username});
                      }
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          common.avatar.toString(),
                        ),
                      ),
                      title: Text(
                        common.firstName.toString(),
                      ),
                      subtitle: Text(
                        common.lastName.toString(),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            );
          }
        },
      ),
    );
  }
}
