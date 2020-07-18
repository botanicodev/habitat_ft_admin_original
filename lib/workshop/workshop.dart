import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';

class Workshop extends StatelessWidget {
  const Workshop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorCustomer.ligthBlue,
          title: Image.asset('assets/icons/habitat_logo_w.png',
              width: ScreenUtil().setWidth(40))),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
          width: double.infinity,
          child: Column(
            children: [
              _buildTitle(),
              _buildObjective(),
              _buildHeaderMoments(),
              Moment(),
              Moment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(20)),
      child: Text('Taller A',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(22.58),
              color: ColorCustomer.blue,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildObjective() {
    return Container(
      width: ScreenUtil().setWidth(505),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed ullamcorper nisl. Mauris at volutpat nisi. Curabitur at porta nulla. Proin tincidunt rutrum tincidunt. Nullam molestie tellus eu dui feugiat accumsan et sit amet erat. Curabitur pellentesque consequat nisi, sed ullamcorper risus viverra et. Phasellus ut eleifend dui.',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(7.52), color: ColorCustomer.textGrey),
      ),
    );
  }

  Widget _buildHeaderMoments() {
    return Container(
      width: ScreenUtil().setWidth(505),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Momentos',
          style: TextStyle(fontSize: ScreenUtil().setSp(15.55)),
        ),
        Icon(
          Icons.add,
          color: ColorCustomer.blue,
          size: ScreenUtil().setWidth(25),
        ),
        _buildInputNewMoment(),
      ]),
    );
  }

  Widget _buildInputNewMoment() {
    return Container(
      width: ScreenUtil().setWidth(348),
      height: ScreenUtil().setHeight(38),
      padding: EdgeInsets.only(bottom: 7, left: 10, right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: ColorCustomer.ligthBlue),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(70),
          ),
          GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(6),
                    right: ScreenUtil().setWidth(15)),
                child: Image.asset(
                  'assets/icons/habitat_icono_no.png',
                  width: 15,
                  height: 15,
                ),
              ),
              onTap: () {}),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
              child: Image.asset(
                'assets/icons/habitat_icono_ok.png',
                width: 19,
                height: 15,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class Moment extends StatelessWidget {
  const Moment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(505),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
      child: Column(children: [
        _buildHeader(),
        _buildBody(),
      ]),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: ScreenUtil().setHeight(53),
      padding: EdgeInsets.only(
        left: 35,
        right: 15,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(0, -5),
            )
          ],
          color: ColorCustomer.ligthBlue),
      child: Row(children: [
        Container(
            margin: EdgeInsets.only(top: 7),
            child: Text('Bienvenida',
                style: TextStyle(color: Colors.white, fontSize: 13.55))),
        Spacer(),
        Icon(Icons.add, color: Colors.white, size: 28),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 38,
        ),
      ]),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
        border: Border.all(color: ColorCustomer.ligthBlue),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(0, 5),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          MomentItem(
            title: '¡Hola!',
            backgroundColor: Colors.white,
            imageIcon: 'assets/icons/habitat_icon_video.png',
          ),
          MomentItem(
            title: '¿Qué ven acá?',
            backgroundColor: Colors.black12,
            imageIcon: 'assets/icons/habitat_icon_imagen.png',
          ),
          MomentItem(
            title: 'Manos a la obra',
            backgroundColor: Colors.white,
            imageIcon: 'assets/icons/habitat_icon_documento.png',
            isLastItem: true,
          ),
        ],
      ),
    );
  }
}

class MomentItem extends StatelessWidget {
  final title;
  final backgroundColor;
  final imageIcon;
  final isLastItem;
  const MomentItem(
      {Key key,
      @required this.backgroundColor,
      this.isLastItem = false,
      @required this.imageIcon,
      this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(60),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: (isLastItem)
            ? BorderRadius.only(
                bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))
            : null,
      ),
      child: Row(
        children: [
          Image.asset(
            imageIcon,
            height: ScreenUtil().setWidth(35),
          ),
          SizedBox(width: ScreenUtil().setWidth(15)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
            child: Text(title, style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
