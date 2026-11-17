Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908624;
	b=yA8nFnVZGya70Y2annlao/hy8Ga479D2nVUM4lBqN6LLQIuthxtT21Q8lHw3VyuRwrYu
	 KMoVaRrWw/yXqhDuQNgxXKfdzsuTAsUhMoTYbaVbHPRILVh289EtWS3Fb8+SmJPyKKw2k
	 8DFqDdvReZrC5+Klu6hW6DCjw657n3QlYcUakpRIcfAAeJWDfR0fPNmoYbbC780TGHguu
	 W/fA5LLBZif9dNra4D9M1DNEp6ee1Hpa7XRQULvR8ueoX0rRUDLX/pp8MQQXe2LFYagKS
	 LvyVpfpS0XU/TgmN5+wJ2h8jgM/6LbOdgE88kGuCExm1O2V+xlWlSW0HgR44Xt6fAMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
	b=smpyJv7Aqw7ujmOw7NAqmVcjLPuXrx8vpCUV6cwidYKfGvSwFop/z1pHYNN8Y2QVESKW
	 Upp97j0Y5IckJ0ETEh2U3nEMuVQo0O/RgQO8h68Pk0K1hu1f4KM42A4vNt+hOpt7R0Rd7
	 zHWysAWqjDGevNLX0LN0Htm4O+CGVYd1Sx0HvEaJDBkRRVqZQPSqo/DJEZyCinP1Cd1w1
	 LjHjVmO/hU+FxlTkLlV+jH2nZeivu106nXVdqmNob6jd3AVjqmYOBbMwBtpiv72Qb2sHD
	 i9pyqLk2268qRKV2oV8D0ZMAXHnLGGR1VwEcvoloJtiSbmzueeQgrcFUieruDr/FTwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqiS2TPY;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0B606A33A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB0B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqiS2TPY
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so30470365e9.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908623; x=1795513423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
        b=LqiS2TPYuC4gs3tigs/Oyc6Oe9U6Q2gFu3pjNtN6/eMOyueDEjGlXOjlC2dVN6mbdt
         G2hWzLK7kUuvqKMYgn6+rU5lnq7jJn5otxLOSPEA91S3pgn72pFtY8PWW6NqxLvaKuQh
         +XBEH3oNAVE0AumkmV5yG5VyhNYhI4SkxEIRdIqsZ46aBCiy8NiNITxKYqsfQykUpVXx
         dPfAJQ7WFSGqtVkqQkVqINUp6xsAsF/AC0ws19aFLqIU6pzE10ZLrAMHTzV1DawcFcjz
         KUJvoAQ8FLu2JXJFABjfYHFtxQ5xCd4jF7MboJhPChuuAhOKK484yx82LqsiW4Y7G7Yh
         /fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908623; x=1795513423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
        b=nVz6ILaS5h9BgMW89MSgxXeA7ewY1eYB1gtQ/Ei8tg1iLG/Vv3m+g2yn7/G9CuZvcI
         PQXGuaHr8LgzN91uGCf0p1oxV8KTGCgd4S0D6jfMlI1db9mv7JZVBiHz85SO1trhJSpl
         9kRZTUgoUwIFp7ArPX9i64eV79cSVS694O3MVar/hsRryDB4SE5NVQnYZYVQRbYtHydh
         iT29uCbhx3SOcrYgk9cZRjWb8YDpRwJf/sgd9FUDQfA1CKnwYG+tYvX4WmJLsIMg6YWZ
         k4FhTbAliCjlWInRR0HZ99aoiz5Uiit0hfKXTJ52hr7WIbChLO/TVXfZLahvpqzN336S
         8QwQ==
X-Forwarded-Encrypted: i=1; AL+hErFeole48L8YKva4UEcaEuHnjnJyFvynLIsvb9z4zsqDV5RkLsBClQJIvUA4SMiHa/VR9pdtFIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vyMvasUBtYX9AhpbQjc2wGR1A1bUlG4+Tsqoi4d9WcAwNMq8t
	grX1OE00Om0f7aiiqrxUkFhco0r1NVvgti/bFDbKSU0L5HuNCbXxEB4o
X-Gm-Gg: AYBFou2Gu5NOn2Mclep86OsfCtOMJ2WbN0YQxpc8siAZGeQSduYxoHQ2Lnl+w+ZZ9Q2
	Bxl5N6JhDlQqnVy4fvyibmotZRq/XjQ1Fop2HgSNExOZKLUHdcBBzU8tFRC1tswtsR7EGCgilrp
	NH4wbnJFiptFVppZvU3P5KlH3gl/8/liJmVpUwW26glaljk72hlzgOE/F1RD9TdQf6gQy53PTat
	fs6XiMCFtnx49QvfZuL5E52EzwQqOU6k69QCGsdr7J4AezCX8zIgJ8cGYBNbnTwedUFh2zol3u4
	jIMrnZCnRUegPIRrmuEiwtAStCF06QJrVupG/dzCSJGHkicyOsosq5hG3LCMyYTawuvUyoFjZNa
	GPLifC4tePl0qSwBcE4ulJCKLhznXopwS7GxhaIDkAvbwGmgByDGxvkS7D470LHJtzQJWpM7dA5
	dLYzF1VKCJVbXJnR1H7IscVwMmLzNfVuzHU0UILE6YLCrTfIQkM0+qc8fe3ysIqwlf0+grKjOcd
	Wjk/xn0m7TFziRw8fyCz+XntB0dTsTFBt748ZIWbIKtxkE/aphu0Ivgf0deu65G/ALdVRZWQHcf
	hAeTGybv+Iac65K3GoQcI/aD8/k2w6jWNAYNswIt3lz27wz25WMB52UMQnsG2rxs3ARqDPquSGs
	RSBBNmfznx453tWuH777EaYLxw1GTH++XsXo=
X-Received: by 2002:a05:600c:1c0e:b0:4bb:68e5:b952 with SMTP id 5b1f17b1804b1-4bb68e5bb4amr205720385e9.16.1794908622593;
        Tue, 17 Nov 2026 01:43:42 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad96096sm16212925e9.9.2026.11.17.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:43:41 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle time milliseconds
Date: Tue, 17 Nov 2026 09:43:22 +0000
Message-ID: <20261117094339.30978-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

On 32-bit, the region idle time in microseconds is computed in a long
before the division to milliseconds. It wraps once a region has been
idle for about 36 minutes regardless of the intervals, so the cold end
of memory_idle_ms_percentiles reports wrong values with flipped signs.

Do the multiplication in 64 bits and divide with div_s64() so the sign
of recently accessed regions is kept.

Fixes: e5d2585d9e85 ("mm/damon/stat: calculate and expose idle time percentiles")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Ref: https://lore.kernel.org/20261115173343.82437-1-sj@kernel.org
 mm/damon/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 6e05a2b067f2..f2387aee675d 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -130,8 +130,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 		percentile = div64_ul((u64)accounted_bytes * 100, total_sz);
 		while (next_percentile <= percentile)
 			memory_idle_ms_percentiles[next_percentile++] =
-				damon_stat_idletime(region) *
-				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
+				div_s64((s64)damon_stat_idletime(region) *
+				c->attrs.aggr_interval, USEC_PER_MSEC);
 	}
 	kfree(sorted_regions);
 }
-- 
2.55.0

