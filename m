Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472364;
	b=s6svddpoB0ELCNcZxgp7RToQU9MlKXnfwG6KDNPmSCMSrHmXSt6eERJDmiYQUotVUYYs
	 nDupYDawaJM2mXJl3PJ8WyRtjaE7yD5fOlKITTZEMSdZLsECzAarWZ5+5NaGUVbO4/56y
	 7xEc2JDHnOyeSsxJUjmezJC22Up4qLAY2i1swBz+A752Jd/T6vxHKK060y/3LmZY0dZqU
	 NqA/E75g1CG1E1dK/F6lr2w2xM7WVLsgPRIkCx8cc5a+GGRupDqu1b85xRuAnrhc0ekW2
	 JuLcP8+284obTME3ScbLPIpwLRR+O3b6FTI6NoI9qDVkdZnL7Ql0hF73YEarCEAv+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cjsfp48Pnf1bsrpQc+K3ZsbWCxCfx2EiZa2l2xPTrvs=;
	b=t1m4yVf2AhZRlraNj6RVgZNug0vkyr8xvr7NLKvhOkeoOJ7RmjYWd+mQhKxIT+s09Dtr
	 2M9aWGLuxc3boFkCwmNHOPkBenB12mHMiKVfnvmk/lOlzNVpBghLSDkslq5afrkv7eab+
	 XX69uhEntHMpEiXhHerwCQdXiotNKK5NjeP5+ZY/lPJy3Xu+ZLe9i/GdUUgY2+Xr73deR
	 XY2dC1Nw2kBXNxF+f4XCKuRX5p9V6GquAEfuS9B7XY/W9ZqOPtKfYbffTF9/pvYI91Lsr
	 M5J9GxrXRUSU2JxtH20QK43/G/SxynVGY99TYrFXGUHHXSwleG1we/8zc0EHLmedOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHMVlYrv;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36503606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36503606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHMVlYrv
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso3261875eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472363; x=1795077163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjsfp48Pnf1bsrpQc+K3ZsbWCxCfx2EiZa2l2xPTrvs=;
        b=oHMVlYrv6rowtUwNj9J4yGgThZ7A7Uh2x8f6h7sUDsVcrURPZYV4G5AYHfB6em+pIE
         oDVKZjv0tjqmquIcpyIadHmBVmD96b6kaWCZUqpsCYPAPt7xt2eV5Jr3kFoyYK5XsClO
         qRZAl7gEhrgyMWcnWCuh8EG+8YbDIwfL187WJLZMfZjspp0B8MmW7GGGcCbyHdS9HwtE
         UosHWlqPt7OO80VOac7vkckpxnqtaPTTzQLI51V7itAJ0ueIeSGAi00Ayzw3l7oI+qEe
         HVhBLf1wYPTt4o8w4r+TA03Sxmwzb+5dNzYVBlJS953oQ6VGnA2a9G0N4+6zaWTvbp/L
         WZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472363; x=1795077163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjsfp48Pnf1bsrpQc+K3ZsbWCxCfx2EiZa2l2xPTrvs=;
        b=o0+hnMEaENH6VMjjcqfbwMKVQdrFPIblk1XtamNHGxwPzf40fV/bNO8LExxmoF9fhb
         xruoLx6GcT2/S9Pi6k6/0TkQwwlhHr+CF/ZxIYjKPnKChVWb0U1SKCo9LIjMc6iVlc7k
         JsvV17vhmNtK8k2kiyphBZ97Lcdk6ZYLHdB5067fQnF0fdumx7o2PiZ5y1DmuoU/Frtg
         Blr0+lthXIyoPZlbCcyotnjFsXpgdZnIEDBWXUlOAOIJSfDFHOethxsJGuxXPWKP0sc5
         DrAhdH5/hjdVBUjbxWaSK0dVC/g97PjcY5GUO2LsZNxQy9fEehgsyaJvX4e26oRN/58w
         t5Qg==
X-Gm-Message-State: APuU4Z9q4fYaNaEHM/DdQ/JSTHJkJyL+06I/XR226hpP5r9SZnsplOVu
	u7GegG7FPlGTkpgCLqdJdZoE++0kruG+LKHWFZE/ew9jf4IHM7hhlYfdBdQmVgBQgY8V+Q==
