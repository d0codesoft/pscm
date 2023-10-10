

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pscm/core/utils/colorExtention.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:pscm/core/model/dtoDataAPI.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/eventTemplate.dart';
import '../core/servicesServer.dart';
import '../screens/edit_server_connect_screen.dart';

class ServerItemList extends StatefulWidget {
  final ServiceServer serverData;
  final OnDeleteItemCallback onDeleteItemCallback;

  const ServerItemList ({ Key? key, required this.serverData, required this.onDeleteItemCallback}): super(key: key);

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
    return widget.serverData?.connect?.id ?? 0;
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
                )
              },
              backgroundColor: '#294769'.toColor(),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.labelSlidableButtonEdit),
            SlidableAction(
              //flex:1,
              onPressed: (context) => widget.onDeleteItemCallback(widget.serverData.connect.id),
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
                    width: 25,
                  ))
                else if (stateLoad == stateLoadData.load)
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                    image: AssetImage('assets/images/serveroff.png'),
                    fit: BoxFit.contain,
                    width: 25,
                  ))
                else if (stateLoad == stateLoadData.error)
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                    image: AssetImage('assets/images/serveroffline.png'),
                    fit: BoxFit.contain,
                    width: 25,
                  )),
                Column(
                    children: [
                      Text(widget.serverData.connect.name ?? ''),
                      Text('data')
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
