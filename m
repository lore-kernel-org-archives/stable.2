Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093411;
	b=ZxRePQHK+4xHSdQwXI9kT29HQzsE/34WVORH0QuS74D/nAWvCz+aY+mw8V3bmVAEiEGu
	 LsZsn1SC3Bx5Fdih5vae8jEaAaeXxVR97mUCOxA5kju5g/qeDm7JtHzsKjPu7sjdOxUTK
	 aJqdgt/63AlSBePpVHOsBwVGpPy57MlkzTY6k0g0ffgS45NurBIvOTSC2f3ywDN/y7Pp/
	 4aBOJPTJqV23eEv7BTi5+beJG2bUVaK7UUoC6gW0g22BdxoTF3RBx1vNFTCDMpsiXQ0IC
	 dWRJQOoxCSyS/qjIM2DrkwVA2I5071wSx4LsLMEIYYmhflTl7ak+UHTFLv51C7ttoXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093411;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=RpawNIw9yAx80KIG8/kBzHZTgdYAQ0IhqamwU5wRPCI=;
	b=A+xPO5S8w/qM6yc6i/hHU0lW5AZZrNWgqBlW59hmWkewvEoCnGR4Jh7smJGhSTeHE27V
	 X1sq4OmM8OiMR2llQNunh/wu7QR0ykAaVmAJKROSt09x2IYEcJSaULotidPsOsClCNsyd
	 3aSfVnlOazcpm+E8VkDXOmwPi3xtbw+b4MtTAEJaoe/XRS+23KLC7a+Mu7h2rQ+4yiPLS
	 9FN8E0CY733d6yIrG5UVGRXeDYcmlkuldFaHxA+xm+oWh2c32cs+i8rNybDMmIyOGXT+l
	 ioj1FdkRupSfA/gqy7M2tmy6NZL7mUwT6Tieggpq6JrszwnjV5NMg4O0kVWvTuQ8sfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YrBIz4wI;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CC606A32C;
	Thu, 19 Nov 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454CC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YrBIz4wI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=9PQMVUYfYF7x/nSmY/FPXefEDmGs/HYntr+IZiJGrQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YrBIz4wIA4pRMrXD4Hj5oay89kGrIg42GFOO4PILPIaJ3N2W9LlZT3d3KiNw4RR1G
	 tvdvpCzCaEHcAN58rXVwTnWpDO2RNAyGmOGKW4kekLLRt/+3rrNKs7tJ3RiLOHD27B
	 hygPoxd3ba22XTRb8Qm95j2La2Kr2zNJW9rvNRRYwicR7Yh7D3QBaLSQV9wEiAk7oy
	 CSYfOuS3x8i+DuY+0CuFjeQRnZTVpPTt6nFbvtfGWrJcfxhh8ARROx/GFsYpEdZ5b/
	 1SFEbA06eIUJ6SmPhvcqqBjr4GWC6tytUYviiBG8RyMK4IX+yXDMnCe+8CW004EEQg
	 HoRwI/LnWbNeA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D9FFE17E0DF7;
	Thu, 19 Nov 2026 14:03:22 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 949B0480035; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:54 +0100
Subject: [PATCH v4 04/11] PM / devfreq: rockchip-dfi: initialize dmc_count
 structs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-4-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=9PQMVUYfYF7x/nSmY/FPXefEDmGs/HYntr+IZiJGrQc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85rnCdSDgKRt9nBPjJaSrfjYvi3P/ZLXg
 HBOwc0ccpKM6IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaxmQP/2O3MwYsmbEvJytAyN2xNDwYhb07PfNvi4DRo4CYTiQbvWE4VDt9cBZN/tCbsya16E6
 ZF1B7Oo0LqpoYQfgDsqqXkhzI+WAvZ/Kq6D2gs3aj8mlIegHLmKsrmsYj5kbQ13tzn9+838UkGD
 BRP4D9IXXt953ia+/7uuvsvjjEO0pGxWhlhAY+IObjxXHRPsuu2ET25nXsCHtnkYr1icRbpaB6c
 uFxAShCExcfn61sh/BOTyuTWORoby3y5S6ES1jJ3C5qxl2jvJL3qprC15NG3Il0SH3uw16UPAUr
 WUE5+NlFhqSKMORXJA0in2ZQdkM0qbodAYitZPzNN5a3s2ShgGnBHUEgSRd5GBB2yv80n0GNINf
 XeZ3qH3kqtysEWtRnYTcgu1taQ5/SwDJu05fS0ymmFeRIxCH8J+4BPqGzUNOZonPOhPO/kYNAXP
 OPi63c9ci3UoMm4TFUypQbXT3HiO7KljzEvlsRUxSxDs/C5EODI+a3zqkUT2oI6zz4Xxca2GS4u
 HLBRtN/Wt5m2ATbBXXBoRjkPJyCOysNO1tSJD9EHGcNXn1jkMcFb5Tu4aNFXLotXv3zCQi+u21v
 11jEo0fSFZpjw9ipUyN0z/sADoxreg8+Y1IcwoacuAAJRfzbZWcBRVx4uiCSFqM17Yds1vhw+wA
 6HZqfgUlBQ1RS4sJ8/LQxjw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Initialize 'struct dmc_count' before filling it with data by
rockchip_dfi_read_counters() or rockchip_ddr_perf_counters_add()
to avoid exposing uninitialized memory for unused channels.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-219117@kernel.org/
Cc: stable@vger.kernel.org
Fixes: 4d586b5724d3 ("PM / devfreq: rockchip-dfi: Add perf support")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22f82cb6e33f..d195755448e1 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -291,7 +291,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 				  struct devfreq_event_data *edata)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
-	struct dmc_count count;
+	struct dmc_count count = {};
 	struct dmc_count *last = &dfi->last_event_count;
 	u32 access = 0, clock_cycles = 0;
 	int i;
@@ -462,7 +462,7 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
 {
 	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
 	int blen = dfi->burst_len;
-	struct dmc_count total, now;
+	struct dmc_count total = {}, now = {};
 	unsigned int seq;
 	u64 count = 0;
 	int i;
@@ -577,7 +577,7 @@ static void rockchip_ddr_perf_event_del(struct perf_event *event, int flags)
 static enum hrtimer_restart rockchip_dfi_timer(struct hrtimer *timer)
 {
 	struct rockchip_dfi *dfi = container_of(timer, struct rockchip_dfi, timer);
-	struct dmc_count now, total;
+	struct dmc_count now = {}, total = {};
 
 	rockchip_dfi_read_counters(dfi, &now);
 

-- 
2.53.0

