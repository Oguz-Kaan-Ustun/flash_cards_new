int editDistance(String s1, String s2) {
  int len1 = s1.length;
  int len2 = s2.length;

  List<List<int>> dp = List.generate(len1 + 1, (_) => List<int>.filled(len2 + 1, 0));

  for (int i = 0; i <= len1; i++) {
    for (int j = 0; j <= len2; j++) {
      if (i == 0) {
        dp[i][j] = j;
      } else if (j == 0) {
        dp[i][j] = i;
      } else if (s1[i - 1] == s2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 + _min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]);
      }
    }
  }

  return dp[len1][len2];
}

int _min(int x, int y, int z) {
  if (x <= y && x <= z) {
    return x;
  } else if (y <= x && y <= z) {
    return y;
  } else {
    return z;
  }
}