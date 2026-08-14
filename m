Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C3350A18
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685094; cv=none; b=oOPM19ityA9O5FkXh5CfitCJM9jd5gi1p9zeBgE61GRQsAVO7h4C9ISQ8OnQFkwgVADQ2grVlxmwHhfhFL/7TCE6e6Vba8VknA8igWOCbNLnYnKpVKmwm6HVZV2ARDAGGVkUsj1K9acOiWJeHOZVRpsJl4lMJb0X5isXpVQ0mNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685094; c=relaxed/simple;
	bh=5DDZYr9v1+U2Dfmk0Ptnvjks7WOhWD7OuiUXUR9NIxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMN/buXHII107QUCDd97enYRqaOUoVySZCsIubhAXjKklrUEpgyPeCKJznMMgUxabjq2DkXEqWA+KWYqCuwkLFqZKdkTD31455CuFMOAnZYiWIT/p0lMRH2RAVbXN+cDYGW2IY2aoBp2J/DXC2dE4fhoEt7Ny05wJMztRW6yY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OASBwVq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OASBwVq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A971F000E9;
	Fri, 14 Aug 2026 05:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685092;
	bh=lP9/yXXAsnJRdJmnQhwHiute7U/+NXKwWDUGPS3S6M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OASBwVq9G97V8mdDvewdAgVH1s3N0tKk8fuN3E1kU2rwo2HrWxtl1ey4UewgG+eHF
	 AsSg2y+XnequoDy24U1ulZ818wcK0skieoQH9CAw5wwcCe0hBPUR7sn9f+lbSBwFRQ
	 mvCSVmZ/4H1MzPGEhvZR3nfsVh5sASD0N+g0ptWtw2ILZrq7Xg7LymkCRggy+ZbIdt
	 nWDPqDGOmuKYdueRp6PZw3aYpcgVfe1wiaB0Fug0c3EAcxgtnQjs4MLN3GHDpT40mb
	 3pHY6tgItBA6sEPeXznZksN2b2F3eLZPzGkOOpcel7FNjy/6PoDMgsPoSno/5ZT5dr
	 qLSteYXHQoVjA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.12 1/2] kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()
Date: Thu, 13 Aug 2026 22:12:53 -0700
Message-ID: <20260814052439.430858-2-nathan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814052439.430858-1-nathan@kernel.org>
References: <20260814052439.430858-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

commit 6ee149f61bcce39692f0335a01e99355d4cec8da upstream.

It does seem that using "volatile" isn't going to be sane compared to
using OPTIMIZER_HIDE_VAR() going forward. Some strange interactions[1]
with the sanitizers have been observed in the self-test code, so replace
the logic.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
Link: https://lore.kernel.org/r/20250312000439.work.112-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/fortify_kunit.c | 139 ++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 62 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index ecb638d4cde1..1541b2a1694e 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -394,8 +394,6 @@ struct fortify_padding {
 	char buf[32];
 	unsigned long bytes_after;
 };
-/* Force compiler into not being able to resolve size at compile-time. */
-static volatile int unconst;
 
 static void fortify_test_strlen(struct kunit *test)
 {
@@ -520,57 +518,56 @@ static void fortify_test_strncpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	size_t sizeof_buf = sizeof(pad.buf);
+
+	OPTIMIZER_HIDE_VAR(sizeof_buf);
 
 	/* Destination is %NUL-filled to start with. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 3], '\0');
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Legitimate strncpy() 1 less than of max size. */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst - 1)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf - 1)
 				== pad.buf);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* Only last byte should be %NUL */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 3], '\0');
 
 	/* Legitimate (though unterminated) max-size strncpy. */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf)
 				== pad.buf);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* No trailing %NUL -- thanks strncpy API. */
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* But we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Now verify that FORTIFY is working... */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst + 1)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf + 1)
 				== pad.buf);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* And further... */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst + 2)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf + 2)
 				== pad.buf);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
