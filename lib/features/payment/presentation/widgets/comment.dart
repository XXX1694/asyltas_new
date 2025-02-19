import 'package:asyltas_app/core/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  final String hintText;
  final String name;

  const CommentTextField({
    super.key,
    this.hintText = 'Оставьте отзыв...',
    required this.name,
  });

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          maxLines: 3,
          style: const TextStyle(
            fontFamily: 'Gilroy',
            color: newBlack,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.black38,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.black38,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: newMainColor,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            _saveReview(
              widget.name,
              controller.text,
              context,
              controller,
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: newBlack,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Отправить',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: newWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _saveReview(String name, String review, BuildContext context,
    TextEditingController controller) async {
  try {
    await FirebaseFirestore.instance.collection('reviews').add({
      'name': name,
      'review': review.isEmpty ? "Пусто" : review,
      'timestamp': FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Отзыв успешно отправлен!')),
    );
    controller.clear();
  } catch (e) {
    if (kDebugMode) {
      print('Error saving review: $e');
    }
  }
}
