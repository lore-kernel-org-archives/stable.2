Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537680;
	b=oWoE1I7KLkeKDr9VzRU3R/VpSgRJ85vQg93EMzBLWa21ddy4SuKs6SDtXD7xfuhzbkcy
	 CVEQ7g190rwY8NHCkuxGwBLjw/hF78/OLKQUq5Xo2TyoQT/g8fUSJCylHzL3dcfH0MO7X
	 SH0KFfT/Bz7iyNQ+BDnXiOVCXHyjhG6iNEwBQzJ3JY15QWxppxYnqxNfYiD+d+amgmkpK
	 Zb2r+dtahqTu1TJC1Aak1sAuPOLLk6LzipROFyWqpjUzLm4lgpGaMnrR1ZCxs01Z3rxKr
	 UQOqRUFRTDZJI1hPla/xjBQefHJsEOlhZpq0qxJoy3lAMS8vTlzj2nb4ZVmOVd9Weyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4tT5hFpzZAr8Rid5tP1O0Sqf7A6ODSsu5SatFU1cn9o=;
	b=tc8Mdn2bAXt1nYkTqBwDCB/qAPfu0eQx1iIK6OnGvfEO/pYRbYH4iabod9iLc0Cyr03k
	 JfY0COj0p3yBQ/Rx4+XTsbgXKDzv4N4gq0y7Cn83PyMiB8yQsFHl9xtMkcA14rUnd8bkL
	 0071AbgOcdanquJhg3Ni782KnsoacyJB1+av59PwUHX9CoNzfoN/WmwoA7mhUVqdNJqKi
	 mOUjRWcOA/NjCAzAkwE82Yy54/TtHg/FyfKFz3neCYxt5jGynLLXwPtGZbz1ZWC9/gEgJ
	 InTKLb0q3AmeQ9HkSBnai2lFmZNQ1h6CnvtuLc95qzFmmd19/uN7HyY3X+9FPokXwpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeUaleQE;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44471606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44471606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeUaleQE
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-372cba0ecf9so55896eec.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537679; x=1795142479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tT5hFpzZAr8Rid5tP1O0Sqf7A6ODSsu5SatFU1cn9o=;
        b=EeUaleQEga7fpxbRgo28RXvo5vCKpzkxGoUsRH2DYUHMnsNYm7LaPG8m/oax6Di4ds
         RaArJAMT6xGYP6qran537lNL7jTjpXuEZOXRnBMzu+f9LBGVX12PSQZ0y2cG9hSpbUKX
         kpJT/FGZYt8tTahCaIBmLGqqKDznPoHVAB9Hi7MHW449A5sCsfYhp8Aaf9MO9RUgFQ8C
         uJiXC0EZDteyQ7W+PkKpr3HHguEfY+rTvIio5Gcf+lSGS35rqYoh8Ns5hS9MXJW543z4
         1I3F0rx7MmsayYhN1XicEC3dWJR+rzPwVcJ86VwVVlTZXCz0vXnTsgYY4V7BjBYvRdLL
         L7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537679; x=1795142479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4tT5hFpzZAr8Rid5tP1O0Sqf7A6ODSsu5SatFU1cn9o=;
        b=RefvT3kmXxe1nFvw/3Lz/ewRhIbeHdby8qitC7/tEV8CNSzP6sGH6KbylajrQjGA9M
         u1gLxcIKHxQVPaaTywKG7yZ2/WCAGrVVYVJcgZITl7wjd1CfP7D0Ft3rHDTWH/aZYADo
         QKcJsn7TmVvV+fsQKElP+uA8rZrDvsHxuxJotsbaMNzEzTXPQZ7JQxDhduNMnCVMnkPR
         BLOpJ+HwHWpMK/e7fSfdeptGaRPmi4mGj4yAaOsKAmLZydVBNl2aJz3PSjrGZl1JhgeH
         TpwzvY/c3ehYexenbIFLbK3SJxd/K5Sibg77I6qdta3rZpi9Zzqcz3kJHsbBK3CNT9Ql
         QGXw==
X-Forwarded-Encrypted: i=1; AL+hErGfS9qySS0xSZOHoKf6pAof0Hlc2DrfE7O2KHpReCXnUJ1I8kJOf5s2yStbpOYuNaXH+s0qGGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tJ1q9mvr8ILW+4ceftn5Lt6/zTIAk1otzt8YD9XfWygyo5q7h
	wnJecaaGeiv+oi81BNiUyOIkkZ41RJI1kCqBvoTmYTNv6DPOSuQSVZzU
