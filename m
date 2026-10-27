Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097248;
	b=2d6jVt1xjkmH3sJ03KcI/9LxNcRRcSrsF2IqCTx44xfVx+LcTgPsEdi0FhWF4nGzeUF8
	 ZyV+qtGMXvYdpk4jPzOZVz3w2briDdXGbDg+6TdDcnWIRH61GpgKZzjeVslvxHUbTe931
	 8X2ZfmiMpPrKbMsJTF6m0rI9wxywXFcP/oyYpMP62nfFfA39/cUDl2kk2DN8dIT2rBYrY
	 RsfG2/SXgjpmvluCzByyPD2STG/X0FzYvVDazwIVGl0kRxmIUTzd4l4r4E1idP27lZ/ML
	 1zYYuUS6YGHgca9fTpBGUpOFgK8TlZRF7bzheBZgUZNuDG432/1myfUUrDZl2jdf8qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097248;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=T176+OvwvKvZgAEn2v+P3j6cUnFW/lZ5GLsddWW5L4U=;
	b=u5DTUbHLwcMcqgGWZdSQBnK4e6eKnmaprbhz5R3wb/Df2CCokiKasF5YlRf7tLK+q4XH
	 dNUsK1QsMrVtbWLAc5Lf313asTAfA7GPOcOzIXe0mGbmj1KeKuTRfG4zd0c73OLb9Kmas
	 CPCbFF6T85vbBCyVxu5b71ycfGRbPnpeRh2oUTKb/Eo2d79dTHBdUsK21inWRpTAl6/fr
	 3FSrSZLlzXWJi2c3ddBb1fQJCBjAT3aMz57XGo3qTfnsu7Bq7ESE8DhRcA/6rz5wFxrmk
	 pADZtUii/I1YPO+5UTlHK8HmWWwJkrSLFUpdG/+JhSbtZGHiwdI0JIObc174nrgxsHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=geanix.com;
	spf=pass smtp.mailfrom=geanix.com;
	dkim=pass header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=7itOupAM;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01E606A338
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD01E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=7itOupAM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1793097245; x=1793356445;
	bh=T176+OvwvKvZgAEn2v+P3j6cUnFW/lZ5GLsddWW5L4U=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=7itOupAMUcxqkJILsYqoVzKT8KKx88ikEK1ji/LJotx2hhcKLQ7oL7NfSbeP+bTkd
	 OJ7pmGMp8GjZAracMEkmIKhpzkRpJOu5S+/3Oz6mcguXQJidkRwn82Cmn71X41wFnV
	 A+CPDpCKF2fFcaOkZ1wpLps5+bqH+MkdcT/mzycjlvZz5X22kRI28tSEfUIhpfQ4wH
	 On4PrLNpkM4rIs3nHi0RUvn0UC8qT9R47PBOIOC8KD9hnjCjnzEfOzHCnJOmaSh9K1
	 lgofgDQ+1KWYEKbBiDq0NU4u8WZdrT/fW4h2zPBygRVGEjIh9o3I8ci9OxGW3eoJ+e
	 dT6JfJyvj13uA==
X-Pm-Submission-Id: 4jDRgJ3HB8z1DDLJ
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 27 Oct 2026 11:33:51 +0100
Subject: [PATCH v5 3/4] drm/bridge: nwl-dsi: Correct auto-insert EOTP
 behavior
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
Message-Id: <20261027-nwl-dsi-fixes-v5-3-b6d1d3d2d356@geanix.com>
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev
Cc: Esben Haabendal <esben@geanix.com>, Frank.Li@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=1590;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=QlvLZtjTIgZL2y9CCm+bmOOwdBUYqFKSP3naY4aW3IU=;
 b=bd3/w0z63fAKN8QGoZ/aazNwAx94N/dDnUKp9lmjrCeYbN0wS84fWTnFZF/aXxCxVkwlpnYs6
 PfYNre8+4j3AYyWSH4brF6FQrUtMowhZZl/4hRlpQbvWcL3m7CdrBH2
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

From: Robert Chiras <robert.chiras@nxp.com>

In order to respect the DSI protocol, make sure that auto-insert EOTP is
enabled according to the NO_EOT_PACKET flag instead of the
CLOCK_NON_CONTINUOUS flag.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 1aab46e1a168..f3f4334136c0 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -222,13 +222,15 @@ static int nwl_dsi_config_host(struct nwl_dsi *dsi)
 	DRM_DEV_DEBUG_DRIVER(dsi->dev, "DSI Lanes %d\n", dsi->lanes);
 	nwl_dsi_write(dsi, NWL_DSI_CFG_NUM_LANES, dsi->lanes - 1);
 
-	if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
+	if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x01);
-		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x01);
-	} else {
+	else
 		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x00);
+
+	if (dsi->dsi_mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x00);
-	}
+	else
+		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x01);
 
 	/* values in byte clock cycles */
 	cycles = ui2bc(cfg->clk_pre);

-- 
2.56.0

