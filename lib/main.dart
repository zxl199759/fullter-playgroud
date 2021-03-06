import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/PositionedTiles.dart';
import 'package:flutter_playground/widget/dragger/page_dragger_widget.dart';
import 'package:flutter_playground/widget/global_keys_demo.dart';
import 'package:flutter_playground/widget/intervalprogress.dart';
import 'package:flutter_playground/widget/localization_delegate.dart';
import 'package:flutter_playground/widget/search_page.dart';
import 'package:flutter_playground/widget/wave_card.dart';

void main() => runApp(MyApp());

class Item {
  final String title;
  String desc;
  final WidgetBuilder widgetBuilder;

  Item(this.title, this.widgetBuilder, {String desc}) {
    this.desc = desc ?? "";
  }
}

List<Item> pages = [
  Item("Wave Card", (ctx) => WaveCards()),
  Item("Positioned Tiles", (ctx) => PositionedTiles(),
      desc: "Lear How to Use Key"),
  Item("Using GlobalKey to Reuse Widget", (ctx) => GlobalKeysReuseWidget()),
  Item("Page Dragger Widget", (ctx) => PageDraggerWidget()),
  Item("IntervalProgressBar", (ctx) => IntervalProgressPage(),
      desc: "Custom Painter"),
  Item(
      "Search",
      (ctx) => RaisedButton(
          child: Text("Show Search"),
          onPressed: () => showSearch(context: ctx, delegate: Search())),
      desc: "Use SearchDelegate"),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        CustomLocalizationDelegate(),
      ],
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("StefanJi Flutter PlayGroud"),
          ),
          body: ListView.builder(
            itemCount: pages.length,
            itemBuilder: (ctx, index) {
              final item = pages[index];
              return Card(
                  child: ListTile(
                      title: Text(item.title),
                      subtitle:
                          item.desc.isEmpty ? IgnorePointer() : Text(item.desc),
                      onTap: () => toWiget(item, ctx)));
            },
          ).build(context)),
    );
  }

  toWiget(Item item, BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(
      builder: (ctx) {
        return WidgetPage(item.title, item.widgetBuilder(ctx));
      },
    ));
  }
}

class WidgetPage extends StatelessWidget {
  final Widget child;
  final String title;

  const WidgetPage(this.title, this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
    );
  }
}
