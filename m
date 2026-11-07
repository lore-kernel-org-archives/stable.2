Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050845;
	b=STrYfyNHCP92UIaPDhVYhw4fHhVwfn/G+wch0CpPZWm+L0zz6u4xFaw9hZffWmqEmzTU
	 Oe8ITmyblLGaQmb1lxogeU+ATRUp5mn565qwQkvqtY8DB0yPpQ6L2t60we2cYEJ8mt5aN
	 1/W5oVtgZRKdaWLz3sr4RTVPQ+8PXSCsvaPOoFXR03frWqadC1EQR3sFcMcTp88LCUo6F
	 0iCIw39nAT559VIWxc6HMkMXf9fbYqKjJqbdy94fOO3IPaYep9wes4Zj+/LSOcNWRpPz8
	 oJ0OTABtY25iH7Aq6YipT5SOJbCIgiCw1ORrdo91pk5EGjBfOcN3t8FvVfMwovAyfYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FK8FomT7uh8LAZctTz0rzHF7LTG4WJQ8C97TMfzwkG8=;
	b=Bx4nEd5ONC6uJvx8JnndennykMugWM39qLIF2+MQqM2yuRHI9f3b6yPL0/s5aXMUOlER
	 5YR4UeJ5JKG8EnNXzQ3aSky40SoohRiaHLL46jgx4J6GHS3jw3AUjv8zUPu5/DFH7Y5fJ
	 81VSpThSPSIgoR7qQSZl1kJC7wiL//4Xi9jAsNrUDrD+lePnF15fzCRVpK9aQ0FzIZ/95
	 qNxveRIKxW84MtZT1HE101Qs6zHcolu8VgO+X3+cR/jDI53/J0mapaXEMk7PXkORgA7WR
	 r/1Kw85GqVxmB8jfGyXJxuM46k1IVYbyTjszfRac+O3/qf7tYaIUOWtgq/ZVuyw1qnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwXFJOm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwXFJOm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5379E1F0089F;
	Sat,  7 Nov 2026 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050845;
	bh=FK8FomT7uh8LAZctTz0rzHF7LTG4WJQ8C97TMfzwkG8=;
	h=From:To:Cc:Subject:Date;
	b=HwXFJOm077VX1p2I2Vyk7WGP5W4NECr6HwjzDlSkc/2PcIWhghC79322qtp3HaOpi
	 +3UgvFRDGouaOedrsFDkGbUctq8Z07r6cDheDAQgYPO8QxvXxE3ZDDkuuj17kpCdT6
	 c5o3uPo+gxjCnb46A+KFgXgh6DJiVbfcSLCm8X8oIDnEvxKq8ObXelYprJzRhosXyk
	 ogFVhKKd8OtZm3jDQy7j9cp5MTahodwGr2V7ue8Job5wlwv+28V2d34GPOvV3TQZSD
	 diauUji+tEqSJmO1Q3V78ticM0K1bnryG71uWVMyTHh8NaZkbA8gM3kPjxOd0h8q17
	 LxncPFpvWeyDQ==
From: Sasha Levin <sashal@kernel.org>
To: armaan.sandhu0504@gmail.com,
	akpm@linux-foundation.org,
	lzsx618@gmail.com,
	andriy.shevchenko@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] lib/cmdline: fix get_options() count and overflow with large ranges" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:23 -0500
Message-ID: <20261107062722-failed-5.10-5d72266218b1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5d72266218b1c4dd2917f1df2b86f3b0e0a605c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062722-failed-5.10-5d72266218b1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d72266218b1c4dd2917f1df2b86f3b0e0a605c9 Mon Sep 17 00:00:00 2001
From: Armaan Sandhu <armaan.sandhu0504@gmail.com>
Date: Mon, 5 Oct 2026 17:39:45 -0400
Subject: [PATCH] lib/cmdline: fix get_options() count and overflow with large
 ranges

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
---
 lib/cmdline.c             | 13 ++++++++++++-
 lib/tests/cmdline_kunit.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 16cce6621cec1..40b98d943a9ae 100644
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
index 3f61ff8d31782..12b85f255b651 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -140,6 +140,44 @@ static void cmdline_test_range(struct kunit *test)
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
@@ -258,6 +296,7 @@ static struct kunit_case cmdline_test_cases[] = {
 	KUNIT_CASE(cmdline_test_lead_int),
 	KUNIT_CASE(cmdline_test_tail_int),
 	KUNIT_CASE(cmdline_test_range),
+	KUNIT_CASE(cmdline_test_range_overflow),
 	KUNIT_CASE(cmdline_test_next_arg_quoted_value),
 	KUNIT_CASE(cmdline_test_next_arg_bare_quote_regression),
 	KUNIT_CASE(cmdline_test_next_arg_mixed_tokens),
-- 
2.53.0




