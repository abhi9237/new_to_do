class StringConstant {
  static StringConstant? _instance;
  StringConstant._();

  static StringConstant get instance {
    _instance ??= StringConstant._();

    return _instance!;
  }

  static const userId = 'userId';
  static const token = 'token';
  static const userName = 'userName';
  static const deviceToken = 'deviceToken';
  static const channelId = 'flutter_audio_video_call';
  static const appId = '8cb838ee12fa4d07a3e39fcf68c017f4';
  static const agoraToken =
      '007eJxTYHhS4rBYYcrj1Sq8OSsfRJpsXt/R+v9Bnqv1tBylKouAB9cUGCySkyyMLVJTDY3SEk1SDMwTjVONLdOS08wskg0MzdNMRBempTUEMjIcbLzDwAiFIL4EQ1pOaUlJalF8YmlKZn58WWZKan58cmJODgMDAJHoKPs=';
}
