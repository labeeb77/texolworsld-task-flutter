class Message {
  final MessageType type;
  final String content;
  final String time;
  final String? audioUrl;
  final String? transcript;
  final String? orderNumber;
  final String? approvalStatus;
  final bool isUploading;
  final double uploadProgress;
  final bool isUploaded;

  Message({
    required this.type,
    required this.content,
    required this.time,
    this.audioUrl,
    this.transcript,
    this.orderNumber,
    this.approvalStatus,
    this.isUploading = false,
    this.uploadProgress = 0.0,
    this.isUploaded = false,
  });

  Message copyWith({
    MessageType? type,
    String? content,
    String? time,
    String? audioUrl,
    String? transcript,
    String? orderNumber,
    String? approvalStatus,
    bool? isUploading,
    double? uploadProgress,
    bool? isUploaded,
  }) {
    return Message(
      type: type ?? this.type,
      content: content ?? this.content,
      time: time ?? this.time,
      audioUrl: audioUrl ?? this.audioUrl,
      transcript: transcript ?? this.transcript,
      orderNumber: orderNumber ?? this.orderNumber,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }
}


enum MessageType { text, file, audio, audioOrder }
