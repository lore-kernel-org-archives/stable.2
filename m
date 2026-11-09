Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261297;
	b=g4PbB+rXIMZY0MpQiNdZeLiCzpNs9hZjQyqR4hTdlZZ5XtL0BODwaPl93YrnOyGhU6J5
	 7uk4jPXTk7CrDdRn3WECV2CAHPGJxW9Xgbafj2B660LyCZDmfLTrBp6n+4IDQ0sfkIRjt
	 95ypusHUwRhcY64PUwkLrFMb9sNkYa6fLd4sPhRzciVAmQ+abG199KkcmnGUd40682hls
	 hqRSXs8RVvSQDYkZffuktosY6kE0NbXLrOAGwNhmqnJziIeTIqeJP8RK/FdgDPp+B6l1L
	 tKtFNcyG7Kjk3VCP28yFs56rxCZhXdEQeoOlGHYpl41m96AnUclwqBBmdja94u8r8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ROqczpwYwbeog2qJ+swl8u1dzKkVsoeYn9VGtSF4j4=;
	b=L2MBc1iH3Xh5W3romUZxW/mNPrXPoGUqZqcOgSoQ/XvKKJ3ErQNe1u+kkvJdZGq/wESM
	 n60bRIn5s7Bz1PkQIE8I/8q8pfkeZXJ3wd6MP+W1BjXKIEG5AKT+2qRqm/k6ecN+I8INS
	 e1XcgLibDkxd+Y1x9GbH/sq2lrW/iD+7yA89KUN3IY4rS4t7Z5S5GUGY4eDxRjkwxrLOo
	 F5BkfxlHQmNVqSle207OBxM8e2Qo8KOYFH+1IbcfmoZLTrT4MRN2ZCMEYZGorj0jPudzs
	 iEdkA6+PLCnBd/J22UfOUbTkeuRXcLCQ4zTebuSX4me4LobFlGs5jMtTVlpimJ5/uvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UIKhMw4n;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3B606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 21:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF3B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UIKhMw4n
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso1048896eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794261296; x=1794866096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ROqczpwYwbeog2qJ+swl8u1dzKkVsoeYn9VGtSF4j4=;
        b=UIKhMw4nmfp/6CP8G+O6iwCzBX7LdQBK8uAqw7KlAobt+1S5pq7JNy+eSzLZk9VXf7
         8Dd4f/Th447tAlovVXrrgdRKU5K5kK2pFmS2iRweNdsX+T/YvWljft1mAtTG+NTFzFS/
         MDbdhxGtQgUJVvcDsF441U5xgh/mZ2PqwsAfQc/C2nrOXV7iyx6ZXK5UuoXQJ8ugJikF
         sUQrPwR3AOecXerpQ2oD3LDtMqDFwe/Ln39/4ZVJunuXaWcb5pEIWGAjJPvFzfEKdhYB
         BPmfjE8Aa+mL0EaTQAMICqzZVWrjZe6KkVNhBS+BKNtJAr74SBCtFouuy9L9wdLEDh5C
         nTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261296; x=1794866096;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ROqczpwYwbeog2qJ+swl8u1dzKkVsoeYn9VGtSF4j4=;
        b=zLUpxHRakFHB5YeIk+ezmgN5HUeSrqwdHpHRSWyAtJP7t30J7nuGn0/LVr2LhKPkcY
         9/hk+JhXh2F9leh1dE0ZtxBaGEKk1Sc0nCIorrhpgyE0pTbgHwZruUgut2daQ4lt+0Nh
         V04LnnOYVmHuwXAo+fMW03u7xxYrPxk4XFlIKkmXjuNwHG03GZMV9n7Kf3YgK0P+dkZ3
         ryXgcqGpUbqR8SPPY7JPEBFcgMZadrjGWrcqmK4Rjp16nmzC2Wbqyhpl9IKbQhcsJrhj
         ywMg8rgCZVvExLspJvXCgjxnKqr29hliAFHXhDhpv5ZkYEOJH3II+FR8LTZpQfWy7EOk
         46dw==
X-Forwarded-Encrypted: i=1; AL+hErE9Q+U6kfcLf0BDDw/T5o29ECqVvNIAkLjeTcp0FPyV0fdqPrU59a5SNFjfx6w/ShLZSXs7UMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oxN9oets8XzRZXMGe1exxpEl3bVtk1x5A/X6sAZfRf3SuPbTa
	RhM+XEC5Beji0nmgKC5teD0lI/shVOea2tc06mKaiddAqwepAPPyo6LY0GcamgbY3+8=