@@ -579,55 +576,56 @@ static void fortify_test_strscpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	size_t sizeof_buf = sizeof(pad.buf);
+	size_t sizeof_src = sizeof(src);
+
+	OPTIMIZER_HIDE_VAR(sizeof_buf);
+	OPTIMIZER_HIDE_VAR(sizeof_src);
 
 	/* Destination is %NUL-filled to start with. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 3], '\0');
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Legitimate strscpy() 1 less than of max size. */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst - 1),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf - 1),
 			-E2BIG);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* Keeping space for %NUL, last two bytes should be %NUL */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 3], '\0');
 
 	/* Legitimate max-size strscpy. */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf),
 			-E2BIG);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* A trailing %NUL will exist. */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 
 	/* Now verify that FORTIFY is working... */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst + 1),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf + 1),
 			-E2BIG);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* And much further... */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(src) * 2 + unconst),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_src * 2),
 			-E2BIG);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
@@ -767,7 +765,9 @@ static void fortify_test_strlcat(struct kunit *test)
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf)] = { };
 	int i, partial;
-	int len = sizeof(pad.buf) + unconst;
+	int len = sizeof(pad.buf);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Fill 15 bytes with valid characters. */
 	partial = sizeof(src) / 2 - 1;
@@ -857,28 +857,32 @@ struct fortify_zero_sized {
 #define __fortify_test(memfunc)					\
 static void fortify_test_##memfunc(struct kunit *test)		\
 {								\
-	struct fortify_zero_sized zero = { };			\
+	struct fortify_zero_sized empty = { };			\
 	struct fortify_padding pad = { };			\
 	char srcA[sizeof(pad.buf) + 2];				\
 	char srcB[sizeof(pad.buf) + 2];				\
-	size_t len = sizeof(pad.buf) + unconst;			\
+	size_t len = sizeof(pad.buf);				\
+	size_t zero = 0;					\
+								\
+	OPTIMIZER_HIDE_VAR(len);				\
+	OPTIMIZER_HIDE_VAR(zero);				\
 								\
 	memset(srcA, 'A', sizeof(srcA));			\
 	KUNIT_ASSERT_EQ(test, srcA[0], 'A');			\
 	memset(srcB, 'B', sizeof(srcB));			\
 	KUNIT_ASSERT_EQ(test, srcB[0], 'B');			\
 								\
-	memfunc(pad.buf, srcA, 0 + unconst);			\
+	memfunc(pad.buf, srcA, zero);				\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(pad.buf + 1, srcB, 1 + unconst);		\
+	memfunc(pad.buf + 1, srcB, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
 	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
 	KUNIT_EXPECT_EQ(test, pad.buf[2], '\0');		\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(pad.buf, srcA, 1 + unconst);			\
+	memfunc(pad.buf, srcA, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], 'A');			\
 	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
@@ -904,10 +908,10 @@ static void fortify_test_##memfunc(struct kunit *test)		\
 	/* Reset error counter. */				\
 	fortify_write_overflows = 0;				\
 	/* Copy nothing into nothing: no errors. */		\
-	memfunc(zero.buf, srcB, 0 + unconst);			\
+	memfunc(empty.buf, srcB, zero);				\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(zero.buf, srcB, 1 + unconst);			\
+	memfunc(empty.buf, srcB, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);	\
 }
@@ -919,7 +923,9 @@ static void fortify_test_memscan(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
 	char needle = 'm';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len),
 				  mem);
@@ -938,7 +944,9 @@ static void fortify_test_memchr(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
 	char needle = 'm';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len),
 				  mem);
@@ -957,7 +965,9 @@ static void fortify_test_memchr_inv(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + 1;
 	char needle = 'W';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Normal search is okay. */
 	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len),
@@ -976,8 +986,11 @@ static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
-	size_t one_len = sizeof(one) + unconst - 1;
-	size_t two_len = sizeof(two) + unconst - 1;
+	size_t one_len = sizeof(one) - 1;
+	size_t two_len = sizeof(two) - 1;
+
+	OPTIMIZER_HIDE_VAR(one_len);
+	OPTIMIZER_HIDE_VAR(two_len);
 
 	/* We match the first string (ignoring the %NUL). */
 	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
@@ -998,7 +1011,9 @@ static void fortify_test_kmemdup(struct kunit *test)
 {
 	char src[] = "I got Doom running on it!";
 	char *copy;
-	size_t len = sizeof(src) + unconst;
+	size_t len = sizeof(src);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Copy is within bounds. */
 	copy = kmemdup(src, len, GFP_KERNEL);
-- 
2.55.0

