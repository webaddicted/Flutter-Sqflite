import 'package:flutter/material.dart';
import 'package:fluttersqflite/global/constant/string_constant.dart';
import 'package:fluttersqflite/global/utils/widget_helper.dart';
import 'package:fluttersqflite/model/db/user_table.dart';
import 'package:fluttersqflite/model/user_bean.dart';
import 'package:fluttersqflite/view/login/edit_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  BuildContext ctx;
  List<UserBean> dataResult;

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          getAppBarWithBackBtn(context, StrConstant.SQFLITE_USERHOME_TITLE),
      body: Builder(
        builder: (context) => _createUi(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (_) => EditUser.data(null)),)
            .then((val) => val ? _getRequests() : null)
      ),
    );
  }

  Widget _createUi(BuildContext context) {
    ctx = context;
    return new Container(
      child: new ListView.builder(
          itemCount: dataResult == null ? 0 : dataResult.length,
          itemBuilder: (BuildContext context, int index) {
            return createRow(index);
          }),
    );
  }

  Widget createRow(int index) {
    UserBean userBean = dataResult[index];
    return GestureDetector(
      onTap: () => {
        showAlertDialog(context, "${userBean.name}",
            "Email Id : ${userBean.emailId}\nDOB : ${userBean.dob}")
      },
      child: Card(
        margin: EdgeInsets.all(3),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("${userBean.name}",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  Container(child: _getPopupMenu(userBean)),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 3)),
              Text("Email Id : ${userBean.emailId}"),
              Padding(padding: EdgeInsets.only(top: 3)),
              Text("Mobile No : ${userBean.mobileNo}"),
              Padding(padding: EdgeInsets.only(top: 3)),
              Text("DOB : ${userBean.dob}"),
              Padding(padding: EdgeInsets.only(top: 3)),
            ],
          ),
        ),
      ),
    );
  }

  void getAllUsers() async {
    List<UserBean> alluser = await UserTable.getUserAllInfo();
    dataResult = alluser;
    setState(() {});
  }

  Widget _getPopupMenu(UserBean userBean) {
    return PopupMenuButton(
      itemBuilder: (_) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(child: const Text('Edit User'), value: '0'),
        PopupMenuItem<String>(child: const Text('Delete User'), value: '1'),
      ],
      onSelected: (selected) {
        switch (selected) {
          case '0':
            {Navigator.of(context).push(new MaterialPageRoute(
                  builder: (_) => EditUser.data(userBean)),)
                  .then((val) => val ? _getRequests() : null);
            }
        // navigationPush(context, SqfliteEditUser.data(userBean));
            break;
          case '1':
            {
              UserTable.deleteUser(userBean.emailId);
              getAllUsers();
              showSnackBar(ctx, "${userBean.name} successfully deleted.");
              setState(() {});
              break;
            }
        }
        print(selected);
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.blue,
      ),
    );
  }
  _getRequests()async{
    setState(() {
      getAllUsers();
    });
  }
//  void _getRequests() async{
//    setState(() {
//
//    });
//  }
}
