Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266030;
	b=KybG+u7A2QOx1kHIaSADoCiYt5s9wWTUPPfMEuWQfP66LN8qrexTlFmrTphkWr+EHirC
	 bt/2NmdZMAac/yJOa/FzUMZ5ir492075tXwIvMl38c0lDYHlfC1k28aYFCYAVUWfB+k7A
	 KiwWyvvr62wzZaxzbHR0rP0clQP0/4jak32hr01WkC444LT8f+kxxpNPM5MaW+1nLTt6V
	 4o7DjfpO3pbeGc+087RxAX4MiuAhuIAWJTXSN7Xfy5tF+mJQ/raXdHUdhevh8i5dwLJQ+
	 kJq5yFkC121fJ6Aauh6/4OKonFC7hoy8iTeCHNT5w2uUxmEyc9oWBBL8YKJivSEApNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A9FjoSRUuYCt7r0RaoeRKyy0JIV1W5v7GkSoINLVED8=;
	b=ZxjTwEFgElR8wC/vFeEIpqXodCsDm011u6qN+DFG9cnEIhrsRkqgT/78U0lf6VGnodzT
	 4QFkaHqGMFgEMNI7WEw7bjpOLrIX4Rg9ivAzmKvukeQYXSqieoTj8JrdUr5hjwsbgTxnH
	 GE3vxTd1asoptc8ZUJ6twoPWK6lNet8Ywrk7HhFWX18HKefjZO3kkSt9CD4s+lf1o+HZL
	 rgyLsrIYKUygfVx7g6Jhhb8cBBPomRcnGDdO9B4mMSkpB4u1oPWVP62W1t2DY3r2Hf9pN
	 lim7smTGt62EXHXhIMu4d9Q4Arpd1JQ6rTM9OzlgoJZFnRn7xVtTkYoL9UeEZSEFqVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwCnGxyM;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E96606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E96606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwCnGxyM
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso790008c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794266029; x=1794870829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9FjoSRUuYCt7r0RaoeRKyy0JIV1W5v7GkSoINLVED8=;
        b=LwCnGxyMkn/RI5XC9YqLhWFQPoVLF0Bo3UJ+pAH/G/StF4gRzIAJzC+GfENZazD11t
         cJ6ZYNzhcicD/crMsDcU3LmmDEwBatMrCabchZr/olyhOsZ5Ji0aWWI4OjrQWhwQ5vKG
         PqdwL9E/mGzPS/mV5o1hwJeZ4EWh+226dqP4+Zi4PGINhrRku3okBKHnQPrCypyol3Vv
         8E6LafTadJxo9Qh9eBGhQnsuvDR0UFuEHF9YQbJNLbEjfvQ6arEHjLdR6HaMyS7Uzm9x
         OYV7lkFJS2Ny1jM8v26qZRAVkmyqtBaVvMA7Bkabw5RuUjP1forX7GJNPAJC7a36TMC7
         SBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794266029; x=1794870829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9FjoSRUuYCt7r0RaoeRKyy0JIV1W5v7GkSoINLVED8=;
        b=cCjLk+ZI3Pmc6mmtCsnlJevpTE0vu6qEn8AFfAx9ZkHDdhuK3bc7a/lc63vrWr+YBi
         kxO528/LjZY7LAgsTAMtX7fOyetsWdQA4d9g+xul9RZB38GZv0boUdTUGqa3S2c/MAWA
         WZQFkUDr62l8cp8+Yflxsok9plW2fsdWLLv8ZSIUC8LCMGlG85MzyNmjG6vTUrLWQb5A
         /e1hD4TvjeNT1jtrpqNogI4J7RAGU6YzvWb3/wPlKhGKmAeuJO+B49unG9mLFTExFRP0
         758NaT/5kBcX6wXhpGmdc+f1ObGkuUS66czudABwYI9CJybMnaJhQL6neaMbJkqOU96l
         uUAA==
X-Gm-Message-State: APuU4Z+BpamYlAuYyKE8ISCS3bVHCQH8+4Vezpow/h8s6UuXaDc1zm6Q
	WdKr3D//wy6vO5nsaMiNGNZIhHVIGaqA++R30Cneb3Y5QpPq1/9OyQQJIwO3vbSOTOmw0Q==
X-Gm-Gg: AYBFou3AjY3MJhEAStGlRBU+opw3+bL88yQr+aY7/SVMt2GX1r4cB9kQQbmqzCwEYJb
	qqgVxK/kABKnJ88V326fJGILLNOySsgQ9A/A7o69IwKNhmhrPFgWVYdNltesvmvzZXIzoWgdCJo
	2BXzDheAwAhpu6cdV5kk4mgXuma5hZmaRl/qGxId7YBXHFjkVHvDCwrgiAIhcp0JGPdEuICR2PU
	UuCu3jpj+CvOAUf7NSZCSTIS+/lJyqrlehG3FN/w5afF/l5PHGFYo+d985DsfuzBBD6tEOTU0gl
	OdMCGTsuF1ZfeE+IHtxgJww5eAzinlsE0YxiBzuQ+eCDl+mfoIsdQToXOhFQdcibtaHEMfm7epj
	WBBMh8Iyxt20+RBP9K77gJtzJJgxmrIeax3nPXh7pdpZNpVqbkbraDvxfGMZ8itYqP7OLgkozNn
	PTILndXHrnu09Omuf6YgDoR7hsZdbOsk7+74n1bFUCR/xRRYgGtymPwOiJ9MNgpcQWJSg9w/GOm
	TfjprVGhwMK4qt7AAQ6P4CIBz7D2RketxyKQWxLZvcUZDTNh9hDmL7f4y5b9C18+VW6+xem8/mw
	llmK+/W3X3XW7Q4yHIWeD3SH19QqAQbBfayqQ1S5jySgd77T+ITAjsDxPRyHbg1fV1KdZ5T/v/v
	Revoxrsuepnl83A9lcgjzYIaxLEJABa3Rtw7BNg==
X-Received: by 2002:a05:701b:2710:b0:195:1a77:85cb with SMTP id a92af1059eb24-1b3b5fa29bdmr1009570c88.1.1794266028753;
        Mon, 09 Nov 2026 15:13:48 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm2424909c88.7.2026.11.09.15.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:13:48 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH 6.1.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 23:13:35 +0000
Message-ID: <20261109231335.37106-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107055501-failed-6.1-5b819071e434@kernel.org>
References: <20261107055501-failed-6.1-5b819071e434@kernel.org>
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

[ Upstream commit 5b819071e4346256c4edbae5cc2095dff25694fc ]

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/settime/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
Applies cleanly to v6.1.192 (c75b0cf0982c) without changing the
upstream code diff. Built with GCC 13.3.0 and W=1.

QEMU, CONFIG_POSIX_TIMERS=n, uid=65534:
  x86_64 native + i386 time32/time64 syscalls
  Before: 159 passed, 9 failed (supported clocks with NULL output)
  After:  168 passed, 0 failed

 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8..b2bb38e78520 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -117,7 +117,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -211,7 +211,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.43.0
