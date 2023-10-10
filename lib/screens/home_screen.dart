import 'dart:io';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:pscm/core/database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pscm/core/model/dataServer.dart';
import 'package:pscm/core/utils/colorExtention.dart';
import 'package:pscm/screens/edit_server_connect_screen.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/serverItemList.dart';
import '../components/serverListView.dart';
import '../core/servicesServer.dart';
import 'add_server_screen.dart';

class HomeScreen extends StatefulWidget {
  static String route = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBProvider database = DBProvider.instance;
  QuickActions quickActions = QuickActions();
  ServiceServers serviceData = ServiceServerRepository();
  bool inReorder = false;

  Future refresh() async {
    setState(() {});
  }

  void getData() {
    refresh();
  }

  Future<bool> _requestPermission() async {
    return false;
  }

  void askPermission() async {
    //await _requestPermission();
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  Future deleteItemServer(int id) async {
    var result = await serviceData.deleteServerConnect(id);
    if (result) {
      setState(() {
      });
    }
  }

  Future updateItemServerInfo(ServerInfo upd) async {
    await database.updateServerInfo(upd);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.primary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Power server control", style: TextStyle(
                color: Colors.white
            )),
          ),
          body: Container(
            //margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: FutureBuilder<List<ServiceServer>>(
              future: serviceData.allServiceServers(),
              builder: (BuildContext context, AsyncSnapshot<List<ServiceServer>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  if (snapshot.data?.isEmpty ?? true) {
                    return Center(child: Text(AppLocalizations.of(context)!.listServerNoItem));
                  }
                  return ServerListWidget( serverData: snapshot.data!
                  );
                }
              },
            )
          ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(height: 50.0),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                         EditServerScreen()
                    ),
                  ).then((value) => updateItemServerInfo(value))
                },
                tooltip: AppLocalizations.of(context)!.addNewServerTooltip,
                child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        )
    );
  }
}