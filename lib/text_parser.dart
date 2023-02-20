class TextSegment {
  String text;

  final String? name;
  final bool isHashtag;
  final bool isMention;
  final bool isUrl;
  final bool isTimeCode;

  bool get isText => !isHashtag && !isMention && !isUrl && !isTimeCode;

  TextSegment(
    this.text, [
    this.name,
    this.isHashtag = false,
    this.isMention = false,
    this.isUrl = false,
    this.isTimeCode = false,
  ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextSegment &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          name == other.name &&
          isHashtag == other.isHashtag &&
          isMention == other.isMention &&
          isUrl == other.isUrl &&
          isTimeCode == other.isTimeCode;

  @override
  int get hashCode =>
      text.hashCode ^ name.hashCode ^ isHashtag.hashCode ^ isMention.hashCode ^ isUrl.hashCode ^ isTimeCode.hashCode;
}

/// Split the string into multiple instances of [TextSegment] for mentions, hashtags, URLs and regular text.
///
/// Mentions are all words that start with @, e.g. @mention.
/// Hashtags are all words that start with #, e.g. #hashtag.
List<TextSegment> parseText(String? text) {
  final segments = <TextSegment>[];

  if (text == null || text.isEmpty) {
    return segments;
  }

  // ^\[(?<Time>\s*((?<hour>\d+)):((?<minute>\d+))\.((?<second>\d+)))\]

  // parse urls and words starting with @ (mention) or # (hashtag)
  const pattern =
      r"(?<keyword>(#|@)([\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}]+)|(?<url>(?:(?:https?|ftp):\/\/)?[-a-z0-9@:%._\+~#=]{1,256}\.[a-z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?))|(?<timecode>([\d]{1,2}):([0-5][0-9])(:[0-5][0-9])?)";

  RegExp exp = RegExp(pattern, unicode: true);
  final matches = exp.allMatches(text);

  var start = 0;
  matches.forEach((match) {
    // text before the keyword
    if (match.start > start) {
      if (segments.isNotEmpty && segments.last.isText) {
        segments.last.text += text.substring(start, match.start);
      } else {
        segments.add(TextSegment(text.substring(start, match.start)));
      }
      start = match.start;
    }

    final url = match.namedGroup('url');
    final time = match.namedGroup('timecode');
    final keyword = match.namedGroup('keyword');

    if (url != null) {
      segments.add(TextSegment(url, url, false, false, true));
    } else if (time != null) {
      segments.add(TextSegment(time, time, false, false, false, true));
    } else if (keyword != null) {
      final isWord = match.start == 0 || [' ', '\n'].contains(text.substring(match.start - 1, start));
      if (!isWord) {
        return;
      }

      final isHashtag = keyword.startsWith('#');
      final isMention = keyword.startsWith('@');

      segments.add(TextSegment(keyword, keyword.substring(1), isHashtag, isMention));
    }

    start = match.end;
  });

  // text after the last keyword or the whole text if it does not contain any keywords
  if (start < text.length) {
    if (segments.isNotEmpty && segments.last.isText) {
      segments.last.text += text.substring(start);
    } else {
      segments.add(TextSegment(text.substring(start)));
    }
  }

  return segments;
}