X-Gm-Gg: AYBFou15hro3+ZM1PPwx1FML374uZpA+tNrf1Exni9rrPLJmzFurhFZTebHBO/ETbTn
	eO0d/zXAYY08KYKp2ZvtVBxfehzpYILOCpDeiNVfaaBDlDJZjJ5EL1COG37ceTrc9lm0Oc4ZZjL
	26DrrEac3hCu0W9MW98/6JNjEi23G3e07RpnPWw2B0L0fEOuv/lLgP9CvllYAJNWoNNBMTT0mzT
	SfC/6paWdrVwvEE9OJLO2Ez5jZQ9LKP2O8oRkEdQK13xL3NQ3r78AVwUIcNo6jhV9cWSs/Sww71
	ngJiGwCMxFsBoL+N18FLxPl2M55M22lQJDNL/0xoDkbxCNRP8swzboAZS6IwuoXIaR8Z7rkFT4n
	4VBE84NednPX9CEnc3XD2tcHqaDHE6Y9gAyk/4q9ojmSwna7myBrZ6E1muGS9yYr9yREk04JEHA
	b9463xElBu9MtDMag3TjYGiUJel1khi/xidVs6nK7+Go1LyOwpz2zNXaWGBW3z4+frBztHeDVS5
	eJVSU+rInhJ/Gzo86jjxKXvPAfQk9NQP4kpq9ww/HnL6ol7p9XH8XHhmvmM+P3ny5IW1l1PNU9s
	19V7OKZOUYFfRnWXuOvtsvWa+i7JuagJWaWfLGa1Blqcj0Rn0U/4FCpTBM8XUkmYhy1bAPAtJ2C
	29FjmZ79+M4RXhoX11l85PBFCBdAjAuoY8/vWKw==
X-Received: by 2002:a05:7022:3f0e:b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1b3b6008f1fmr1053002c88.27.1794261296137;
        Mon, 09 Nov 2026 13:54:56 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm2198408c88.5.2026.11.09.13.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:54:55 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: pmladek@suse.com,
	rostedt@goodmis.org
Cc: andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	keithrteeple@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] lib/vsprintf: Preserve the sign of seconds in %ptSp
Date: Mon,  9 Nov 2026 21:54:45 +0000
Message-ID: <20261109215445.43419-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The documentation defines %ptSp as equivalent to %lld.%09ld, but
timespec64_str() formats tv_sec with default_dec_spec, which does not
have SIGN set. Negative seconds are therefore printed as unsigned
values: {-1, 0} produces "18446744073709551615.000000000" instead of
"-1.000000000".

Negative values can arise from time differences, for example in
fnic_get_stats_data() after the realtime clock steps backwards.

Use a signed decimal printf_spec for the seconds and add printf KUnit
coverage for zero, negative seconds and the signed limits.

Fixes: bccd5937447f ("lib/vsprintf: Add specifier for printing struct timespec64")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Keith Teeple <keithrteeple@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v3:
- Add Cc: stable@vger.kernel.org, as suggested by Andy Shevchenko.
- Collect Reviewed-by and Tested-by tags.
- No code changes.

Previous version:
https://lore.kernel.org/lkml/20261021110628.37106-1-dennylin0707@gmail.com/

Changes in v2:
- Add default_signed_dec_spec with an explicit field_width of -1, as
  suggested by Andy Shevchenko, and use it for the %ptSp seconds.
- Keep the test cases unchanged.

 lib/tests/printf_kunit.c | 15 +++++++++++++++
 lib/vsprintf.c           |  9 ++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index eccf041ebd56..3bd5115c2eab 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -572,6 +572,21 @@ time_and_date(struct kunit *kunittest)
 
 	test("2019-01-04T15:32:23.011235813", "%ptS", &ts);
 	test("1546615943.011235813", "%ptSp", &ts);
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = 0;
+	test("0.000000000", "%ptSp", &ts);
+
+	ts.tv_sec = -1;
+	test("-1.000000000", "%ptSp", &ts);
+	test("1969-12-31T23:59:59.000000000", "%ptS", &ts);
+	ts.tv_nsec = 999999999;
+	test("-1.999999999", "%ptSp", &ts);
+
+	ts.tv_sec = S64_MIN;
+	test("-9223372036854775808.999999999", "%ptSp", &ts);
+	ts.tv_sec = S64_MAX;
+	test("9223372036854775807.999999999", "%ptSp", &ts);
 }
 
 static void
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1d95ab9314bf..50b99ec091a1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1028,6 +1028,13 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
+static const struct printf_spec default_signed_dec_spec = {
+	.base = 10,
+	.field_width = -1,
+	.precision = -1,
+	.flags = SIGN,
+};
+
 static const struct printf_spec default_dec02_spec = {
 	.base = 10,
 	.field_width = 2,
@@ -1998,7 +2005,7 @@ char *timespec64_str(char *buf, char *end, const struct timespec64 *ts,
 	};
 
 	if (fmt[2] == 'p')
-		buf = number(buf, end, ts->tv_sec, default_dec_spec);
+		buf = number(buf, end, ts->tv_sec, default_signed_dec_spec);
 	else
 		buf = time64_str(buf, end, ts->tv_sec, spec, fmt);
 	if (buf < end)
-- 
2.43.0
