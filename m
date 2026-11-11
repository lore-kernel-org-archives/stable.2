Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367141;
	b=E2bXPkjixOzabXRLXVTEZgquHgbbLCjYXTnq9d8E7w/MzbSWgwB2+pHkCQA5i4wyGHSJ
	 pJpEPDtQrRq7+sAY0p2lMoZWiX2MpSQaO5Q08V6sowhQB16Nhazad7AceE8fKPtPnGqM1
	 HKmUpQxDEmhFfCeB52SM7/c7Tz90QV29yu4WQxkndMSIIEDugNlO5pz1VHhJCWjIba/iP
	 Jn6fufoPagyR83zu8AXS3dP/eCW7WQUI4NARH6jA9mtzM6gpbv3eWIKIG76+dZVcyxws4
	 BD5m4C0uwcK1H1OrIIZZuXhnjZ+A0mulKcrZ08L8AeOluBFwtEYFIx+0W0x4818zkYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vozT1LCfpeXUzV4r6YLaAODYT1z2iBbJ0i4FAwhMZDA=;
	b=5KLynpz0Ukmhk7fP0TFKTLpr4jHChhr6QW4OAf1sG4Ig7Gou7PAXgaWBVsJNQllgVc0K
	 T/mxesoI4SE3IaoZOho457RfAFAGQzCflTwn7cyqGOt95npYlGjkN66pcprnF4nKwS+ym
	 AlCTW2mRbhiEcZUt3gQVeAhRA6RE+ninhsSI/UsyE8wl5bT4t9eC0Jul+3tBiBAL6NTev
	 Si/CxVjRfctHtuXH1ia2z6Uuw/07RvTBEWudv+Bbax4Xi50kALIljx36kdqB1lsZiqc/X
	 7FHbcbArZzNSDwg5EzgGcPCM7ry+ahWW9jrmzxedaXmGle6GAHIZrzK7KcAaZBrJqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8EBu0ju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C4606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8EBu0ju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732761F00A05;
	Wed, 11 Nov 2026 03:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367141;
	bh=vozT1LCfpeXUzV4r6YLaAODYT1z2iBbJ0i4FAwhMZDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8EBu0jujyt6zeJzsT1U1dHq6xtvAK2kSQi0goxysY5IMNl35N77r0BnLWsFl0tP5
	 jnXRlqb+9ZnVkswIdfNCAXVxNjKi2jFK+qCCH7f97nI+sl011qiFtz6dgJFXPN7KAw
	 z/JkZ5ep10Xonr6fnn2vOiv5wpkluyVvrKsscdbLhK1HO0ObJdl+vma7AWqrnwg6iU
	 JZWck0UEyz0ZNJyKXRor0OZ+DBgZP1yl73N1SPeBovc4BXSYzum9GmIAh9YboxSI4o
	 wThNEg4HDDSWz8Vg4bUBj06Ys5MOP1JKw2uS5Uo0nlx0et/mML691UV11mAvYZ3MZ6
	 z1ODnD63sGGHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armaan Sandhu <armaan.sandhu0504@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leizhen Zhang <lzsx618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] lib/cmdline: fix get_options() count and overflow with large ranges
Date: Tue, 10 Nov 2026 22:18:58 -0500
Message-ID: <20261111031852.879477-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111031852.879477-1-sashal@kernel.org>
References: <20261107053759-failed-6.6-5d72266218b1@kernel.org>
 <20261111031852.879477-1-sashal@kernel.org>
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
index 20d525aa23eda..e720f056c84df 100644
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

