import 'package:flutter/material.dart';

class HomePageBacground extends StatelessWidget {
  final screenHeight;
  HomePageBacground({Key key, @required this.screenHeight}) : super(key: key);
  GlobalKey<FormState> _homeKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ClipPath(
      key: _homeKey,
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.5,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
           Color(0xFF1c1863),
                            Color(0xFF1c1863),
                             
            ],
          ),
        ),
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 8, size.height - 80, size.width / 2, size.height - 50);
    path.quadraticBezierTo(
        size.width, size.height, size.width * 1.1, size.height - 200);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}
