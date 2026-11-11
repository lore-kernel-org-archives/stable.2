Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366825;
	b=MisdxbjUxbhURQt08nKKj/EzhEnNA1xbDWOGYubHrBTTuPLETgxmm7ZgBkdj+IFYShcD
	 Wdw3ipdaTmNO0vF+jobTIXEDBs1i7PQXob2TR863gRL8DW5LMvbUhxL2c/Gw4qqe+YHoN
	 cfZravvZror1AM8CcP5/su6aYrEW28ey3oSLqhCQHltRxcd+JeaZ3RucDDiK1CcirXXuW
	 C+UZCACVo1BQxYA4K5UqEfP7J7+sQNt8YGIAHL3PsXjrTltBAinEvJQVlaEUm1pTOfKAW
	 j1RcCDAQ0rr8Gn/VzSB5+VKYEiL7JL4CS86cU6u1UfWS4uvPTwedaTw2iatS9aXm2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=phQVKZmesdUoM78efvClfyyt5KXbDh+jIA8DftB/3Vo=;
	b=bMBbCrpYOEaJtLx9gFGUGdY2xykGi7wO9ZEyaorTnbNXTE3kFjz0UFv2mJSz0A6BIpSb
	 OAVQDnHy175xyjUaD2Evkp09yZE1DqTfjsFZNoTFbRdkhuHnbegMX1C421r0OH625sRNp
	 o+Gj6TYa7KGpaoexD7qtx0Tbm1Qkt99C80XmneC6Rt+NWOo9uKKyPjTQdnNCFV+dHSqAY
	 cWj/vOJBNB/g2KeeuxjVDJ1MZYC+LTvmRD01J37FPrLB02/u/zAV+6Px7xQoVhXIBGYN/
	 TdUIrh6hA7sqzP8pPT9irQldUa+Ha0iaBLHK9HomaObdWUj0CGu6d/cifXh8t/p/LCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlQx2TyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E50606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlQx2TyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D3A1F0093C;
	Wed, 11 Nov 2026 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366825;
	bh=phQVKZmesdUoM78efvClfyyt5KXbDh+jIA8DftB/3Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BlQx2TyEwjInQejxFiWFm75RykWvb/veFxXO9w8EHzpkwNO9NLu2rI+sKmkMUAtXW
	 KEyDNwVMYMidK/K3IcUspgoUGoxrJ71gSEK7YazpX50iX3b/K7bTzhn5bVP1JMy6+8
	 DkBGrz2Z1Q9dtQhZiikCbn6ZkWke7oGMU+yEuf3h6Rgs6KksZitMU4YDI7Dl14endN
	 cV6SXfEiu74X/c+er5N79qwEghLCR76D3fEQiTSfqIfKC9TWs9uqlMK5gSG0yzZiWD
	 ZCAlAoATikj2p3+4PIjeUCmo/2VQ/1pLyUzOgYiOQGTN3JzVbrFbelKX5gHpg18/MB
	 /FkUBo+pnxwQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armaan Sandhu <armaan.sandhu0504@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leizhen Zhang <lzsx618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] lib/cmdline: fix get_options() count and overflow with large ranges
Date: Tue, 10 Nov 2026 22:13:41 -0500
Message-ID: <20261111031318.849711-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111031318.849711-1-sashal@kernel.org>
References: <20261107052511-failed-6.12-5d72266218b1@kernel.org>
 <20261111031318.849711-1-sashal@kernel.org>
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
 lib/cmdline.c       | 13 ++++++++++++-
 lib/cmdline_kunit.c | 39 +++++++++++++++++++++++++++++++++++++++
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
diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index af44ae9e92c3e..74c4b5ea32250 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
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