X-Gm-Gg: AYBFou0TrZabSCh20/hiq53fvdYZwXPs2N8B8E01LXpVYR8psr4rlaPeD3BhAaPqBg2
	rSxGPO1LKN7odhjaRrcKEiEg0qQ6XdGeMdbZ7BNZIeHLlTt/EgMOsDV0du80R2yDmdjKjzFxLfg
	xtNx9bWQ9QDzNc3s7Yh/Gczz84QV/x5fpMa5y71Cap9bAU7Ly9zLUGSpelLUTw4//eYI+41wpL7
	U+kCIcihva8jVYkG2fZyGsc7eosSXrnB5JN1rSpZB77kuyAZVDQ7xNAh+nV2nKffRY1qR7o35VZ
	eQa6Y0e3wWvwyHci9koyaEPQuqsSFiTHsQAg48nCp98S8HvfWltWdGNfxwzzbMeczzt0gORCix1
	FuuzDxAZf+huJrCPjOfVtPpCllAwyVqfmfqAFh5JsPn2nSTWpJSCRGPyiXaensmWuz0rjEraqRt
	x2a1Ij/e1EcOf+wKdQbcGJzGDVRK5mWuqUrN1q24JFXOo1adrtaAKi0ZlN9q786iR7/4Skq9vby
	tNHeqCErjm9ReqwyYRP/c/fCZ3i4LlPZluHl9ZrSFkyzxrbMV1VCx/3vXiYzG/BkvPyxGl/ZN0e
	+O1pauUglZtOqY6PT8hjziPa2IlQB3LvDdUUeSTXMQ6MSSu0HQjMxGdSxUUGuZAZ9a7UyExE0CB
	yC9xpRKzrwLytfvpzRuTZ8DiQJSDluM8CxEZB3LR61+CY41PGsHQgqidmIeMj6awId+r+zWBjEt
	TKfP0Su1A/XQ==
X-Received: by 2002:a05:693c:881c:10b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-379655d503emr1470847eec.2.1794537679252;
        Thu, 12 Nov 2026 18:41:19 -0800 (PST)
Received: from esteban.tail1178e6.ts.net ([240b:c020:623:52c6::44d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm2334704eec.22.2026.11.12.18.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:41:18 -0800 (PST)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/9] media: i2c: ov7251: Use in-range PLL1 dividers for the 319.2 MHz link
Date: Fri, 13 Nov 2026 11:40:51 +0900
Message-ID: <20261113024059.1087031-2-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113024059.1087031-1-antoine.pichot@gmail.com>
References: <20261113024059.1087031-1-antoine.pichot@gmail.com>
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

The 19.2 MHz PLL1 table for the 319.2 MHz link frequency puts a
pre-divider of 1 before the multiplier of 133 and a divider of 4 after
it, so the PLL1 multiplier output (the VCO) runs at 19.2 x 133 =
2553.6 MHz before being divided down to 638.4 MHz. The OV7750/OV7251
datasheet (rev 2.12, table 2-11) limits it to 300 to 800 MHz.

Use pre-divider 4 (register 0x30B4 = 0x04) and divider 1 (0x30B1 =
0x01). The multiplier output is then 4.8 x 133 = 638.4 MHz, inside the
range, and the MIPI clock stays 638.4 Mbps, so the link frequency does
not change. The Windows driver programs these values for the Surface
Book 2's Windows Hello mode.

On ACPI systems this table has been unreachable since it was added,
because ov7251_check_hwcfg() selects the wrong index. The next patch
fixes the index, so the two must go in together. With the index fix
alone, D. Manresa's Surface Pro 7+ (IPU6) had CSI-2 errors in 7 of 10
150-frame runs, 3 of them stalls; with this change 0 of 13. A Surface
Book 2 (IPU3) streams clean with either table. Dave Stevenson measured
on a 24 MHz Raspberry Pi board that the out-of-range tables miss their
nominal frequency and proposed the same values [1]. The 24 MHz tables
have problems of their own and are left to a separate change.

Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
Cc: stable@vger.kernel.org
Reported-by: D. Manresa <dmanresa@gmail.com>
Closes: https://lore.kernel.org/linux-media/6ae0e944.b6db0abd.16b13d.d261@mx.google.com/
Link: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/ [1]
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/media/i2c/ov7251.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index fce6344b5120..f429de5f1f7c 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -174,9 +174,9 @@ static const struct ov7251_pll1_cfg ov7251_pll1_cfg_19_2_mhz_240_mhz = {
 };
 
 static const struct ov7251_pll1_cfg ov7251_pll1_cfg_19_2_mhz_319_2_mhz = {
-	.pre_div = 0x01,
+	.pre_div = 0x04,
 	.mult = 0x85,
-	.div = 0x04,
+	.div = 0x01,
 	.pix_div = 0x0a,
 	.mipi_div = 0x05,
 };
-- 
2.56.0

