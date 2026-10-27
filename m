Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097248;
	b=gZDsSmTUpIvbKso92V2u5Ruk22m04+nGwfGjNFd2EgmKc1Cyh7lRzkaNqi/x5QX9YUal
	 MqQQ6+0WBK0vB7gPGNlwx3FF/+lJU8gPEBfguILuA9G7SsFsogRzfIxVjxJzSeV+GcBFa
	 B3Lcdn50MFbyqLXCJQcV1s5kk8sVMbP1vPHBum9hcScsb+el1BS4axtpS8l8Qh+ooVXe0
	 x+2/GBdO9SRpwed5CaZZbTEsVCXaZCX+pM74ParMWmJNcLaEb3DDuiLppe4U6g3SzVpGx
	 RzkTvyWOlACjLAac+vf40C14el8KgpPBoJTLpgwi0NSZF9NGPSwuJLS74C6QuxFnFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097248;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=us8BejSqm23f1XiVi6u4hYhzTsLDP4QrbvXIptfxO2Q=;
	b=B9BxPLwbY6ag25gsht8w1mw7awRtHCFXeAGf0RNS1zTLu74loh5X3GNNfE/pOESSGUzO
	 ZpGWP3Ym0G386Madbmkr/G8xF26LGvgAfR8N/2rdCLmyCTp22P6Brvi4d6r6DUzPOCk60
	 JqySHYuSeGMfISUyUMEO0vWnOLp7QSMLQ89MtIVRXS5ADZTM6tjjJ/E0TYMh3fX5c47ww
	 0UJqL+5Py8LfjeCqZMwejidGbKMURbzUD+7PLB8rqEiqc7JmWYHqOLRZmT9g6lNXKpZvQ
	 6ZEZnYkPXPDQWAaJ2b9oOp39o0nK0OTiwcVL+ChttC0yJimSCR0fWPqOz8AzIqRhEMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=geanix.com;
	spf=pass smtp.mailfrom=geanix.com;
	dkim=pass header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=j9ZZ6HDv;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248A606A336
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C248A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=j9ZZ6HDv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1793097243; x=1793356443;
	bh=us8BejSqm23f1XiVi6u4hYhzTsLDP4QrbvXIptfxO2Q=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j9ZZ6HDvXwl1foSL69wYRexgjt/bNm3P3q6dvEn41zONgqUFMezB0DaUjbPKrIKiy
	 X7x5mB9fAq1lNqI+T8vPOzK3cHHuImYU9OfZu86/JoDkR742wS5qpsIDQB+pb/NYqw
	 tsUkLbvABUf2JZ5bRof3VoE+OcCkARnmdvPwABt1Hl4WIkHBqRN++4IOZM6f6usLSj
	 HRV3uV/RRdqpZuJNkHv8M2YwCH0edfR35RlcY+7MjgN0t28CDNG207g3dGwO04RgU7
	 kNyAgddDMU23vgFUCutpV86YPFyVKtelLZ/qewqj1SYlTh9nEb4ha6st0T70DX5+Qq
	 vOgIAtc+bNfYg==
X-Pm-Submission-Id: 4jDRgF01Krz1DDL5
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 27 Oct 2026 11:33:49 +0100
Subject: [PATCH v5 1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux control
 selection
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
Message-Id: <20261027-nwl-dsi-fixes-v5-1-b6d1d3d2d356@geanix.com>
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
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=2014;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=VnH57TThUBRrumoSPfKBCfwJnaCqBhJHzReWomjxIyg=;
 b=s9TGh/ZHoHRMHwymoA20d9octH3ejlqVZegcU3KUsBU8oHweo/2ifOA4E13qs5EmDh0a8xUzI
 RplCPUCCvn2BJSTpg5oL6JwWQnZJSN9u+ynxxVm1KSJoWthPMdBD2B8
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Using the endpoint define values makes it more clear that the argument to
mux_control_try_select() must be valid state integers, and not something
that looks like a boolean.

The endpoint value is kept, as it will be used in a following patch that
changes behavior slightly based on which endpoint is selected.

Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 09992529f3d8..80e26a947ae6 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -110,6 +110,8 @@ struct nwl_dsi {
 	int error;
 
 	struct nwl_dsi_transfer *xfer;
+
+	unsigned int endpoint;
 };
 
 static const struct regmap_config nwl_dsi_regmap_config = {
@@ -1088,13 +1090,12 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 static int nwl_dsi_select_input(struct nwl_dsi *dsi)
 {
 	struct device_node *remote;
-	u32 use_dcss = 1;
 	int ret;
 
 	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
 					  NWL_DSI_ENDPOINT_LCDIF);
 	if (remote) {
-		use_dcss = 0;
+		dsi->endpoint = NWL_DSI_ENDPOINT_LCDIF;
 	} else {
 		remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
 						  NWL_DSI_ENDPOINT_DCSS);
@@ -1103,11 +1104,12 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
 				      "No valid input endpoint found\n");
 			return -EINVAL;
 		}
+		dsi->endpoint = NWL_DSI_ENDPOINT_DCSS;
 	}
 
 	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
-		     (use_dcss) ? "DCSS" : "LCDIF");
-	ret = mux_control_try_select(dsi->mux, use_dcss);
+		     (dsi->endpoint == NWL_DSI_ENDPOINT_DCSS) ? "DCSS" : "LCDIF");
+	ret = mux_control_try_select(dsi->mux, dsi->endpoint);
 	if (ret < 0)
 		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
 

-- 
2.56.0

