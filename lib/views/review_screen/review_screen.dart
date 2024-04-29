import 'package:furniture_seller_side/views/widgets/text_style.dart';

import '../../const/const.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: reviews,size: 16.0),
      ),
    );
  }
}
