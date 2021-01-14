import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
void main(){
  testWidgets("DrawerTile is constructed", (WidgetTester tester)async{
    final PageController pageController = PageController();
    final int page = 0;
    final String title = "test widget";
    await tester.pumpWidget(DrawerTile(Icons.home, title, pageController, page));
    final titleFinder = find.text(title);
    final iconFinder = find.byIcon(Icons.home);
    final pageControllerFinder = find.byType(PageController);

    expect(titleFinder, findsWidgets);
    expect(iconFinder, findsWidgets);
    expect(pageControllerFinder, findsWidgets);
  });
}