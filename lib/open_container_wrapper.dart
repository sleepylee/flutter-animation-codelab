import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mail_view_page.dart';
import 'model/email_model.dart';
import 'model/email_store.dart';

class OpenEmailPreviewContainerWrapper extends StatelessWidget {
  const OpenEmailPreviewContainerWrapper({
    @required this.id,
    @required this.email,
    @required this.closedChild,
  })  : assert(id != null),
        assert(email != null),
        assert(closedChild != null);

  final int id;
  final Email email;
  final Widget closedChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OpenContainer(
      openBuilder: (context, action) {
        return MailViewPage(id: id, email: email);
      },
      openColor: theme.cardColor,
      closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      closedElevation: 0,
      closedColor: theme.cardColor,
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: () {
            Provider.of<EmailStore>(context, listen: false)
                .currentlySelectedEmailId = id;
            openContainer();
          },
          child: closedChild,
        );
      },
    );
  }
}
