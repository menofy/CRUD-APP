import 'package:crud_app/core/routes/routes_name.dart';
import 'package:crud_app/pages/add_post_view.dart';
import 'package:crud_app/pages/edit_post_view.dart';
import 'package:crud_app/pages/homepage_view.dart';
import 'package:crud_app/pages/show_posts_view.dart';
import 'package:crud_app/pages/single_post_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static Route? generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return PageTransition(
          child: const HomepageView(), 
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500));
      case RoutesName.getAll:
        return PageTransition(
          child: const ShowPostsView(), 
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500));
      case RoutesName.getSingle:
        final int postId = settings!.arguments as int;
        return PageTransition(
          child: SinglePostView(postId: postId,), 
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500));
      case RoutesName.create:
        return PageTransition(
          child: const AddPostView(), 
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500));
      case RoutesName.update:
        final int postId = settings!.arguments as int;
        return PageTransition(
          child: EditPostView(postId: postId,), 
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500));
      default:
        throw Exception();
    }
  }
}
