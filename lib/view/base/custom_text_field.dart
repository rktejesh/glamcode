import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

Widget customTextField(
    String title,
    TextEditingController textEditingController,
    TextInputType? textInputType,
    String? Function(String?)? fn) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    child: TextFormField(
      decoration: InputDecoration(
          focusColor: Colors.black,
          floatingLabelStyle: const TextStyle(color: Colors.black),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: title,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
      keyboardType: textInputType ?? TextInputType.text,
      controller: textEditingController,
      validator: fn ?? defaultValidator,
    ),
  );
}

String? defaultValidator(value) =>
    value.isEmpty ? 'Field cannot be blank' : null;
