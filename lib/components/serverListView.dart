import 'dart:ui';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import 'package:pscm/components/serverItemList.dart';
import 'package:pscm/core/model/dataServer.dart';

import '../core/eventTemplate.dart';
import '../core/servicesServer.dart';

class ServerListWidget extends StatefulWidget {
  final List<ServiceServer> serverData;
  final OnDeleteItemCallback onDeleteItemCallback;
  final OnUpdateItemCallback onUpdateItemCallback;

  const ServerListWidget ({ super.key, required this.serverData,
        required this.onDeleteItemCallback,
        required this.onUpdateItemCallback });

  @override
  ServerListWidgetState createState() => ServerListWidgetState();
}

class ServerListWidgetState extends State<ServerListWidget> {
  final GlobalKey<ImplicitlyAnimatedReorderableListState> _listKey = GlobalKey();

  Future deleteItemServer(int id) async {
    await widget.onDeleteItemCallback(id);
    setState(() {
      widget.serverData.removeWhere((item) => item.id == id);
    });
  }

  Future onUpadateServerConnectEvent(ServerInfo dataConnect) async {
    await widget.onUpdateItemCallback(dataConnect);
  }

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedReorderableList<ServiceServer>(
      key: _listKey,
      items: widget.serverData,
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      onReorderFinished: (item, from, to, newItems) {
        setState(() {
          widget.serverData
            ..clear()
            ..addAll(newItems);
        });
      },
      itemBuilder: (context, itemAnimation, item, index) {
        return Reorderable(
          key: ValueKey(item),
          builder: (context, dragAnimation, inDrag) {
            final t = dragAnimation.value;
            final elevation = lerpDouble(0, 8, t);
            final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);

            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: itemAnimation,
              child: Material(
                color: color,
                elevation: elevation!,
                type: MaterialType.transparency,
                child: ServerItemList(serverData: item,
                    onDeleteItemCallback: deleteItemServer,
                    onUpdateItemCallback: onUpadateServerConnectEvent),
              ),
            );
          },
        );
      },
      // If you want to use headers or footers, you should set shrinkWrap to true
      shrinkWrap: true,
    );
  }
}