Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C0414A1F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236410; cv=none; b=Cg3q6z6g2BpwCXAc52nSYSl4J3ZahP+BKHpgBOBIBVcSOMQSEqxIVPLd45+L3cDIx7uIIlRCJbr0QqY/F8hwT2B+JgidMrbKwO7/EDCj1VpikJ/+IeYlxWhfk6ihaX3cu0CPML/pgZ7Nk9WBMdBI5znP1kccW9gxfmBmfxL+wMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236410; c=relaxed/simple;
	bh=/2lEehzu5T9P8BnN3pXcEl5h4pIg8Fh+2+aQHZAzoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSF2PctMeKc7FAxBLv1AQ+Vf7XqJJN/b5wyws+tGhvqbfPaKOp6TcHh2Zlk6jow7iZ6QOlQC0GEL69fA2S3lQofGurDS3JCermcPt7KUODxRJOlOBryS96Zywtf5ILXMWmTpr2U3qCcO53e06VwYZ6zE8w6dUSYPSnNvIlrx2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyqD+Gn9; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyqD+Gn9"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5339b4a29f9so20911411cf.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791236408; x=1791841208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGiQbZnsx3vV3HLL1PhpDRCAfbemOrB2Rck7g3/BeyI=;
        b=kyqD+Gn9OIR9LikObAWxptafLSxDJQ6b/EtFH9JlBelCvZZOr7NDW7D2pzzeKmX2aE
         KKtFC0vCrxxQXzoHkrbEML6j0bmKAWTMNyaOdbSZLmTc619zmo3YbPS91K4Elf9sRgld
         7nUKNcappreJV0L3SW304gCLf1CsyGD87I9aXdRRFumiflaETs3f2k0mhn5SKcjG+cDG
         KSZXn9hgCbMsBki9nLK6LxL5dvRb6SQyqNq1VpHcmg0hduuVjSKxjRB1Oz5MI8pknzI6
         ySxlVg6h+FZ14R14OvFqetD4w4pEK8G7kYQROGwW2GRkoDOSQrgDZMKM7tGOKTS7KigC
         eAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791236408; x=1791841208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGiQbZnsx3vV3HLL1PhpDRCAfbemOrB2Rck7g3/BeyI=;
        b=sDMZyFl6BEmw2AnKHYAvw3eANVD6lp8dwpjc0SptkPN+QkUIVGcTjq+syebgyZBbf3
         4H3aShfuCDbM49srrMGH3U4Sdi0YRDu1Z5fDncTDqoa8cT1QPXIjpZoKNzaDiewA755P
         lgXEVFQSbooIllTc8Ki/zXcLsb8B071laklSMe/3snbsNiQa+jUCJRbfh9fP32+eghJ/
         UxCcWOzTnFouPCNfOm7X2wiW+omRua1LW0H3ZPoQyK0vZoecIdLiey7jgwQ8PAm2L+MH
         YJ/LMpANlkm+/o/r7h7OSUv7U3M6hj1xfIEHhm9eHd6LJoMz5dCA82yxJAqvCLzT3wY1
         F6bA==
X-Forwarded-Encrypted: i=1; AKwUvBzyqrrHXGNcSYQ8raA5niU+/AohOYR/tlOdV11wX7lehTO00eI8Ndc+m2iqr0E/SvcvKn2ByyE=@vger.kernel.org
X-Gm-Message-State: AFuF++mi+oRRcvb7By7nZfQr/TcXWvSO5t641ktDcdfV2Ujq/KczC8bI
	O4b9wyhz/ito2vio02ITSHwyz2gOxuAzftzrEpNQK1jIzFuaTh8Qe63q
X-Gm-Gg: AYBFou0y8Qu39cG+ypRO7DX3q8cBKSTcS6cWDZlOnM+nw2kVwIAIQjS0C5QDcx+R9Ms
	9zydVdjUNHhhD57uebCS/gqHetCUrBSW3fYKSn0gm704L8omvWUwUBIrWObCId327O3V4m8/fY5
	qO9/aJtsGrisIqqI//K0Af73HAxyvFJiqJC7aCprKtL5hdeBVK8xT+upX7lmVaANwyrMgG5sl85
	tVgjFDEajRN4oLV6DjE5JI9aYO/m90cWY4bk37dpV7OvHEocl9XsLyA0tST+iuhKsQ8KK9jmMIE
	f8T7Ny0iIVAUSwlTYuiZhayov3KrZ/Z2KSNHitNB2Bj1QIi6Hx9kqDbpQywZEr1t96MNfQym4fC
	iWGnyrtYF+CozE7kPsiNupsQFtigmePRzTFHefy/M/h9uWmOQSx/yDpBsQlWfmbjwVoSEO7cQAO
	ZS2HtGWoZWTABg0vT4S+3wBcVRegQDXmWjPscvuNdACvu613DLsGxstJxjwCOW+AVa3BBM1LGX
X-Received: by 2002:a05:622a:5c0e:b0:535:10cd:8b41 with SMTP id d75a77b69052e-53510cd8e08mr156011931cf.25.1791236407677;
        Mon, 05 Oct 2026 14:40:07 -0700 (PDT)
Received: from fedora ([47.14.88.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5351fd92b58sm55315451cf.21.2026.10.05.14.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:40:07 -0700 (PDT)
From: Armaan Sandhu <armaan.sandhu0504@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org,
	Armaan Sandhu <armaan.sandhu0504@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] lib/cmdline: fix get_options() count and overflow with large ranges
Date: Mon,  5 Oct 2026 17:39:45 -0400
Message-ID: <20261005213945.359905-1-armaan.sandhu0504@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_range() stops writing once the array is full, but get_options()
still advances its index by the whole range. So "1-100" parsed into
four ints reports 99 numbers, and a range like "0-2147483647" wraps
the index negative and writes outside the array.

Stop once a range fills the array, bail out in validation mode before
the count overflows, and saturate the range length in get_range().
Add KUnit cases; without the fix "0-2147483647" panics the test kernel.

Only root can supply this input, so this is a robustness fix.

Fixes: 22f2e2801799 ("[PATCH] get_options to allow a hypenated range for isolcpus")
Cc: stable@vger.kernel.org
Signed-off-by: Armaan Sandhu <armaan.sandhu0504@gmail.com>
---
 lib/cmdline.c             | 13 ++++++++++++-
 lib/tests/cmdline_kunit.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 16cce6621cec..40b98d943a9a 100644
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
index 3f61ff8d3178..584fcb2c0e44 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -140,6 +140,43 @@ static void cmdline_test_range(struct kunit *test)
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
@@ -258,6 +295,7 @@ static struct kunit_case cmdline_test_cases[] = {
 	KUNIT_CASE(cmdline_test_lead_int),
 	KUNIT_CASE(cmdline_test_tail_int),
 	KUNIT_CASE(cmdline_test_range),
+	KUNIT_CASE(cmdline_test_range_overflow),
 	KUNIT_CASE(cmdline_test_next_arg_quoted_value),
 	KUNIT_CASE(cmdline_test_next_arg_bare_quote_regression),
 	KUNIT_CASE(cmdline_test_next_arg_mixed_tokens),
-- 
2.55.0

