import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';

class WorkshopsPage extends StatefulWidget {
  @override
  _WorkshopsPageState createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> {
  List<WorkshopItem> workshops = [
    WorkshopItem(
        workshopName: 'Taller A',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [Color(0xFF179994), Color(0xFFa9ed98)]),
    WorkshopItem(
        workshopName: 'Taller B',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [Color(0xFFd668b0), Color(0xFFa675d9)]),
    WorkshopItem(
        workshopName: 'Taller C',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [Color(0xFF92dac6), Color(0xFF37ace3)]),
    WorkshopItem(
        workshopName: 'Taller D',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [Color(0xFFc9ed8c), Color(0xFFfb8f9d)]),
    WorkshopItem(
        workshopName: 'Taller E',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [Color(0xFFf661a2), Color(0xFFffcf5f)]),
    WorkshopItem(
        workshopName: 'Taller F',
        objetive:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed...',
        colors: [
          Colors.primaries[Random().nextInt(Colors.primaries.length)],
          Colors.primaries[Random().nextInt(Colors.primaries.length)]
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCustomer.ligthGrey,
      appBar: AppBar(
        title: Image.asset('assets/icons/habitat_logo_w.png', width: 40),
        backgroundColor: ColorCustomer.ligthBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(45),
          width: double.infinity,
          child: Column(
            children: [
              _buildTitle(),
              for (int i = 0; i < workshops.length; i++) workshops[i]
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: ColorCustomer.blue,
          onPressed: () => _buildNewWorkshop()),
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

  void _buildNewWorkshop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: ColorCustomer.ligthGrey,
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
                          onPressed: () {},
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
                          onPressed: () {},
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
    return Container(
      width: 600,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildAvatar(),
        SizedBox(width: 20),
        _buildText(),
        _buildIcon(),
      ]),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 50,
      height: 50,
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
