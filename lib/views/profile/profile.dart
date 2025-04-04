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
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          // Profile avatar with a border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: (user.image != null && user.image != '')
                  ? Image.network(
                      user.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/user_placeholder.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      "assets/images/user_placeholder.jpg",
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          const SizedBox(height: 16),

          // User name
          Text(
            user.name ?? localizations.not_available,
            style: ThemeStyle.textStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          // Location
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.white70,
                ),
                const SizedBox(width: 4),
                Text(
                  "-", // Direct location text as requested
                  style: ThemeStyle.textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Messages Section
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => _navigateToMessages(context),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.message_outlined,
                        color: Colors.blue,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Messages",
                            style: ThemeStyle.textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "View your inbox and notifications",
                            style: ThemeStyle.textStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: ThemeStyle.textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main information card
          Container(
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Professional information section
                  _buildSectionHeader(
                    icon: Icons.work_outline,
                    title:
                        "Professional Info", // Using a direct string instead of localization
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.badge_outlined,
                    label: localizations.code,
                    value: user.code ?? "-",
                  ),
                  _buildInfoRow(
                    icon: Icons.category_outlined,
                    label: localizations.category,
                    value: "-",
                  ),
                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: localizations.admission_data,
                    value: user.admission ?? "-",
                  ),
                  _buildInfoRow(
                    icon: Icons.description_outlined,
                    label: localizations.contract_type,
                    value: user.contractType ?? "-",
                  ),

                  const Divider(height: 32),

                  // Personal information section
                  _buildSectionHeader(
                    icon: Icons.person_outline,
                    title: localizations.personal_info,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    label: localizations.email,
                    value: user.email ?? "-",
                  ),
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    label: localizations.phone,
                    value: user.mainContact?.toString() ?? "-",
                  ),
                  _buildInfoRow(
                    icon: Icons.cake_outlined,
                    label: localizations.birthday,
                    value: user.birthday ?? "-",
                  ),
                ],
              ),
            ),
          ),

          // Notification Preferences
          Container(
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: Icons.notifications_none,
                    title: "Communication Preferences",
                  ),
                  const SizedBox(height: 16),
                  _buildToggleOption(
                    context,
                    title: "Push Notifications",
                    subtitle: "Receive notifications on your device",
                    icon: Icons.notifications_active_outlined,
                    initialValue: true,
                    onChanged: (value) {
                      // Handle push notifications toggle
                    },
                  ),
                  const Divider(height: 24),
                  _buildToggleOption(
                    context,
                    title: "Email Newsletter",
                    subtitle: "Receive news and updates via email",
                    icon: Icons.email_outlined,
                    initialValue: true,
                    onChanged: (value) {
                      // Handle email newsletter toggle
                    },
                  ),
                  const Divider(height: 24),
                  _buildToggleOption(
                    context,
                    title: "SMS Notifications",
                    subtitle: "Receive urgent updates via SMS",
                    icon: Icons.sms_outlined,
                    initialValue: false,
                    onChanged: (value) {
                      // Handle SMS toggle
                    },
                  ),
                  const Divider(height: 24),
                  _buildToggleOption(
                    context,
                    title: "Marketing Communications",
                    subtitle: "Receive offers and promotions",
                    icon: Icons.campaign_outlined,
                    initialValue: false,
                    onChanged: (value) {
                      // Handle marketing toggle
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _navigateToMessages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MessagesScreen(),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: ThemeStyle.textStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.black38,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label:",
                  style: ThemeStyle.textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: ThemeStyle.textStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool initialValue,
    required Function(bool) onChanged,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isEnabled = initialValue;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ThemeStyle.textStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: ThemeStyle.textStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isEnabled,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
                onChanged(value);
              },
            ),
          ],
        );
      },
    );
  }
}

// Messages Screen
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample messages data (would typically come from an API)
    final messages = [
      {
        'id': '1',
        'title': 'Schedule Change',
        'message': 'Your shift on Friday has been rescheduled to 9:00 AM.',
        'date': 'Today, 10:30 AM',
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'Vacation Request Approved',
        'message': 'Your vacation request for June 15-20 has been approved.',
        'date': 'Yesterday, 2:45 PM',
        'isRead': false,
      },
      {
        'id': '3',
        'title': 'New Company Policy',
        'message': 'Please review the updated employee handbook.',
        'date': 'Apr 2, 2025',
        'isRead': true,
      },
      {
        'id': '4',
        'title': 'Meeting Reminder',
        'message': 'Don\'t forget the team meeting tomorrow at 3:00 PM.',
        'date': 'Mar 29, 2025',
        'isRead': true,
      },
      {
        'id': '5',
        'title': 'Performance Review',
        'message':
            'Your quarterly performance review is scheduled for next week.',
        'date': 'Mar 25, 2025',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: messages.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: messages.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageItem(context, message);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Compose new message functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Messages',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your inbox is empty',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, Map<String, dynamic> message) {
    return InkWell(
      onTap: () {
        // Navigate to message detail
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: message['isRead'] ? null : Colors.blue.withOpacity(0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6, right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: message['isRead'] ? Colors.transparent : Colors.blue,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: message['isRead']
                              ? FontWeight.w500
                              : FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        message['date'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    message['message'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
