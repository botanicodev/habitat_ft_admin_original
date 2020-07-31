import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';

class HomeComponent extends StatelessWidget {
  final PageController pageController;
  final ValueNotifier valueNotifier;

  const HomeComponent(
      {Key key, @required this.pageController, @required this.valueNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildAppBarNewComponent(),
          _buildHeaderNewComponent(),
          _buildBodyTypeComponents(),
          _buildPageIndicator(1),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
          top: ScreenUtil().setHeight(47),
        ),
        child: Column(
          children: [
            Text('Agregar un Nuevo Componente',
                style: TextStyle(
                    color: ColorCustomer.ligthBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: ScreenUtil().setHeight(22),
            ),
            Text('Seleccione el tipo de medio que quiere cargar',
                style: TextStyle(
                    color: ColorCustomer.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ));
  }

  Widget _buildBodyTypeComponents() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(75)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeComponent("assets/icons/habitat_icon_video.png",
                    "Video", ColorCustomer.orange),
                SizedBox(
                  width: ScreenUtil().setWidth(50),
                ),
                _buildTypeComponent("assets/icons/habitat_icon_imagen.png",
                    "Imagen", ColorCustomer.green),
                SizedBox(
                  width: ScreenUtil().setWidth(50),
                ),
                _buildTypeComponent("assets/icons/habitat_icon_documento.png",
                    "Documento", ColorCustomer.violet),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeComponent("assets/icons/habitat_icon_audio.png",
                    "Audio", ColorCustomer.orangeAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeComponent(String imageAssets, String type, Color color) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().setWidth(80),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorCustomer.textGrey),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imageAssets,
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(9)),
              child: Text(type,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      color: color,
                      fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
      onTap: () {
        if (type == 'Video') {
          valueNotifier.value = 0;
        } else if (type == 'Imagen') {
          valueNotifier.value = 1;
        } else if (type == 'Documento') {
          valueNotifier.value = 2;
        } else {
          valueNotifier.value = 3;
        }

        pageController
          ..animateToPage(1,
              duration: Duration(milliseconds: 700), curve: Curves.ease);
      },
    );
  }

  Widget _buildPageIndicator(int numberPage) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(88)),
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
