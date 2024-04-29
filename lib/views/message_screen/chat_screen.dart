import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/services/store_services.dart';
import 'package:furniture_seller_side/views/message_screen/components/chat_bubble.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../controllers/chat_controller.dart';
import '../widgets/text_style.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: controller.friendName, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: StoreServices.getChatMessages(controller.chatDocId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data?.docs ?? [];

                  return Obx(
                    ()=> ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return chatBubble(
                          message: message['text'],
                          time: message['time'],
                        );
                      },
                    ),
                  );

                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter Message",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final text = _messageController.text.trim();
                      if (text.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc()
                            .collection('messages')
                            .add({'text': text});
                        _messageController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: purpleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
