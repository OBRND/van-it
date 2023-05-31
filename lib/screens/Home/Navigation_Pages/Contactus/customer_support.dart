import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/services/Database.dart';
import 'package:van_lines/services/Storage.dart';

class Chat extends StatefulWidget {
  // const Support({Key? key}) : super(key: key);
  final String chatID;
  const Chat({required this.chatID});

  @override
  State<Chat> createState() => _ChatState(chatID: chatID);
}

class _ChatState extends State<Chat> {
  String chatID;
  _ChatState({required this.chatID});
  List messages = [ ];
  CollectionReference snapshot = FirebaseFirestore.instance.collection('Chats');
  var image = File('1.jpg');

  Stream messagesStream() {
    return snapshot.doc('$chatID').snapshots();
    // return chats;
  }

  Future getallmessages() async{
    final user = Provider.of<UserFB?>(context);
    final DatabaseService db = DatabaseService(uid: user!.uid);
    List result = await db.getchat(chatID);
    messages = result;
    print(result);
    // setState(() => messages = result);
    return messages;
  }
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x94060f42),
      title: const Text('Van Support', style: TextStyle(fontWeight: FontWeight.w400),),),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
                future: getallmessages(),
                builder: (BuildContext context,AsyncSnapshot snapshot) {
                  if(snapshot.data == null){
                    DatabaseService(uid: user!.uid).createChat();
                  }
                  print('future returned: ${snapshot.data}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black38,
                          ));
                    default: return StreamBuilder(
                        stream: messagesStream(),
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if(!messages.contains(snap.data['chats'].last)){
                            messages.add(snap.data['chats'].last);
                          }
                          print('stream rebuilt');
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          // messages.add(ChatMessage(messageContent: '${snap.data['chatValues']['4y9r3uWdmZgahwguu5cjjl3fodk2 ${messages.length}']}',
                          //     messageType: 'sender', type: 'text'));
                          // print(snap.data['chatValues'][0]);
                          return ListView.builder(
                            // controller: _sc,
                            reverse: true,
                            dragStartBehavior: DragStartBehavior.down,
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final reversedIndex = snapshot.data.length - 1 - index;
                              // WidgetsBinding.instance.addPostFrameCallback((_) => {_sc.jumpTo(_sc.position.maxScrollExtent)});
                              // messages[reversedIndex].type == 'image' ? print('an image'): print(' a text');
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: (snapshot.data[reversedIndex].toString().startsWith('s')) ? 40 :0,
                                    left: (snapshot.data[reversedIndex].toString().startsWith('s')) ? 0 :40),
                                child: Container(
                                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                  child: Align(
                                    alignment: (snapshot.data[reversedIndex].toString().startsWith('s') ? Alignment.topLeft : Alignment.topRight),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (snapshot.data[reversedIndex].toString().startsWith('s') ? Colors.grey[300] : Colors.blue[200]),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: snapshot.data[reversedIndex].toString().startsWith('image') ?
                                      Container(
                                        child: Image.network(
                                            '${snapshot.data[reversedIndex]}',
                                            errorBuilder:  (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.black12,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Whoops!, check your connection and try again',
                                                  style: TextStyle(fontSize: 25),
                                                ),
                                              );
                                            },
                                        ),
                                      ) : Text(snapshot.data[reversedIndex].toString().substring(1),
                                        style: TextStyle(fontSize: 15),),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  }
                }
            ),
            StreamBuilder(
                stream: messagesStream(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  return Container(
                    color: Color(0xa0060f42),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(onPressed: () async{
                          SnackBar snackBar = SnackBar(
                            backgroundColor: Colors.transparent,
                            content: Card(
                                color: Colors.redAccent,
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.dangerous_rounded),
                                      Text(' please pick a file!', style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w600
                                      ),),
                                    ],
                                  ),
                                )),
                          );
                          await chooseImage();
                          // await FirebaseStorage.instance.ref('Chats/${chatID}').putData(fileBytes!);
                          // var result = await getimageurl();
                          // print('result: $result');
                          // await db.updatechat("$result", chatID);

                        }, child: Icon(Icons.image_outlined, size: 28,weight: .1,color: Colors.white70.withOpacity(.6),),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                              )),),
                        Container(
                          // height: 45,
                          width: MediaQuery.of(context).size.width *.685,
                          child: TextFormField(
                            validator: (val) => val!.isEmpty ? 'Enter a message' : null,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Message",
                              hintStyle:  TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                              fillColor: Colors.black54,
                              // filled: true,
                                // fillColor: Color(0xffd4d4d5),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffd4d4d5),width: 0),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            controller: myController,
                          ),
                        ),
                        TextButton(onPressed: () async{
                          // var result = await storage.getdata(tradesID);
                          // print(result);
                          print('${myController.text}');

                          await DatabaseService(uid: user!.uid).updatechat(myController.text, chatID);
                          await DatabaseService(uid: user!.uid).updateunread( chatID);
                          // await db.getmessages();
                          setState(() => myController.text = ''
                          );
                        }, child: Icon(Icons.send_outlined, size: 28,color: Colors.white70.withOpacity(.6)),
                          style: ButtonStyle(
                            // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            // RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)),
                              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                              )),
                        ),
                      ],
                    ),
                  );
                })
          ]
      ),
    );
  }
  chooseImage() async{
    // final FirebaseStorage storage = FirebaseStorage.instance;
    final user = Provider.of<UserFB?>(context, listen: false);
    // Auth_service auth_service =Auth_service();
    final uid = user!.uid;
    final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(getImage!.path);
    print(pickedImageFile);
    final Storage storage = Storage();
    await storage.uploadfilechat(pickedImageFile, uid);
    setState(() {
      image = pickedImageFile;
    });
  }
}
