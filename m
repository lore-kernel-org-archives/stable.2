Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868801;
	b=yrQ29MVR1b44pIpuoHCpqtrlq/c+fg12aAOMErsaNfoYu27TKD7cX8WrrrQzlttqUefI
	 5hj3mjEBvx+K6DIszju4RHybIS7xbM3wCxnCb2EMhn4w+mGpe+5OP+sGz0PKZaOzCqpkk
	 iq4TohiaOI6E6W5lp6wKWon3K6xl80P4nrL+bGaBpdIW6Mc/ml7VmejsbRWXM1/LW+L4Z
	 nNxeORwJTZlfVuUt9rCKWl6jK0ii6pZcZOctAhEACjaqEXkx7eogewB50v4WVQuJNkwRf
	 dwECmlNJPZD60l0EdQRUueYVQQMlJaq8ox3sBxnlh2SBt0f99o1I6K1fT+H0bxHaBOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868801;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=QC5j2xRESRmSD7obottAudidFpaX/mHq2OWq+o7sIlY=;
	b=EBeZ4xNqNIgl5OO6DB6b3pjPoCjk7PU3Ha8SFO7BTr9/tMJLLNpTG8sUIjQgqAVI2eI4
	 YF9oJ23YUXik3c+Zg7xdGEcKT9SiSHg2s4u3nFOSQ2kI1rfTv/or0fkxj53pQv8vLxwn+
	 /1DOqLOcYqQww6iyxw/yDGNF6Xxh1qFzXQEONrrHE+vSTl2Mo8ZhbmPPGXqubiyRVEVFn
	 WrZRhv61XBD8Eg/NeybQm0le910MIWCopkHjhFlO+iuiHyfeSOFvih9h+4OjmN6kRwY6i
	 oCDHdOFPvY1l58VaXBmuYonAV7pvXZydDPJ56+MMcPxBWdXhozqEwk2M7GfDpsZ6Plw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xgQpdWAl;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195E606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6195E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xgQpdWAl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 788341A07CE;
	Thu,  5 Nov 2026 08:53:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D4FF5FF85;
	Thu,  5 Nov 2026 08:53:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C220103291D2;
	Thu,  5 Nov 2026 09:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793868794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QC5j2xRESRmSD7obottAudidFpaX/mHq2OWq+o7sIlY=;
	b=xgQpdWAldL0yJrgVGT1AnGzu1XNvzgdid4qdl7D9S3poXSwZ+1xXuvxVEJDKHf+30d4gi1
	jfIEKILjzdFPA1DkuZMvQdeZI2TLkw5w99flejhGSpT9PHWna1nwLpFhUFy5Z/NcvK5Wma
	891zzHR+JkOvKtWirxgpOnQwdkkv3CpRDOTmHl1E8EDvTjQIUlbqZwuL49B0Pjp5FNasCd
	+u9DXnZ9VoKPzeMLgu447oUgwyq0RoSui0BxNQb7+bKAh2yPSYr+qYCVYDg8cbxowRlD9D
	Pf1RY+KNEgpz758Q/l8DzyjAyUtRDowJ2DbDMGDT+wPyaxb5FyvC8vVZtg2QMg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 05 Nov 2026 09:52:46 +0100
Subject: [PATCH v2] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
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
Message-Id: <20261105-drm-ite-it66121-fix-reset-v2-1-02039d66af29@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6CMBCGr0Jm7ZhOkUJceQ/DAsogY4SathIN4
 e4WvIDL738uENgLBzhnC3ieJYibEuhDBnZophujdIlBK21IUYGdH1FikqMxpAl7eaPnwBF7Kk2
 RF1VTGQOp//SczH37Wv84vNo727gNbolBQnT+s5/PtOX++ZkJCU9lrvKKlWlae2mdiw+ZjtaNU
 K/r+gVqH0dd1gAAAA==
X-Change-ID: 20261015-drm-ite-it66121-fix-reset-f1765358a866
To: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Julien Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
rightfully added code to make the reset pin really work instead of being a
no-op, but that change introduced a regression making probe fail most of
the times, at least on some hardware.

On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of the
times. This is because:

 1. the regmap_read() calls just after it66121_hw_reset() to read the ID
    registers fail
 2. there is no error checking for these regmap_read(), execution
    continues silently
 3. this results in not matching any of the IDs from it66xx_chip_info
 4. and this results in silently returning -ENODEV

Empirical tests showed a small delay after de-asserting reset fixes
probing. Likely the device needs some ramp-up time after reset. No such
requirement is mentioned in the docs I could find, so the amount of delay
was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting a
20 ms delay should provide a safe margin.

Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
Cc: stable@vger.kernel.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Add comment
- Link to v1: https://patch.msgid.link/20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com
---
Changes in v2:
- add comment (Javier)

FYI For items 2 and 4 above, I'm sending separate patches to make those
errors not silent [0]. Those aren't fixes, so they would be for
drm-misc-next, while this patch is for drm-misc-fixes.

[0] https://lore.kernel.org/r/20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index c8d0a26e8e90..f00cbe477a78 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -357,6 +357,8 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
 	gpiod_set_value(ctx->gpio_reset, 1);
 	msleep(20);
 	gpiod_set_value(ctx->gpio_reset, 0);
+	/* Post-reset delay not specified, value found by testing */
+	msleep(20);
 }
 
 static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)

---
base-commit: 0720532355207f2014a98b650d19497cbe3b22f5
change-id: 20261015-drm-ite-it66121-fix-reset-f1765358a866

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

