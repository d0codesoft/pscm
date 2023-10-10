import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/database.dart';
import '../core/model/dataServer.dart';

class EditServerScreen extends StatefulWidget {
  static String route = "AddServer";
  late ServerInfo? connectData;

  EditServerScreen ({ Key? key, this.connectData }): super(key: key) {
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
                        autofillHints: const [AutofillHints.name],
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
                        controller: controller,
                        validator: (value) {
                          return value != null && value.length < 8
                              ? AppLocalizations.of(context)!
                                  .formLabelServerPassword
                              : null;
                        },
                      ),
                      FlutterPwValidator(
                        key: validatorKey,
                        controller: controller,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        lowercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 0,
                        normalCharCount: 1,
                        width: 400,
                        height: 200,
                        onSuccess: () {},
                        onFail: () {},
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
