Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367140;
	b=RCOJwp7z5WmbtyacmHQhj4wNHUN487XZ20A//IYKONHhHzpnnkOdU5f/ojEixrIu7wAa
	 4lKlfEL7UsVX1ESK7UGOFRrAQpeNxsU3EwZXo237+iD5GigHf5f5MRWUeMr/kNKCTYXcI
	 /x2oZSnb3i8fPAQxIOQs6eYvJj/4fJIjUQT1B3RGTMmDMm3Zg48DJPfJvucHlwezUsppB
	 mPjLdeFiLwa5IIpaqgHlRSM7YwnawUmdbWs5KM9Te0Wyt3MFU2H7mXdiuK2N1QkqdWG75
	 xShnnrlZ3o76ZM2nNHwzo8224UlBpYoPANt3Y7fGdcJjzJdzq2ahi4FULc8srsslgpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367140;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MvYpDUCJt4KnUGzl//wnY32C1whdY+l2kgThQERf9n4=;
	b=G7A/vYAfPmjDt76xGGRZYu3uOVh2liaqPgV5P2AQpKCm5SDaxU9S+e9de2CLQpuPeMzo
	 AhZDaR2rtLGmX1BGl2qxLH8iJVhXS/BFnJJ1Q4fI5k+JXJLja5w9jqLHLnPZ36NvpiqZR
	 xMA/LRYi/z0qI5vLuWBPzPe3AQVoVQYuazh3HM8N9INQb3gFNKSKGs7rfWRxX7xVdKi7F
	 SMCgkA6YBnnCU4x6Cs5SeLQgfy0Vjm2Jcz+eukGUj/zx7zbKvx4GfXjl+xOzk/8cbuJ+h
	 l65/8arYiLJJnQ1HuuCJDvJIoSr3SXeWdSkaA7PgCO+sgqmb/YYh5wfFTozM0pKvAHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu9t43by;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B355606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu9t43by
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4127B1F0089F;
	Wed, 11 Nov 2026 03:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367140;
	bh=MvYpDUCJt4KnUGzl//wnY32C1whdY+l2kgThQERf9n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu9t43bynDmnaQTGFdQyww5xgmwAjlirhp1cmBpvJ4NrPEJUcoAzhsf+TSMdpkbYB
	 pIJcvob2ZTodAhZ/+FMTmuaj6c59ZoQz2L6WeESV7ykUy9DhvlGt+xoEb4c3N0KITi
	 sk2uzwEaayLtJQYCCPuuKG3zhT67fJR1f7qZx+wvEM0E81mkZ0DwndaVqLZZeLYOer
	 CQbYSfsuuZFbfOLdLCeKFtT+6XAagUNoKh7092j3EPkvRq4AUjSVUoDArgQRm2zCkc
	 OJHn1+24UpCDY7BlG1inC/YzQtgTT09hE7JudqRBaYGqtkfaNT1vlPJWz4S1UJanGu
	 0/C7RRwFPkUkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Neel Natu <neelnatu@google.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] lib/tests: extend cmdline KUnit with next_arg() tests
Date: Tue, 10 Nov 2026 22:18:57 -0500
Message-ID: <20261111031852.879477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053759-failed-6.6-5d72266218b1@kernel.org>
References: <20261107053759-failed-6.6-5d72266218b1@kernel.org>
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

From: Shuvam Pandey <shuvampandey1@gmail.com>

[ Upstream commit dcc8a57815534e3844f342b28ecfb6e626a816a0 ]

The cmdline KUnit suite covers get_option() and get_options(), but it
does not exercise next_arg().

Extend the suite with one test for a quoted value containing spaces and
one regression test for a bare quote token after a normal parameter.

The regression test covers the bare quote token path fixed by commit
9847f21225c4 ("lib/cmdline: avoid page fault in next_arg").

[shuvampandey1@gmail.com: extend cmdline next_arg() coverage with mixed tokens]
  Link: https://lore.kernel.org/20260316211249.88601-1-shuvampandey1@gmail.com
Link: https://lore.kernel.org/20260316101227.15807-1-shuvampandey1@gmail.com
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Natu <neelnatu@google.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d72266218b1 ("lib/cmdline: fix get_options() count and overflow with large ranges")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cmdline_kunit.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 705b82736be08..20d525aa23eda 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -139,11 +139,73 @@ static void cmdline_test_range(struct kunit *test)
 	} while (++i < ARRAY_SIZE(cmdline_test_range_strings));
 }
 
+static void cmdline_test_next_arg_quoted_value(struct kunit *test)
+{
+	char in[] = "foo=\"bar baz\" qux=1";
+	char *next, *param, *val;
+
+	next = next_arg(in, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "foo");
+	KUNIT_ASSERT_NOT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, val, "bar baz");
+	KUNIT_EXPECT_STREQ(test, next, "qux=1");
+
+	next = next_arg(next, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "qux");
+	KUNIT_ASSERT_NOT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, val, "1");
+	KUNIT_EXPECT_STREQ(test, next, "");
+}
+
+static void cmdline_test_next_arg_bare_quote_regression(struct kunit *test)
+{
+	char in[] = "foo=bar \"";
+	char *next, *param, *val;
+
+	next = next_arg(in, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "foo");
+	KUNIT_ASSERT_NOT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, val, "bar");
+	KUNIT_EXPECT_STREQ(test, next, "\"");
+
+	/* This hits the i == 0 quoted-token case fixed by 9847f21225c4. */
+	next = next_arg(next, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "");
+	KUNIT_EXPECT_PTR_EQ(test, val, NULL);
+	KUNIT_EXPECT_STREQ(test, next, "");
+}
+
+static void cmdline_test_next_arg_mixed_tokens(struct kunit *test)
+{
+	char in[] = "bbb= jjj kkk=\"a=b\"";
+	char *next, *param, *val;
+
+	next = next_arg(in, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "bbb");
+	KUNIT_ASSERT_NOT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, val, "");
+	KUNIT_EXPECT_STREQ(test, next, "jjj kkk=\"a=b\"");
+
+	next = next_arg(next, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "jjj");
+	KUNIT_EXPECT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, next, "kkk=\"a=b\"");
+
+	next = next_arg(next, &param, &val);
+	KUNIT_EXPECT_STREQ(test, param, "kkk");
+	KUNIT_ASSERT_NOT_NULL(test, val);
+	KUNIT_EXPECT_STREQ(test, val, "a=b");
+	KUNIT_EXPECT_STREQ(test, next, "");
+}
+
 static struct kunit_case cmdline_test_cases[] = {
 	KUNIT_CASE(cmdline_test_noint),
 	KUNIT_CASE(cmdline_test_lead_int),
 	KUNIT_CASE(cmdline_test_tail_int),
 	KUNIT_CASE(cmdline_test_range),
+	KUNIT_CASE(cmdline_test_next_arg_quoted_value),
+	KUNIT_CASE(cmdline_test_next_arg_bare_quote_regression),
+	KUNIT_CASE(cmdline_test_next_arg_mixed_tokens),
 	{}
 };
 
-- 
2.53.0

