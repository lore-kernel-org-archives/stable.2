Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792862822;
	b=SwxUwv+sF6DB0r1QyQWXZFEJ6lRs9K0JZrqeVSBKQ7/Zkie+MQIT0X2e4lgot1CaGoBR
	 97Iwhqjnv6OUvrjXuHMxwoCpR3Si3yrNsSoTuUCejO6p0lJhJiBrW0/zu7WWraJJZkWO/
	 AN8PjxSYFZWluicTy/9Uas7PqSAQn42MkT6PD61CZBZNV+O7cx+CYYi4i91VCPW4d2fe6
	 xLPIRQU9QkbJTQBL6e7O4x0kbkLYRLL2u6r3CPU7dssqvkoI2hiN0icUbe5V6gP71foXg
	 XDz9nH9xa2Pbv1Hpoju5tIkOjjHzQ0kY1SpwFVKFrwVIU6Ra6ucO8GxFc0s8Pkjl5jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kEYtLwxZwrV359NviA74b+mH4aeRVHvNjyPhEsl/qZ8=;
	b=PazA2mP53NjthsKKVQLrcA7uiqa5C/0WGEEaSvxgnoVPx41LJdnaJAsSUlFaEbjZfaSd
	 jgKzauduRzXTPVoRNskrvqmDim7iXa317qcAaEdXqpmdaTah2KYHuGQs2Iw3bXougtrDz
	 5vBBqDQPhLlwjxx25TG45xzmpHHZh5nxmbHlHo64GxAvZdOq2y13rklGbx83QxCfS5kR0
	 NH+DUEJtlz5fYiVwn7jtDcXlIv9Sj5O3jhHBAs4RtB5UwKF1pO164ihYk+OZuFNIuLUe0
	 X6B+6L6P5g1UiVEYM5dKluWOO6HD1LZu8/ji2/NdcuuW9cvIzMu+wsTVz5EEhNczobw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SLGzCCFX;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41414606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 17:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41414606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SLGzCCFX
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso13813455e9.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862820; x=1793467620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEYtLwxZwrV359NviA74b+mH4aeRVHvNjyPhEsl/qZ8=;
        b=SLGzCCFXwEzIPp0HYrwFsmH1nScgGkoGYiTu2ZDnCmgW1A76aweYx34KZTSjMDJ677
         luC7x5od955083hP9Iiu49BX3y5ihxgWXuQO042HOd79UUdV0zmTm6YFyw6lqeJZvGhe
         BAjA0qfFBKYZqZiK96CR+v0g942HSiEKj5tpP1WNgRXIPcCuh20/VClnVLR7tZK1ANpR
         XQzFGeqmJoRUF8rvDYC+gBqzSqb11ErCI91seBMYrlEysiZh8MF5YxNKrt5V/5vH+Ud4
         FI7FrJhahEx1wQI/KW2P4x3JlDqTyhWv8a2vJROBw8ouoGWnNpg57LSWvTK6wDVMUiZj
         i1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862820; x=1793467620;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kEYtLwxZwrV359NviA74b+mH4aeRVHvNjyPhEsl/qZ8=;
        b=CyAvWYXm4Xk5Ou7Ky9YpMiAMNLAwIDAkvdT8IVqH9TFAQsc+iI9Mt68/Slwn12QAcn
         ajmQp1HiUHNy+ivwBiZT89453woM8h7H15N2UTYzl3W5A1iDdMEWc27qAfdU+vDNu6nz
         EhTlulhDf3ygKm7ncFkoRYYNEaY1jX8xgp21OF8hj7GINTLWVOMDmgWjZSC2yB4a6LpC
         H+s+vtB+rN5s5DpiFRAxwWEufa+oPfGVUEG+nW/z6XFcrmDQJZqJFtDfQ0ZZv+boY6E6
         MS8ubwhkqVBtkLfwMj71aWNOto9AdlRJeYZGyWk+N6Q+cMYNEqdxsW4rLEDxgaFCAdR6
         9NUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiFYKWfuSEg1iqGu2Ylx6os5PIjlBujDHeYfQCKL/4vdfVVLb0RxMt6sWd47MhFpwfHuWKzBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNEG9MN7nVGa8HGQ0SYplYdh4vdxcnutUuG6hW6Zu6AekxLveD
	s3Blwj+eAx9Ey/oJb8bdWwmYOKPEdo5fGBq9KHJ7GUviNudba3/WhwSY
