import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Report extends StatelessWidget {
  final Map<String,dynamic> data;
  const Report({required this.data});

  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: FirebaseStorage.instance.ref('${data['std']}/${data['std']}th ${data['div']} ${data['roll no']} 1st Sem.pdf').getDownloadURL(),
            builder: (context, AsyncSnapshot<String> snapshot){
              if(snapshot.hasData){
                print(snapshot.data.toString());
                return SfPdfViewer.network(
                    snapshot.data.toString(),
                  initialZoomLevel: 2,
                );
              }
              if(snapshot.hasError){
                print(snapshot.error);
                return Container();
              }
              else return Center(
                  child: CircularProgressIndicator()
              );
            },
          )
        ),
    );
  }
}
