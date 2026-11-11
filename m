Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366161;
	b=AV7ZBOuQkT3J2dqAkDtU1KW2wtHGm5BLVA8TGsTcuw70OgeBZ8WDbWJvD24Ve7Qr/0wi
	 o9OSO7LauhFPSCh8wAfsb3YEA+YaQjqcxNOu1SmJoZu5FXDf4sdlM02VcAKUZ6A0r0vZa
	 7Ecrn1SEWs0eOJOvEcFpThu2sLhkCffh8IYOS0/+6xZtsHEk/qp/DY96J9hq9YpMCSzH7
	 SJJm57+ZTg9aZg7SmVtHTJBc63gqA2L8poemmMwnY6qC7rauOr+UQCF3A41GzL9K8VBPh
	 CJ3Bj9iRJLCwgMIoS7wpgmHKD8D70IckgwhqTSwmuJLw1lwstGbqqFYs8oOia80Lnnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IQLs1k0PcI7adqXl4M8fE5jcm490cdGpcAkutVK9Xbo=;
	b=rAPDG15/IjsptnJ2Uu6jSiX7aSaR+f9YuBSu5cRJAaj3AvPFtGT4hamapuj1Rw+xAHE7
	 xZbhKpB+6EMzWRWbUJHfgGkqa9OObWehtLdoKqKLVWA+8Kzm/30sDEIZmJh/45QKVRc9G
	 C94HN/sVDwapIyinWCeGXAICU1lFfV4AyRIsG0rRYzj/sIjogD7RfARrBs5KH5sjJGD+p
	 nx50R2g0BupUKmX4kCz+PRZ0kyUbrFYazyGmybp3SriWnyn1X3bzEoG5c7cBBxlF1tn9e
	 nTHTvJtQAlbMRlXXTozuwlIL6J8yk71pdXh64FVQNUypqKD/a0cffyaLOEcnWVBEZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGTMf1FF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E179606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGTMf1FF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3191F0093C;
	Wed, 11 Nov 2026 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366161;
	bh=IQLs1k0PcI7adqXl4M8fE5jcm490cdGpcAkutVK9Xbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGTMf1FFFmCCHUIiTVDMHy95GCKLLCDDJsztKvexp3lzvWco2eAQcyP2kP13aVJ1s
	 kaSZuYfSxw143XNMWmttZhM11+005tj2Nsxyc3/PL9Uktvf+GdzvFv9rYGZ3dxw8yj
	 luzjOROilR5eGKfx4/+2T6XgGB6ecVeXzWO6NZaAEL1V2kqHipXhm4BU/2OYu2ddCW
	 ErjhFYXzWzIyzV1NiQuGafs81fiXYOuFy3PxInRcmmDm918H6V8GFmYTDnUrSy1TlG
	 MYv3xYG7pUTYTiPHlZsX1MxFfYAAQFmA9oTYuZbw04S4GLndp1Yi+Dxfp91AlhIFXK
	 9ifqO4Gczzaqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armaan Sandhu <armaan.sandhu0504@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leizhen Zhang <lzsx618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] lib/cmdline: fix get_options() count and overflow with large ranges
Date: Tue, 10 Nov 2026 22:02:37 -0500
Message-ID: <20261111030039.812757-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111030039.812757-1-sashal@kernel.org>
References: <20261107051330-failed-6.18-5d72266218b1@kernel.org>
 <20261111030039.812757-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Armaan Sandhu <armaan.sandhu0504@gmail.com>

[ Upstream commit 5d72266218b1c4dd2917f1df2b86f3b0e0a605c9 ]

get_range() stops writing once the array is full, but get_options() still
advances its index by the whole range.  So "1-100" parsed into four ints
reports 99 numbers, and a range like "0-2147483647" wraps the index
negative and writes outside the array.

Stop once a range fills the array, bail out in validation mode before the
count overflows, and saturate the range length in get_range().  Add KUnit
cases; without the fix "0-2147483647" panics the test kernel.

Only root can supply this input, so this is a robustness fix.

[akpm@linux-foundation.org: add additional test case from Leizhen]
Link: https://lore.kernel.org/20261005213945.359905-1-armaan.sandhu0504@gmail.com
Fixes: 22f2e2801799 ("[PATCH] get_options to allow a hypenated range for isolcpus")
Signed-off-by: Armaan Sandhu <armaan.sandhu0504@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Leizhen Zhang <lzsx618@gmail.com>
Reviewed-by: Leizhen Zhang <lzsx618@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cmdline.c             | 13 ++++++++++++-
 lib/tests/cmdline_kunit.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d95701..f5dc59b3548e9 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 
