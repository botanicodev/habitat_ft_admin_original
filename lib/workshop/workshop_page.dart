import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:habitat_ft_admin/components/audio_component.dart';
import 'package:habitat_ft_admin/components/document_component.dart';
import 'package:habitat_ft_admin/components/home_component.dart';
import 'package:habitat_ft_admin/components/image_component.dart';
import 'package:habitat_ft_admin/components/video_component.dart';
import 'package:habitat_ft_admin/model/moment_model.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';
import 'package:habitat_ft_admin/workshop/list_component_bloc.dart';
import 'package:habitat_ft_admin/workshop/select_component_bloc.dart';

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
  bool isCollapsed = true;

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
                      children: _listMoments(state.moments, widget.workshop.id),
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
        GestureDetector(
          onTap: () {
            setState(() {
              isCollapsed = false;
            });
          },
          child: Icon(
            Icons.add,
            color: ColorCustomer.blue,
            size: ScreenUtil().setWidth(25),
          ),
        ),
        _buildInputNewMoment(),
      ]),
    );
  }

  Widget _buildInputNewMoment() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: isCollapsed ? 0 : 1,
      child: Container(
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
                onTap: () {
                  setState(() {
                    isCollapsed = true;
                  });
                }),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
                child: Image.asset(
                  'assets/icons/habitat_icono_ok.png',
                  width: 19,
                  height: 15,
                ),
              ),
              onTap: () {
                setState(() {
                  isCollapsed = true;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _listMoments(List<Moment> moments, String workshopId) {
    print(moments);
    return moments
        .map((m) => MomentContainer(
              moment: m,
              workshopId: workshopId,
            ))
        .toList();
  }
}

class MomentContainer extends StatelessWidget {
  final Moment moment;
  final String workshopId;
  const MomentContainer(
      {Key key, @required this.moment, @required this.workshopId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ListComponentBloc>(
              create: (context) => ListComponentBloc(workshopId, moment.id)),
          BlocProvider<SelectComponentBloc>(
              create: (context) => SelectComponentBloc()),
        ],
        child: _Moment(
          moment: moment,
        ));
  }
}

class _Moment extends StatefulWidget {
  final Moment moment;

  const _Moment({Key key, @required this.moment}) : super(key: key);

  @override
  _MomentState createState() => _MomentState();
}

class _MomentState extends State<_Moment> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(505),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
      child: Column(children: [
        _buildHeader(context, widget.moment.title),
        _buildBody(),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
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
            child: Text(title,
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
          ComponentItem(
            title: '¡Hola!',
            backgroundColor: Colors.white,
            imageIcon: 'assets/icons/habitat_icon_video.png',
          ),
          ComponentItem(
            title: '¿Qué ven acá?',
            backgroundColor: Colors.black12,
            imageIcon: 'assets/icons/habitat_icon_imagen.png',
          ),
          ComponentItem(
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
    final ValueNotifier<int> valueNotifier = ValueNotifier(0);
    showDialog(
      context: context,
      barrierDismissible: false,
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
              HomeComponent(
                pageController: pageController,
                valueNotifier: valueNotifier,
              ),
              ValueListenableBuilder<int>(
                valueListenable: valueNotifier,
                builder: (context, value, _) {
                  return IndexedStack(
                    index: value,
                    children: [
                      VideoComponent(pageController: pageController),
                      ImageComponent(pageController: pageController),
                      DocumentComponent(pageController: pageController),
                      AudioComponent(pageController: pageController),
                    ],
                  );
                },
              ),
              LoadedComponent()
            ],
          ),
        ),
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

class ComponentItem extends StatelessWidget {
  final title;
  final backgroundColor;
  final imageIcon;
  final isLastItem;
  const ComponentItem(
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
