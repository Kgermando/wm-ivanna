import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/models/reservation/reservation_model.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_reservation.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/reservation_controller.dart';
import 'package:wm_com_ivanna/src/widgets/btn_widget.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class UpdateReservation extends StatefulWidget {
  const UpdateReservation({super.key, required this.reservationModel});
  final ReservationModel reservationModel;

  @override
  State<UpdateReservation> createState() => _UpdateReservationState();
}

class _UpdateReservationState extends State<UpdateReservation> {
  final ReservationController controller = Get.put(ReservationController());
  final ProfilController profilController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Reservations";

  @override
  void initState() {
    controller.clientController =
        TextEditingController(text: widget.reservationModel.client);
    controller.telephoneController =
        TextEditingController(text: widget.reservationModel.telephone);
    controller.emailController =
        TextEditingController(text: widget.reservationModel.email);
    controller.adresseController =
        TextEditingController(text: widget.reservationModel.adresse);
    controller.nbrePersonneController =
        TextEditingController(text: widget.reservationModel.nbrePersonne);
    controller.dureeEventController =
        TextEditingController(text: widget.reservationModel.dureeEvent);
    controller.montantController =
        TextEditingController(text: widget.reservationModel.montant);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          DateFormat("dd-MM-yyyy").format(widget.reservationModel.createdDay)),
      drawer: const DrawerMenuReservation(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenuReservation())),
          Expanded(
              flex: 5,
              child: controller.obx(
                  onLoading: loadingPage(context),
                  onEmpty: const Text('Aucune donnée'),
                  onError: (error) => loadingError(context, error!),
                  (state) => SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const ScrollPhysics(),
                      child: Container(
                          margin: EdgeInsets.only(
                              top: Responsive.isMobile(context) ? 0.0 : p20,
                              bottom: p8,
                              right: Responsive.isMobile(context) ? 0.0 : p20,
                              left: Responsive.isMobile(context) ? 0.0 : p20),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(p8),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "Modifier la reservation",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    backgroundWidget(),
                                    clientWidget(),
                                    telephoneWidget(),
                                    emailWidget(),
                                    adresseWidget(),
                                    nbrePersonneWidget(),
                                    dureeEventWidget(),
                                    montantWidget(),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    Obx(() => BtnWidget(
                                        title: 'Soumettre',
                                        press: () {
                                          final form =
                                              controller.formKey.currentState!;
                                          if (form.validate()) {
                                            controller.submitUpdate(
                                                widget.reservationModel);
                                            form.reset();
                                          }
                                        },
                                        isLoading: controller.isLoading))
                                  ],
                                ),
                              ),
                            ),
                          )))))
        ],
      ),
    );
  }

  Widget clientWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.clientController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Nom du Client',
              hintText: "Nom de l'Organisateur"),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget telephoneWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.telephoneController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Telephone',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget emailWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email',
          ),
          style: const TextStyle(),
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
        ));
  }

  Widget adresseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.adresseController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 2,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse physique',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget nbrePersonneWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nbrePersonneController,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre des personnes (Participants)',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget dureeEventWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.dureeEventController,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Durée de l'évenement",
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget backgroundWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Type d'évenement",
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.eventName,
        isExpanded: true,
        validator: (value) =>
            value == null ? "Select Type de manifestation" : null,
        items: controller.typeEvent.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Mariage') {
              // Colors.pink;
              controller.background = 0xFFEC407A.toString();
            } else if (value == 'Conference') {
              // Colors.green;
              controller.background = 0xFF66BB6A.toString();
            } else if (value == 'Formation') {
              // Colors.blue;
              controller.background = 0xFF42A5F5.toString();
            } else if (value == 'Campagne') {
              // Colors.orange;
              controller.background = 0xFFFFA726.toString();
            } else if (value == 'Funeraille') {
              // Colors.purple;
              controller.background = 0xFFAB47BC.toString();
            } else if (value == 'Autres') {
              // Colors.brown;
              controller.background = 0xFF8D6E63.toString();
            }
            controller.eventName = value;
          });
        },
      ),
    );
  }

  Widget montantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.montantController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Montant",
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(width: p10),
            Expanded(
                child: Text("\$",
                    style: Theme.of(context).textTheme.headlineSmall))
          ],
        ));
  }
}
