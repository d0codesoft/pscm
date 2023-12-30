import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/database.dart';
import '../core/model/dataServer.dart';

class AddServerScreen extends StatefulWidget {
  static String route = "AddServer";

  const AddServerScreen({super.key});

  @override
  _AddServerScreenState createState() => _AddServerScreenState();
}

class _AddServerScreenState extends State<AddServerScreen> {
  final _formKey = GlobalKey<FormState>();
  DBProvider database = DBProvider.instance;
  QuickActions quickActions = const QuickActions();
  final ServerInfo newServerInfoData =
      ServerInfo(id: DBProvider.nullID, isActive: true);
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleAddNewServer),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Scan QR Code connect',
            onPressed: () {
              // handle the press
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
                      Text(AppLocalizations.of(context)!.promptAddNewServer),
                      TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerNameHint,
                          labelText:
                              AppLocalizations.of(context)!.formLabelServerName,
                        ),
                        autofillHints: const [AutofillHints.name],
                        validator: (value) {
                          return value == null
                              ? AppLocalizations.of(context)!
                                  .formLabelServerNameError
                              : null;
                        },
                        onChanged: (value) => newServerInfoData.name = value,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .formLabelServerDescrHint,
                          labelText: AppLocalizations.of(context)!
                              .formLabelServerDescr,
                        ),
                        autofillHints: const ["description"],
                        onChanged: (value) => newServerInfoData.descr = value
                      ),
                      TextFormField(
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
                          onChanged: (value) => newServerInfoData.serverAddress = value
                      ),
                      TextFormField(
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
                          onChanged: (value) => newServerInfoData.userName = value
                      ),
                      TextFormField(
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
                        controller: controller,
                        validator: (value) {
                          return value != null && value.length < 8
                              ? AppLocalizations.of(context)!
                                  .formLabelServerPassword
                              : null;
                        },
                          onChanged: (value) => newServerInfoData.userPassword = value
                      ),
                      FlutterPwValidator(
                        key: validatorKey,
                        controller: controller,
                        minLength: 8,
                        uppercaseCharCount: 2,
                        lowercaseCharCount: 3,
                        numericCharCount: 3,
                        specialCharCount: 0,
                        normalCharCount: 3,
                        width: 400,
                        height: 200,
                        onSuccess: () {},
                        onFail: () {},
                      ),
                      FormField<bool>(
                        initialValue: newServerInfoData.isActive,
                        builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: newServerInfoData.isActive,
                                      onChanged: (value) {
                                        formFieldState.didChange(value);
                                        setState(() {
                                          newServerInfoData.isActive = value;
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
                            database.updateServerInfo(newServerInfoData);
                            Navigator.pop(context);
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
}
