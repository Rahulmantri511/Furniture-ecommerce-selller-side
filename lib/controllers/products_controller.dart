import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../models/category_model.dart';

class ProductsController extends GetxController{
  var isloading = false.obs;
  // text fields controller
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var pspecificationController = TextEditingController();
  var preturnpolicyController = TextEditingController();
  var psellerpolicyController = TextEditingController();
  var pwarrantyController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async{
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList(){
    categoryList.clear();

    for(var item in category){
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();

    for(var i = 0; i< data.first.subcategory.length; i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index,context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
      if(img == null){
        return;
      }else{
        pImagesList[index] = File(img.path);
      }
    }catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async{
    pImagesLinks.clear();
    for (var item in pImagesList){
      if(item != null){
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }
  void resetState() {
    pnameController.clear();
    pdescController.clear();
    ppriceController.clear();
    pquantityController.clear();
    pspecificationController.clear();
    preturnpolicyController.clear();
    psellerpolicyController.clear();
    pwarrantyController.clear();

    // Reset other state variables as needed
    categoryvalue.value = '';
    subcategoryvalue.value = '';
    selectedColorIndex.value = 0;
    pImagesLinks.clear();
    pImagesList.assignAll(List.generate(3, (index) => null));
  }

  uploadProduct(context) async{

    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured' : false,
      'p_category' : categoryvalue.value,
      'p_subcategory' : subcategoryvalue.value,
      'p_colors' : FieldValue.arrayUnion([Colors.red.value,Colors.brown.value]),
      'p_imgs':FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist':FieldValue.arrayUnion([]),
      'p_description':pdescController.text,
      'p_name':pnameController.text,
      'p_price':ppriceController.text,
      'p_quantity':pquantityController.text,
      'p_seller_policy':psellerpolicyController.text,
      'p_specification':pspecificationController.text,
      'p_warranty':pwarrantyController.text,
      'p_return_policy':preturnpolicyController.text,
      'p_rating':"5.0",
      'p_seller' : Get.find<HomeController>().username,
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isloading(false);
    resetState();
    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'feature_id': currentUser!.uid,
      'is_featured': true,
    },SetOptions(merge: true));
  }

  removeFeatured(docId) async{
   await  firestore.collection(productsCollection).doc(docId).set({
      'feature_id': '',
      'is_featured': false,
    },SetOptions(merge: true));
  }

  removeProduct(docId) async{
    await firestore.collection(productsCollection).doc(docId).delete();
  }


}