@@ -26,7 +27,9 @@ static int get_range(char **str, int *pint, int n)
 
 	(*str)++;
 	upper_range = simple_strtol((*str), NULL, 0);
-	inc_counter = upper_range - *pint;
+	/* Keep the sign of the result when the difference doesn't fit */
+	if (check_sub_overflow(upper_range, *pint, &inc_counter))
+		inc_counter = upper_range < *pint ? -1 : INT_MAX;
 	for (x = *pint; n && x < upper_range; x++, n--)
 		*pint++ = x;
 	return inc_counter;
@@ -122,6 +125,14 @@ char *get_options(const char *str, int nints, int *ints)
 			range_nums = get_range((char **)&str, pint, n);
 			if (range_nums < 0)
 				break;
+			/* The range didn't fit, so the array is full */
+			if (!validate && range_nums > n) {
+				i = nints;
+				break;
+			}
+			/* Leave room for the upper number of the range */
+			if (range_nums >= INT_MAX - i)
+				break;
 			/*
 			 * Decrement the result by one to leave out the
 			 * last number in the range.  The next iteration
diff --git a/lib/tests/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
index af44ae9e92c3e..74c4b5ea32250 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -139,6 +139,44 @@ static void cmdline_test_range(struct kunit *test)
 	} while (++i < ARRAY_SIZE(cmdline_test_range_strings));
 }
 
+static const struct {
+	const char *in;
+	int parsed[4];
+	int validated;
+} cmdline_test_range_overflow_cases[] = {
+	{ "1-100",         { 3, 1, 2, 3, },    100,        },
+	{ "1,5-100,7",     { 3, 1, 5, 6, },    98,         },
+	{ "1-2147483646",  { 3, 1, 2, 3, },    2147483646, },
+	{ "0-2147483647",  { 3, 0, 1, 2, },    0,          },
+	{ "-5-2147483647", { 3, -5, -4, -3, }, 0,          },
+	{ "2147483647--5", { 0, 2147483647, }, 0,          },
+	{ "1,0-2147483647", { 3, 1, 0, 1, },   1, },
+};
+
+static void cmdline_test_range_overflow(struct kunit *test)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(cmdline_test_range_overflow_cases); i++) {
+		const char *in = cmdline_test_range_overflow_cases[i].in;
+		const int *e = cmdline_test_range_overflow_cases[i].parsed;
+		/* Two guard elements past the array handed to get_options() */
+		int r[ARRAY_SIZE(cmdline_test_range_overflow_cases[0].parsed) + 2];
+		int n;
+
+		memset(r, 0, sizeof(r));
+		get_options(in, ARRAY_SIZE(r) - 2, r);
+		for (j = 0; j < ARRAY_SIZE(r) - 2; j++)
+			KUNIT_EXPECT_EQ_MSG(test, r[j], e[j], "Pattern: %s at %u", in, j);
+		for (; j < ARRAY_SIZE(r); j++)
+			KUNIT_EXPECT_EQ_MSG(test, r[j], 0, "Pattern: %s out of bound at %u", in, j);
+
+		get_options(in, 0, &n);
+		KUNIT_EXPECT_EQ_MSG(test, n, cmdline_test_range_overflow_cases[i].validated,
+				    "Pattern: %s (validated)", in);
+	}
+}
+
 static void cmdline_test_next_arg_quoted_value(struct kunit *test)
 {
 	char in[] = "foo=\"bar baz\" qux=1";
@@ -203,6 +241,7 @@ static struct kunit_case cmdline_test_cases[] = {
 	KUNIT_CASE(cmdline_test_lead_int),
 	KUNIT_CASE(cmdline_test_tail_int),
 	KUNIT_CASE(cmdline_test_range),
+	KUNIT_CASE(cmdline_test_range_overflow),
 	KUNIT_CASE(cmdline_test_next_arg_quoted_value),
 	KUNIT_CASE(cmdline_test_next_arg_bare_quote_regression),
 	KUNIT_CASE(cmdline_test_next_arg_mixed_tokens),
-- 
2.53.0

