import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/const/const.dart';

class StoreServices {
  
  static getProfile(uid){
    return firestore.collection(vendorsCollection).where('id',isEqualTo: uid).get();
  }

  static getMessages(uid){
    return firestore.collection(chatsCollection).where('toId',isEqualTo: uid).snapshots();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getOrders(uid){
    return firestore.collection(ordersCollection).where('vendors',arrayContains: uid).snapshots();
  }
  
  static getProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id',isEqualTo: uid).snapshots();
  }


}