X-Gm-Gg: AYBFou3Nlspo2tRfAFZD+/TYl3ZhGIDKuHOEVl7wHa1qYD85Avx4T8sOoFcDuFmy4UO
	X4/ZBo0ROvdpB5ipqFJ6RGzSgff/7kbgDNkWmwvMNH2+J5oI1lrKbl0xZwjIXjF7mpZzDTGw7XL
	VqJ/OO3NbOORhPRRiRydbGXLk4CrROhtIpgup4llY7LQy1tYLG5NcL7GeUiq/oewuZ4jTH25hud
	Zp9gAkhiz/rCrQV9r3jFKtQW9HPTbVC1TN5SG2LKoRbzms3uJx4Mv1pU+amu1PM28tuOiXYNhry
	9G4xSbyiUJmBJLmTTuNIJ3wC4ywfaOWSprZ2gjM6niRO1hZPHdeVQrXt4k7OFudHkuPRka0iBK2
	1MANUPoiA+NkEV4P2OJnzflYLuWO6XwCPKU1px1aDmV2EX1/HtUCQvJmRoyQHfert1GGkLs3Z1W
	mFfWCmYJwr62RYqmTqdOMzU3O4yGtFaVlcTRnbwkKe3WWLavjZtM9WlS5rgIoLkiKUX9f6Sj+s6
	uRIsET1FGUXXlJ5g39msxHeCEylOJrRS0mtArNl7guBYgwf3BYHi5dDD+x3ROEsXmif27FJHLFH
	w1dq72p58F4gZ7gJfzHJLF8ycP6DCbRQU3ZLhSFlPYys+PElnXClj7qK+2/4H1jnAAIFKjD5zSL
	50BhAFglxzRy2UR8riZ+9boMO5l2ZOuymPncwEQ==
X-Received: by 2002:a05:7300:fd05:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-37685a88bb0mr6796537eec.9.1794472363234;
        Thu, 12 Nov 2026 00:32:43 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm26507989eec.21.2026.11.12.00.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:32:42 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Gregory Price <gourry@gourry.net>,
	Matthew Wilcox <willy@infradead.org>,
	Stefan Roesch <shr@devkernel.io>
Subject: [PATCH 6.6.y] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Thu, 12 Nov 2026 08:32:29 +0000
Message-ID: <20261112083229.6130-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109201207-failed-6.6-9597c2056e05@kernel.org>
References: <20261109201207-failed-6.6-9597c2056e05@kernel.org>
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

[ Upstream commit 9597c2056e05bd79df9d343a9b42e84a54de1c52 ]

The ratios used by __wb_calc_thresh() are scaled to parts per million, but
the threshold and ratio operands are unsigned long.  On 32-bit kernels,
their multiplication can wrap before the result is assigned to u64.

For example, with a threshold of 25600 pages and the default maximum ratio
of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.  The shared
threshold and minimum share calculations can overflow in the same way,
producing incorrect per-writeback dirty limits.

Use a u64 threshold for the three ratio multiplications and div_u64() to
retain the existing division order and rounding.

In 6.6, __wb_calc_thresh() gets the threshold from dtc->thresh and
has no freerun adjustment here. Widen the local threshold and compute
the maximum share once for the existing clamp.

Link: https://lore.kernel.org/20261021060654.27855-1-dennylin0707@gmail.com
Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: <stable@vger.kernel.org>
---
 mm/page-writeback.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e7a7233..1364383 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -883,8 +883,9 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
 static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
-	unsigned long thresh = dtc->thresh;
+	u64 thresh = dtc->thresh;
 	u64 wb_thresh;
+	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
@@ -894,15 +895,17 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64(thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
-	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
-		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64(thresh * wb_min_ratio, 100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64(thresh * wb_max_ratio, 100 * BDI_RATIO_SCALE);
+	if (wb_thresh > wb_max_thresh)
+		wb_thresh = wb_max_thresh;
 
 	return wb_thresh;
 }
-- 
2.50.1 (Apple Git-155)

