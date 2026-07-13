Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E931414DEF
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947956; cv=none; b=RobsXCYXDjagEEsM0VSxO7Zm7JbQ1fbrpXSwk7jpo1ivASS3J/ep00DASevJq/13rfiBtZxzkcF2KALrRddI9FwhL4WSLTdoMa1/eBXXeeUJ+8rBrvHA21Egud2uopaYK3qp/8w/rxP4lUsaXeKkqfWtK+1MJHMlla/XnQpUSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947956; c=relaxed/simple;
	bh=FtnknuqUHzlJVSz5DKvAQlnk/GzeCzKCShgoXUtLKYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyxNgEHaTqhOwqM1p9qJzMx4t9OgxaQyT4DDYF9CupL/8t6FJPOxY/+X8o3xTC2wFefm0osP8z5Dp3lPFNts88PaAsxAT7GFwd5lDyaXbVM582MaIgawFNWTdVXGIK0U05+wJAzEzI7W0UcbmPPENvayVqR2vWesF+TDPuFQ4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gmJMNhF0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gmJMNhF0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1663821f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947953; x=1784552753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UH5mcedIpIiZlH9zrS1BV7uvFaa9p7I+Dq7Nzg++u6k=;
        b=gmJMNhF0L4T1eiXPGKWMkSCEnshbF828m7t+8yD/Q4kaLhDXSD/Y/HdUcLsqNpC+vm
         fICNwkkmmM+Z3sasDeiZC5exJAggoQP3FTWYf22ZihuGi8piS2CRZb0AkZN0Hl1G7orr
         6IbHMD64565T35KkOWeIeV/8oxnbgBfQ2kMO6woJLR0pNZPcHLCsMmmtGUwmbDGojTQr
         RE/NW1djMR/H06AKoSyHNVM1OafQUZd+haOXxut4+T4DtE2sCSP3clA3MyYnV07DwQAD
         gm6K8vYsON9EvNIJ2nXVH+kCa/yglw8eUXLzRfOw6lXi+0bv4/CCem/8Ol1M0hLWmkvZ
         3DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947953; x=1784552753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UH5mcedIpIiZlH9zrS1BV7uvFaa9p7I+Dq7Nzg++u6k=;
        b=Uylup/aJI1dcALT6ZLiVs0408DduWUdj56THFiQqDaG+YSRzWbjW0k5G8ptVQvIgIQ
         FTDqQgVqLephHeK6B+lt7jjdgh/1I/ew4qBngrTImOPCms6v1mbv6/t44kWll54zdIjI
         Kt08/akY33DrIuRcsyaRXJJuuWeM8ON+nd4AmmbVBoZCAdJFR3NrJ9YzwseKsaQwrEcy
         g9h5enZDlnUEsgRroYG+XpRKuoZP93fOmtokatMKA9LU0VvtxB74s/hEDEpo045ASatt
         oAXnCZfT0O9hC0wkKiMADvmt80kWV/XfHpmO+ModNWe8hPiclfpqOTNnO6cXsBJUAPXt
         d3Rw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8TXJ8gcI8zzDLj6MM1F9aptkn21mUIXeOjAGMraPurCl7KP7B8pO1KQ830Eo4RSIsLEUh72I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JAKWqPLGEcc3+CUC3V21EGvG/BoVjp4v6FUGegEa6mhvgxRe
	2PWvIfj5D8VzmZYelEdhN/8De6QVbqf0r1SU3K7GZhouf1ScsHMQSlEl0XiD2IyQ+8g=
X-Gm-Gg: AfdE7cnFVVxh7+3mQLDzybT7PcwrADHGrmA7X8bfmjqzVWqxJT+wvuYVq5xvITBt85n
	Mawv4KJ+WtgboPxZOB9jplm2T1YY2HvLQDvPPiJtsToaBfgb5CWylCXIV+wU1XmYbOJYCYEXZDW
	pu2GyG9sl+u+7MFE89jL0CfEkSJsh6MCd9QFHh60Jl5dzvEveluTFDbdLF0jG7u3gV48pTyUfXr
	DTj0DPzTBiiw+GkHtGqJXinQdK052ML4wWXFBvdobw4DyJpJbbrkyPs6chIJcZmmcguDYcSQX5b
	/YCrB+GQBJdzdq7miB6BTt6Hv4/ytuEZv+Jzv93zkloH3ASztBGcHia+CtOMcgBM13jjQrrsXnJ
	Q9K0PO0yVWsZkV4yMpOKC8AAHnqZ7p6s1Cr+dJpm3DZrh7wyIF95UpVV24//Al5DmT3Tqd5OId5
	hPxUzrkHkN+YZ6Ve6aFF+yQVRw3/stuExdGoiNo8dCBt6SEgl+DsLav+CUhgB27TPRugVircw=
X-Received: by 2002:a05:6000:2209:b0:47e:4b03:1aac with SMTP id ffacd0b85a97d-47f2dcc657bmr9421634f8f.38.1783947952926;
        Mon, 13 Jul 2026 06:05:52 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:52 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/17] i3c: renesas: Restore STDBR and EXTBR registers on resume
Date: Mon, 13 Jul 2026 16:05:30 +0300
Message-ID: <20260713130545.568657-3-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving state where power to the most
SoC componentes (including I3C) is lost.

The STDBR and EXTBR are configured in initialization phase though the
struct i3c_master_controller_ops::bus_init. Set them on resume function
as well to keep the same state of the controller after a suspend with
power loss and a similar initialization sequence as in bus_init.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 38b8428f464c..cd9928649c7f 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -260,6 +260,7 @@ struct renesas_i3c {
 	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	u32 extbr;
 	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
@@ -622,10 +623,9 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 
 	/* Extended Bit Rate setting */
-	renesas_writel(i3c->regs, EXTBR, EXTBR_EBRLO(od_low_ticks) |
-					   EXTBR_EBRHO(od_high_ticks) |
-					   EXTBR_EBRLP(pp_low_ticks) |
-					   EXTBR_EBRHP(pp_high_ticks));
+	i3c->extbr = EXTBR_EBRLO(od_low_ticks) | EXTBR_EBRHO(od_high_ticks) |
+		     EXTBR_EBRLP(pp_low_ticks) | EXTBR_EBRHP(pp_high_ticks);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
 	i3c->refclk_div = cks;
@@ -1468,6 +1468,8 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 		goto err_tresetn;
 
 	/* Re-store I3C registers value. */
+	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 	renesas_writel(i3c->regs, REFCKCTL,
 		       REFCKCTL_IREFCKS(i3c->refclk_div));
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
-- 
2.43.0

