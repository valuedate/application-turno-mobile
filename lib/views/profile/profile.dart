import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 150, // Slightly smaller to leave room for border
            height: 150, // Slightly smaller to leave room for border
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: (user.image != null && user.image != '')
                ? Image.network(
                    user.image!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/user_placeholder.jpg",
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            user.name ?? "",
            style: ThemeStyle.textStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              '${AppLocalizations.of(context)!.code}: ${user.code ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.category}: - ',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.admission_data}: ${user.admission ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.contract_type}: ${user.contractType ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              '${AppLocalizations.of(context)!.personal_info}',
                              style: ThemeStyle.textStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.email}: ${user.email ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.phone}: ${user.mainContact ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '${AppLocalizations.of(context)!.birthday}: ${user.birthday ?? "-"}',
                              style: ThemeStyle.textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
