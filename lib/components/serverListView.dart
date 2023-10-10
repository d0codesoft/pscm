import 'dart:ui';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pscm/components/serverItemList.dart';

import '../core/eventTemplate.dart';
import '../core/servicesServer.dart';

class ServerListWidget extends StatefulWidget {
  final List<ServiceServer> serverData;

  const ServerListWidget ({ Key? key, required this.serverData }):
        super(key: key);

  @override
  ServerListWidgetState createState() => ServerListWidgetState();
}

class ServerListWidgetState extends State<ServerListWidget> {


  Future deleteItemServer(int id) async {
  }

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedReorderableList<ServiceServer>(
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
                child: ServerItemList(serverData: item, onDeleteItemCallback: deleteItemServer),
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