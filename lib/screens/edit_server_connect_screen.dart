import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/qrCodeScaner.dart';
import '../core/database.dart';
import '../core/model/connectAccessToken.dart';
import '../core/model/dataServer.dart';
import '../core/serviceQrCodeConnect.dart';

class EditServerScreen extends StatefulWidget {
  static String route = "AddServer";
  late ServerInfo? connectData;

  EditServerScreen ({ super.key, this.connectData }) {
    connectData ??= ServerInfo(id: DBProvider.nullID);
  }

  @override
  _EditServerScreenState createState() => _EditServerScreenState();
}

class _EditServerScreenState extends State<EditServerScreen> {
  final _formKey = GlobalKey<FormState>();
  final QuickActions quickActions = const QuickActions();
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  Future<void> _queryServerAccesCode(BuildContext context)
  async {

  }

  Future<void> _navigateAndScanQrCode(BuildContext context)
  async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new QrCodeScannerPage()),)
        .then( (val) async {
          if (val!=null && val is ConnectAccessToken) {
              final service = serviceQrCodeConnect.fromAccessConnect(val);
              final connectToken = await service.getConnectedToken();
              if (connectToken != null) {
                  widget.connectData!.token = connectToken.token;
                  widget.connectData!.userName = connectToken.token;
              }
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.promptQrCodeScanError),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        });
  }

  @override
  void initState() {
    controller.text = widget.connectData?.userPassword ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.connectData!.id == DBProvider.nullID
            ? AppLocalizations.of(context)!.titleAddNewServer
            : AppLocalizations.of(context)!.titleEditServer),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_camera_back_rounded),
            tooltip: 'Scan QR Code connect',
            onPressed: () {
              _navigateAndScanQrCode(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AutofillGroup(
                child: Column(
                  children: [
                    ...[
                      Text( widget.connectData!.id == DBProvider.nullID
                          ? AppLocalizations.of(context)!.promptAddNewServer
                          : AppLocalizations.of(context)!.promptEditServer
                      ),
                      TextFormField(
                        initialValue: widget.connectData!.name ?? '',
                        onChanged: (value) => widget.connectData!.name = value,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerNameHint,
                          labelText:
                              AppLocalizations.of(context)!.formLabelServerName,
                        ),
                        validator: (value) {
                          return value == null
                              ? AppLocalizations.of(context)!
                                  .formLabelServerNameError
                              : null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.connectData!.descr ?? '',
                        onChanged: (value) => widget.connectData!.descr = value,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerDescrHint,
                          labelText: AppLocalizations.of(context)!
                              .formLabelServerDescr,
                        ),
                        autofillHints: const ["description"],
                      ),
                      TextFormField(
                        initialValue: widget.connectData!.serverAddress ?? '',
                        onChanged: (value) => widget.connectData!.serverAddress = value,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerAddressHint,
                          labelText: AppLocalizations.of(context)!
                              .formLabelServerAddress,
                        ),
                        autofillHints: const ["serverAddress"],
                        validator: (value) {
                          return value == null
                              ? AppLocalizations.of(context)!
                                  .formLabelServerAddressError
                              : null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.connectData!.userName ?? '',
                        onChanged: (value) => widget.connectData!.userName = value,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerUsernameHint,
                          labelText: AppLocalizations.of(context)!
                              .formLabelServerUsername,
                        ),
                        autofillHints: const [AutofillHints.username],
                        validator: (value) {
                          return value == null
                              ? AppLocalizations.of(context)!
                                  .formLabelServerUsernameError
                              : null;
                        },
                      ),
                      TextFormField(
                        onChanged: (value) => widget.connectData!.userPassword = value,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerPasswordHint,
                          labelText: AppLocalizations.of(context)!
                              .formLabelServerPassword,
                        ),
                        autofillHints: const [AutofillHints.password],
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: true,
                        validator: (value) {
                          return value != null
                              ? AppLocalizations.of(context)!
                                  .formLabelServerPassword
                              : null;
                        },
                      ),
                      FormField<bool>(
                        builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: widget.connectData!.isActive ?? false,
                                      onChanged: (value) {
                                        formFieldState.didChange(value);
                                        setState(() {
                                          widget.connectData!.isActive = value;
                                        });
                                      }),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .formLabelServerIsActive,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context)!
                            .formLabelButtonSubmit),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.pop(context, widget.connectData);
                          }
                        },
                      ),
                    ].expand(
                      (widget) => [
                        widget,
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
