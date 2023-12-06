

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pscm/core/model/dataServer.dart';
import 'package:pscm/core/utils/colorExtention.dart';
import 'package:pscm/core/model/dtoDataAPI.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/eventTemplate.dart';
import '../core/servicesServer.dart';
import '../screens/edit_server_connect_screen.dart';

class ServerItemList extends StatefulWidget {
  final ServiceServer serverData;
  final OnDeleteItemCallback onDeleteItemCallback;
  final OnUpdateItemCallback onUpdateItemCallback;

  const ServerItemList ({ super.key, required this.serverData,
        required this.onDeleteItemCallback,
        required this.onUpdateItemCallback});

  @override
  ServerItemListState createState() => ServerItemListState();
}

enum stateLoadData {
  wait,
  load,
  error
}

class ServerItemListState extends State<ServerItemList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  int get getKeyValueDismiss  {
    return widget.serverData.connect.id;
  }

  Future onEventUpdateConnect(ServerInfo dataInfo) async
  {
    await widget.onUpdateItemCallback(dataInfo);
    setState(() { widget.serverData.connect = dataInfo;});
  }

  Future onEventDeleteItem() async {
    await widget.onDeleteItemCallback(widget.serverData.connect.id);

  }

  Widget buildInfoServer(BuildContext context, stateLoadData stateLoad) {
    return Slidable(
        key: ValueKey(getKeyValueDismiss),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              //flex:1,
              onPressed: (context) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      EditServerScreen(
                          connectData: widget.serverData.connect)
                  ),
                ).then((value) async => await onEventUpdateConnect(value))
              },
              backgroundColor: '#294769'.toColor(),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.labelSlidableButtonEdit),
            SlidableAction(
              //flex:1,
              onPressed: (context) => onEventDeleteItem(),
              backgroundColor: '#f55442'.toColor(),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.labelSlidableButtonDelete),
          ],
        ),
        child: Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (stateLoad == stateLoadData.wait)
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                    image: AssetImage('assets/images/serveroffline.png'),
                    fit: BoxFit.contain,
                    width: 35,
                  ))
                else if (stateLoad == stateLoadData.load)
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                    image: AssetImage('assets/images/serveroff.png'),
                    fit: BoxFit.contain,
                    width: 35,
                  ))
                else if (stateLoad == stateLoadData.error)
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                    image: AssetImage('assets/images/serveroffline.png'),
                    fit: BoxFit.contain,
                    width: 35,
                  )),
                Column(
                    children: [
                      Text(widget.serverData.connect.name ?? '',
                          style: DefaultTextStyle.of(context).style.apply(fontWeightDelta: 1,
                            fontSizeFactor: 1.3)),
                      Text(widget.serverData.connect.descr ?? '',
                          style: Theme.of(context).textTheme.bodyMedium)
                    ]
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DTOInformationSystem?>(
      future: widget.serverData.fetchRemoteDataOSInformation(),
      builder: (BuildContext context, AsyncSnapshot<DTOInformationSystem?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          developer.log('ConnectionState.waiting');
          return buildInfoServer(context, stateLoadData.wait);
            //const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          developer.log('ConnectionState.error ${snapshot.error}');
          return buildInfoServer(context, stateLoadData.error);
        } else {
          developer.log('ConnectionState.load');
          return buildInfoServer(context, stateLoadData.load);
        }
      },
    );
  }
}
