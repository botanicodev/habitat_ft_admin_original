import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:habitat_ft_admin/model/moment_model.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';

import 'list_moment_bloc.dart';

class WorkshopPage extends StatelessWidget {
  final Workshop workshop;

  const WorkshopPage({Key key, @required this.workshop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ListMomentBloc>(
              create: (context) =>
                  ListMomentBloc(workshop.id)..add(ListMomentStarted())),
        ],
        child: _Workshop(
          workshop: workshop,
        ));
  }
}

class _Workshop extends StatefulWidget {
  final Workshop workshop;
  const _Workshop({Key key, @required this.workshop}) : super(key: key);

  @override
  __WorkshopState createState() => __WorkshopState();
}

class __WorkshopState extends State<_Workshop> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1366, height: 768, allowFontScaling: true);

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
              Column(
                children: [
                  _buildTitle(),
                  _buildDescription(),
                  _buildHeaderMoments(),
                ],
              ),
              BlocBuilder<ListMomentBloc, ListMomentState>(
                builder: (context, state) {
                  if (state is ListMomentInProcess) {
                    return Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                        child: CircularProgressIndicator());
                  } else if (state is ListMomentSuccess) {
                    return Column(
                      children: _listMoments(state.moments),
                    );
                  } else {
                    return Container();
                  }
                },
              )
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
      child: Text(widget.workshop.title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(22.58),
              color: ColorCustomer.blue,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: ScreenUtil().setWidth(505),
      child: Text(
        widget.workshop.description,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(13), color: ColorCustomer.textGrey),
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
          style: TextStyle(fontSize: ScreenUtil().setSp(18)),
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

  List<Widget> _listMoments(List<Moment> moments) {
    print(moments);
    return moments
        .map((m) => MomentContainer(
              moment: m,
            ))
        .toList();
  }
}

class MomentContainer extends StatefulWidget {
  final Moment moment;

  const MomentContainer({Key key, @required this.moment}) : super(key: key);

  @override
  _MomentContainerState createState() => _MomentContainerState();
}

class _MomentContainerState extends State<MomentContainer> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(505),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
      child: Column(children: [
        _buildHeader(context),
        _buildBody(),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(17)))),
        Spacer(),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white, size: 28),
          onPressed: () => _buildNewComponent(context),
        ),
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

  void _buildNewComponent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: ColorCustomer.grey,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: ScreenUtil().setWidth(435),
          height: ScreenUtil().setHeight(600),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SelectedComponent(
                pageController: pageController,
              ),
              AddAudio(
                pageController: pageController,
              ),
              LoadedComponent()
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedComponent extends StatelessWidget {
  final PageController pageController;

  const SelectedComponent({Key key, @required this.pageController})
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
        pageController
          ..animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
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

class AddVideo extends StatelessWidget {
  final PageController pageController;

  const AddVideo({Key key, @required this.pageController}) : super(key: key);

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
          _buildTextFormField("Link del video"),
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
          borderSide: BorderSide(color: Colors.black54, width: 0),
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
          border: Border.all(color: Colors.black54, width: 0),
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
        child: Text('Cargar',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500)),
        onPressed: () {},
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

class AddImage extends StatelessWidget {
  final PageController pageController;

  const AddImage({Key key, @required this.pageController}) : super(key: key);

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
          borderSide: BorderSide(color: Colors.black54, width: 0),
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
                border: Border.all(color: Colors.black54, width: 0),
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
                  onPressed: () {})),
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
          border: Border.all(color: Colors.black54, width: 0),
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
        onPressed: () {},
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

class AddDocument extends StatelessWidget {
  final PageController pageController;

  const AddDocument({Key key, @required this.pageController}) : super(key: key);

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
                  'assets/icons/habitat_icon_documento.png',
                  width: ScreenUtil().setWidth(38),
                ),
                SizedBox(width: ScreenUtil().setWidth(11)),
                Text('Agregar Documento',
                    style: TextStyle(
                        color: ColorCustomer.violet,
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
          borderSide: BorderSide(color: Colors.black54, width: 0),
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
                border: Border.all(color: Colors.black54, width: 0),
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
                  onPressed: () {})),
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
          border: Border.all(color: Colors.black54, width: 0),
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
        onPressed: () {},
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

class AddAudio extends StatelessWidget {
  final PageController pageController;

  const AddAudio({Key key, @required this.pageController}) : super(key: key);

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
                  'assets/icons/habitat_icon_audio.png',
                  width: ScreenUtil().setWidth(38),
                ),
                SizedBox(width: ScreenUtil().setWidth(11)),
                Text('Agregar Audio',
                    style: TextStyle(
                        color: ColorCustomer.orangeAccent,
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
          borderSide: BorderSide(color: Colors.black54, width: 0),
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
                border: Border.all(color: Colors.black54, width: 0),
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
                  onPressed: () {})),
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
          border: Border.all(color: Colors.black54, width: 0),
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
          pageController.animateToPage(2,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
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

class LoadedComponent extends StatelessWidget {
  const LoadedComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildAppBar(),
          _buildHeaderLoadedComponent(),
          SizedBox(
            height: ScreenUtil().setHeight(80),
          ),
          Image.asset(
            'assets/icons/habitat_exito.png',
            width: ScreenUtil().setWidth(168),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(93),
          ),
          GestureDetector(
            child: Text('Salir',
                style: TextStyle(
                    color: ColorCustomer.blue,
                    decoration: TextDecoration.underline,
                    fontSize: ScreenUtil().setSp(12))),
            onTap: () => Get.back(),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
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

  Widget _buildHeaderLoadedComponent() {
    return Container(
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(47),
        ),
        child: Column(
          children: [
            Text('Componente Agregado',
                style: TextStyle(
                    color: ColorCustomer.ligthBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: ScreenUtil().setHeight(46),
            ),
            Text('¡El componente se agregó exitosamente!',
                style: TextStyle(
                    color: ColorCustomer.textGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ],
        ));
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
