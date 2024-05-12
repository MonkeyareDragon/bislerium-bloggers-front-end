class HistoryDTO {
  final String? postId;
  final String? commentId;
  final String? previousContent;
  final String? updatedContent;

  HistoryDTO({
    this.postId,
    this.commentId,
    this.previousContent,
    this.updatedContent,
  });
}