X-Gm-Gg: AYBFou00LPU9biXECfOHuLJEeFDD1lrlUEMqaQ2bT6JKD4ZGUK3YedRWQAQbKBr9ymc
	R4ZNGYSktGCfJVGQv7XZ45PJbawEcf7VAkgH6MGC0JsrNStxQEeej7R5Pwz2eZSIsZL0evn+NZn
	x2+hTsyfUXDd3j0kbCa5+hRf/dWKxte6EWeCL/yxWdKfo5zMEG/RWZe+zuTjnWTtd5zdmeHZX9y
	dHi8hyxk+UmOQTz3hy8rSAg07rB3BL8SSQ8feycNsbdATZ502I2WYCTGx4R+OZauOko0HRY1sUw
	2xJ0WgJTGOcKkLIVI4oOBVF31B0TBgZlAOI/sEl+oM3uv0GOvev3kvpkFfrIl/NTsTkIY9oR8TD
	215OssVvfMDB52e84nRuTQOMV0J0jegDxvTBSSqcVOiQiVjXDL0jZMh/etimW0KtfQ7uxi6wbyX
	EI69RqHq7Ng65K9qIL4mrs6G+dhuTZQdLBN3qHHty5hoc9qfvwXE1EcseIpQ51kxR1ykaxXREk1
	EjLdKVmrhTTevvDR1eNfDlBYOXwZKesB4Yty3V4j7i9nJpqLwsGn0TJQVrH6MgfC4vmtlCXjaVI
	3h8Mpmi62mXperfeWMXl1O4kShQL2vUn
X-Received: by 2002:a05:600c:c173:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4a35ac8bbd5mr40436765e9.11.1792862819430;
        Sat, 24 Oct 2026 10:26:59 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm52573855e9.1.2026.10.24.10.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:26:59 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	meatuni001@gmail.com
Subject: [PATCH v7] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
Date: Sat, 24 Oct 2026 22:26:41 +0500
Message-ID: <20261024172641.19424-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The input is copied with kstrdup(), which stops at the first NUL, but
the full write size is passed to hp_enforce_single_line_input(). With
an embedded NUL the helper reads, and can write one byte, past the
copy. Use strnchrnul() so the scan stops at the first NUL, and return
-EINVAL for a NUL or newline before the last byte.

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
followed by 4093 bytes of "B" to current_password 100 times returns
-EINVAL every time, without reading into the heap.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v7:
 - Use strnchrnul() instead of a separate NUL check (Andy)
 - Drop the trailing comments

Changes in v6:
 - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)

Changes in v5:
 - Limit the scan to the string instead of copying the input past its
   first NUL (Ilpo)

v6: https://lore.kernel.org/all/20261016025352.230535-1-meatuni001@gmail.com/
v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gmail.com/

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 876fc35d035b..8873d91bc235 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -162,12 +162,12 @@ int hp_enforce_single_line_input(char *buf, size_t count)
 {
 	char *p;
 
-	p = memchr(buf, '\n', count);
+	p = strnchrnul(buf, count, '\n');
 
 	if (p == buf + count - 1)
-		*p = '\0'; /* strip trailing newline */
-	else if (p)
-		return -EINVAL;  /* enforce single line input */
+		*p = '\0';
+	else if (p < buf + count - 1)
+		return -EINVAL;
 
 	return 0;
 }

base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
-- 
2.56.0

