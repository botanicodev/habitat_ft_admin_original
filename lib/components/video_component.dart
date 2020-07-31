import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';

class VideoComponent extends StatelessWidget {
  final PageController pageController;

  const VideoComponent({Key key, @required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildAppBarVideoComponent(),
          _buildHeaderVideoComponent(),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          _buildTextFormField("Nombre del componente"),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          _buildTextFormField("Link del video"),
          _buildPreview(),
          _buildLoadButton(),
          _buildPageIndicator(2),
        ],
      ),
    );
  }

  Widget _buildAppBarVideoComponent() {
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

  Widget _buildHeaderVideoComponent() {
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
                  'assets/icons/habitat_icon_video.png',
                  width: ScreenUtil().setWidth(48),
                ),
                SizedBox(width: ScreenUtil().setWidth(11)),
                Text('Agregar Video',
                    style: TextStyle(
                        color: ColorCustomer.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(22),
            ),
            Text('Coloque un nombre al componente y la URL correspondiente',
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
}
