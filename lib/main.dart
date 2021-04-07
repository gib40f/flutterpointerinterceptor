import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Web PointerInterceptor Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(child: _buildDocumentWindow(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      key: Key('With'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PointerInterceptor(
                                child: _buildUpRelevanceAlertDialog(context),
                              );
                            });
                      },
                      label: Text('With PointerInterceptor')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      key: Key('Without'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildUpRelevanceAlertDialog(context);
                            });
                      },
                      label: Text('Without PointerInterceptor')),
                )
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildUpRelevanceAlertDialog(BuildContext context) {
    TextEditingController controllerQuestion = TextEditingController();
    TextEditingController controllerSearchQuery = TextEditingController();
    TextEditingController controllerPassage = TextEditingController();
    TextEditingController controllerAnswer = TextEditingController();

    return AlertDialog(
      //scrollable: true,
      title: Text('Processing... '),
      content: Container(
        width: 800,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(helperText: 'Passage text.'),
                maxLines: 10,
                controller: controllerPassage,
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(helperText: 'Search query.'),
                maxLines: 1,
                controller: controllerSearchQuery,
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(helperText: 'Question.'),
                maxLines: 1,
                controller: controllerQuestion,
              ),
            ),
            Flexible(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(helperText: 'Answer.'),
                maxLines: 10,
                controller: controllerAnswer,
              ),
            )
          ],
        ),
      ),
      actions: [
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text('Cancel'),
        ),
        FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            label: Text('Submit'))
      ],
    );
  }

  Widget _buildDocumentWindow(BuildContext context) {
    String uri =
        'https://grdc.com.au/__data/assets/pdf_file/0021/367032/Grain-Facts-for-Schools-Grow-Great-Grains.pdf';
    if (uri != null) {
      IFrameElement iframe = IFrameElement()
        ..id = uri.hashCode.toString()
        ..src = uri
        ..style.border = 'black'
        ..addEventListener('load', (event) {
          print('load event happened - ${event.type}');
        });

      // ignore: undefined_prefixed_name
      bool result = ui.platformViewRegistry
          .registerViewFactory(uri.hashCode.toString(), (int viewId) => iframe);

      return HtmlElementView(viewType: uri.hashCode.toString());
    } else {
      return Container();
    }
  }
}
