import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';

class ImageComponent extends StatelessWidget {
  final PageController pageController;

  const ImageComponent({Key key, @required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildAppBarNewComponent(),
          _buildHeaderNewComponent(),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          _buildTextFormField("Nombre del componente"),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          _buildUploadButton(),
          _buildPreview(),
          _buildLoadButton(),
          _buildPageIndicator(2),
        ],
      ),
    );
  }

  Widget _buildAppBarNewComponent() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(17),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: ColorCustomer.ligthBlue,
              size: ScreenUtil().setWidth(25),
            ),
            onTap: () {
              pageController
                ..animateToPage(0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          ),
          GestureDetector(
            child: Icon(Icons.close, color: Colors.grey),
            onTap: () => Get.back(),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderNewComponent() {
    return Container(
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/habitat_icon_imagen.png',
                  width: ScreenUtil().setWidth(30),
                ),
                SizedBox(width: ScreenUtil().setWidth(11)),
                Text('Agregar Imagen',
                    style: TextStyle(
                        color: ColorCustomer.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(22),
            ),
            Text('Coloque un nombre al componente',
                style: TextStyle(
                    color: ColorCustomer.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ));
  }

  Widget _buildTextFormField(String text) {
    return Container(
      width: ScreenUtil().setWidth(348),
      height: ScreenUtil().setHeight(40),
      child: TextFormField(
          decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 11, bottom: 10, left: 15, right: 15),
        hintText: text,
        hintStyle: TextStyle(
            color: Colors.black54,
            letterSpacing: -1,
            fontSize: ScreenUtil().setSp(13)),
        isCollapsed: true,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorCustomer.blue,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1),
        ),
      )),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenUtil().setWidth(235),
            height: ScreenUtil().setHeight(35),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54, width: 1),
                borderRadius: BorderRadius.circular(3)),
          ),
          Container(
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(35),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  color: ColorCustomer.blue,
                  child: Text('Examinar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w500)),
                  onPressed: () {
                    _uploadImage();
                  })),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      width: ScreenUtil().setWidth(348),
      height: ScreenUtil().setHeight(184),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(3)),
    );
  }

  Widget _buildLoadButton() {
    return Container(
      width: ScreenUtil().setWidth(348),
      height: ScreenUtil().setHeight(35),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(18)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        color: ColorCustomer.blue,
        child: Text('Crear Componente',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500)),
        onPressed: () {
          pageController
            ..animateToPage(2,
                duration: Duration(milliseconds: 700), curve: Curves.ease);
        },
      ),
    );
  }

  Widget _buildPageIndicator(int numberPage) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(31)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenUtil().setWidth(7),
            height: ScreenUtil().setHeight(7),
            decoration: BoxDecoration(
                color: (numberPage == 1)
                    ? ColorCustomer.blue
                    : ColorCustomer.textGrey,
                shape: BoxShape.circle),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
          Container(
            width: ScreenUtil().setWidth(7),
            height: ScreenUtil().setHeight(7),
            decoration: BoxDecoration(
                color: (numberPage == 2)
                    ? ColorCustomer.blue
                    : ColorCustomer.textGrey,
                shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  void _uploadImage() {
    final accept = 'image/*';

    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.accept = accept;
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;

        final reader = FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (_) async {
            // final url = await _uploadImageToStorage(file);

            // setState(() {
            //   _urlImage = url.toString();
            //   _isImageLoading = false;
            // });
          },
        );
      },
    );
  }
}
