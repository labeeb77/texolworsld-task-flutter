import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';



class SentMessage extends StatelessWidget {
  final String audioUrl;
  final String transcript;
  final String orderNumber;
  final String approvalStatus;
  final String time;

  const SentMessage({
    Key? key,
    required this.audioUrl,
    required this.transcript,
    required this.orderNumber,
    required this.approvalStatus,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () => _showCustomActionDialog(context),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAudioPlayer(),
                  const Divider(height: 1),
                  _buildExpandablePanel("Transcript", transcript),
                  const Divider(height: 1),
                  _buildExpandablePanel("Order List", orderNumber),
                  _buildTimestampAndCheckmark(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200
            ),
            child: IconButton(
              iconSize: 25,
              icon: const Icon(Icons.play_arrow, color: Colors.blue),
              onPressed: () async {
                
              },
            ),
          ),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                widthFactor: 0.3,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text("0:23", style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildExpandablePanel(String title, String content) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToExpand: true,
        tapBodyToCollapse: true,
        hasIcon: false,
      ),
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
      collapsed: Container(),
      expanded: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title == "Order List")
              ..._buildOrderList()
            else
              Text(content),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOrderList() {
    return [
      Row(
        children: [
          Icon(Icons.receipt, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(orderNumber, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      const SizedBox(height: 8),
      _buildOrderItem("Milk", "5 Packets", "00:33"),
      _buildOrderItem("Butter", "5 kg", "01:33"),
      _buildOrderItem("Butter", "5 Crates", "01:55"),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            Text(approvalStatus, style: TextStyle(color: Colors.green[800], fontSize: 12)),
          ],
        ),
      ),
    ];
  }

  Widget _buildOrderItem(String item, String quantity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item),
          Text(quantity),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          Icon(Icons.edit, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }

  Widget _buildTimestampAndCheckmark() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(width: 4),
          const Icon(Icons.check, color: Colors.green, size: 16),
        ],
      ),
    );
  }

  void _showCustomActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomActionDialog(
        actions: [
          ActionItem(
            icon: Icons.refresh,
            label: 'Quick Reorder',
            onTap: () {
            
            },
          ),
          ActionItem(
            icon: Icons.person_add,
            label: 'Assign to Salesmen',
            onTap: () {
            
            },
          ),
          ActionItem(
            icon: Icons.share,
            label: 'Share',
            onTap: _shareMessage,
          ),
          ActionItem(
            icon: Icons.file_download,
            label: 'Export',
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }

  void _shareMessage() {
    final String messageContent = 'Order Number: $orderNumber\nTranscript: $transcript';
    Share.share(messageContent, subject: 'Shared Message');
  }
}

class CustomActionDialog extends StatelessWidget {
  final List<ActionItem> actions;

  const CustomActionDialog({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: actions.map((action) => _buildActionItem(context, action)).toList(),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, ActionItem action) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        action.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(action.icon, size: 20, color: Colors.black87),
            const SizedBox(width: 16),
            Text(
              action.label,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  ActionItem({required this.icon, required this.label, required this.onTap});
}