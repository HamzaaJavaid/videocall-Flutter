import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;
import 'credentials.dart';

final String localuserID = math.Random().nextInt(1000).toString();
cred credd = cred();
void main(){

  runApp(const MaterialApp(home:CallPage(callID: '12',)));
}

class CallPage extends StatelessWidget {
  final String callID;
  const CallPage({Key? key, required this.callID}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: credd.appid.toInt(), // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign: credd.appSignIN, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
          userID: localuserID ,
          userName: "user ${DateTime.now().millisecondsSinceEpoch}",
          callID: callID,
          // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
            ..onOnlySelfInRoom = (context) {
            Navigator.pop(context);
          }
        ),
      ),
    );
  }
}