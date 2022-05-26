import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mttest/query.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({
    Key? key,
    required this.name,
    required this.surname,
    required this.date,
    required this.email,
    required this.password,
    required this.value,
  }) : super(key: key);

  final String name;
  final String surname;
  final String date;
  final String email;
  final String password;
  final String value;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late LocationData _currentPosition;
  String? _address, _dateTime;
  late GoogleMapController mapController;
  late Marker marker;
  Location location = Location();

  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }
    final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: SweepGradient(
          //center: FractionalOffset(0.0, 1.0),
          colors: [Color(0xFF2f3070), Color(0xFF5557c7)],
          startAngle: 1 * 3.14 / 4,
          endAngle: 8 * 3.14 / 4,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: SweepGradient(
                  colors: [Color(0xFF2f3070), Color(0xFF5557c7)],
                  startAngle: 1 * 3.14 / 4,
                  endAngle: 8 * 3.14 / 4,
                  tileMode: TileMode.repeated,
                ),
              ),
              //color: Colors.transparent,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Adı:" +
                              widget.name +
                              "\n Soyadı:" +
                              widget.surname +
                              "\n Email:" +
                              widget.email,
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    if (_address != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "\nAdres: $_address",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 3,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2b2d8f),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 20.0, 8.0, 1.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF2b2d8f),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                            ),
                                            onPressed: () async{
                                      await users
                                      .add({
                                      "name": widget.name, 
                                      "surname": widget.surname,
                                      "mail": widget.email, 
                                      "date": widget.date,
                                      "location": _address ?? '',                                       
                                      
                                      });

                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) => QueryPage()));
                                            },
                                            child: Text('Mevcut Konumu Kullan'),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                              target: _initialcameraposition,
                                              zoom: 15),
                                          mapType: MapType.normal,
                                          onMapCreated: _onMapCreated,
                                          myLocationEnabled: true,myLocationButtonEnabled: true,
                                          markers: Set<Marker>.of(
                                            <Marker>[
                                              Marker(
                                                  draggable: true,
                                                  markerId: MarkerId('Marker'),
                                                  position:
                                                      LatLng(0.5937, 0.9629),
                                                  onDragEnd: ((newPosition) {
                                                    print(newPosition.latitude);
                                                    print(
                                                        newPosition.longitude);
                                                  }))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text("Konum")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

        //DateTime now = DateTime.now();
        //_dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude!, _currentPosition.longitude!)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}
