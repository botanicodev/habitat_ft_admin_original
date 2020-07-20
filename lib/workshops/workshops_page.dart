import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';
import 'package:habitat_ft_admin/workshop/add_workshop_bloc.dart';
import 'package:habitat_ft_admin/workshop/workshop_page.dart';
import 'package:habitat_ft_admin/workshops/list_workshops_bloc.dart';

class WorkshopsPage extends StatelessWidget {
  const WorkshopsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AddWorkshopBloc(AddWorkshopInitial())),
      BlocProvider(
          create: (context) => ListWorkshopBloc(ListWorkshopInitial())
            ..add(ListWorkshopStarted())),
    ], child: _Worshops());
  }
}

class _Worshops extends StatefulWidget {
  _Worshops({Key key}) : super(key: key);

  @override
  __WorshopsState createState() => __WorshopsState();
}

class __WorshopsState extends State<_Worshops> {
  final TextEditingController nameWorkshopController = TextEditingController();
  final TextEditingController descriptionWorkshopController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Bloc addWorkshopBloc = BlocProvider.of<AddWorkshopBloc>(context);

    return BlocListener<AddWorkshopBloc, AddWorkshopState>(
      listener: (context, state) {
        if (state is AddWorkshopSuccess) {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: ColorCustomer.grey,
        appBar: AppBar(
          title: Image.asset('assets/icons/habitat_logo_w.png',
              width: ScreenUtil().setWidth(40)),
          backgroundColor: ColorCustomer.ligthBlue,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(45),
            width: double.infinity,
            child: BlocBuilder<ListWorkshopBloc, ListWorkshopState>(
                builder: (context, state) {
              if (state is ListWorkshopSuccess) {
                return Column(
                  children: _buildListWorkshops(state.workshops),
                );
              } else {
                return _buildTitle();
              }
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            backgroundColor: ColorCustomer.blue,
            onPressed: () => _buildNewWorkshop(addWorkshopBloc)),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text('Talleres',
          style: TextStyle(
              color: ColorCustomer.ligthBlue,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -1)),
    );
  }

  List<Widget> _buildListWorkshops(List<Workshop> workshops) {
    List<Widget> widgets = List();
    widgets.add(
      _buildTitle(),
    );
    workshops.forEach((w) {
      widgets.add(
          WorkshopItem(workshopName: w.title, objetive: w.description, colors: [
        Colors.primaries[Random().nextInt(Colors.primaries.length)],
        Colors.primaries[Random().nextInt(Colors.primaries.length)]
      ]));
    });

    return widgets;
  }

  void _buildNewWorkshop(Bloc addWorkshopBloc) {
    nameWorkshopController.text = '';
    descriptionWorkshopController.text = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: ColorCustomer.grey,
        content: Container(
          width: 510,
          height: 400,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF92dac6), Color(0xFF37ace3)]),
              ),
            ),
            Container(
              height: double.maxFinite,
              width: 1.2,
              color: Colors.black54,
              margin: const EdgeInsets.only(left: 20.0, right: 30.0, top: 20),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crear Nuevo Taller',
                        style: TextStyle(
                            color: ColorCustomer.blue,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameWorkshopController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 11, bottom: 7, left: 15, right: 15),
                          hintText: 'Nombre del Taller',
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              letterSpacing: -1),
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
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: descriptionWorkshopController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 11, bottom: 7, left: 15, right: 15),
                          hintText: 'Descripción del Taller',
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              letterSpacing: -1),
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
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(children: [
                        FlatButton(
                          onPressed: () => Get.back(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.only(
                              top: 11, bottom: 6, right: 52, left: 52),
                          color: ColorCustomer.blue,
                          child: Text('Cancelar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 18),
                        FlatButton(
                          onPressed: () {
                            addWorkshopBloc.add(AddWorkshopStarted(Workshop(
                                title: nameWorkshopController.text,
                                description:
                                    descriptionWorkshopController.text)));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 6, right: 46, left: 46),
                          color: ColorCustomer.green,
                          child: Text('Confirmar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class WorkshopItem extends StatelessWidget {
  final String workshopName;
  final String objetive;
  final List<Color> colors;

  const WorkshopItem(
      {Key key,
      @required this.workshopName,
      @required this.objetive,
      @required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 600,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                offset: Offset(5, 5),
              )
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildAvatar(),
          SizedBox(width: 20),
          _buildText(),
          _buildIcon(),
        ]),
      ),
      onTap: () => Get.to(WorkshopPage()),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setWidth(50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: this.colors),
      ),
    );
  }

  Widget _buildText() {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 7),
        Text(
          this.workshopName,
          style: TextStyle(
              color: ColorCustomer.ligthBlue,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
        ),
        SizedBox(height: 5),
        Text(this.objetive,
            style: TextStyle(color: Colors.black38, letterSpacing: -1))
      ]),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 40,
      color: Colors.black12,
    );
  }
}
