Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE939CCF3;
	Mon, 10 Aug 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346091; cv=none; b=fIjieRMqmOquP4m7jJcWqTO+SmAn1jlTGudFwEbEeurVq4hIujgV9s7TgnOnepsmQ7LzED7+eKX/bw8iZEy1MfcfQeVz3TeKcS0X1YD+XFynWo0E+PJHaIpfPpiUOPxqntxxAmQB0qi7niiYxRBs7KcBW6mf5PIugFvnMBzTieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346091; c=relaxed/simple;
	bh=XW6AnJUPIJ/6p17ZYvKjmVPpSue826KCAQU2igzRdEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jThY/mUy6P7Xk4E/ce0ofzCt7kF+qqT2OXLNW54FB1eOHR4dHAt6BYUzZuM2PMMa2NiR4/kQUu8MKAU9FB/GJvqKwQK9dCWYQDbFvDGpUNpWMex6+ILl2E3Izyc62tqDAqp4UVVlyDT/QXs1ZO6rMnENnbJBK2B7X4sZ3FvlMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=eQ7s87up; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="eQ7s87up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346087; x=1786605287;
	bh=HryS5wCyVQBONoxwWZjTDlJMAM0CO2Fw/WwlMf9O2pA=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eQ7s87upq72BO9ABZzY8+s9zWPsFO0L9jEjn8xHOekwqizh4+FDbRupfUnYSQeFST
	 GTR4d+yn34+t2n9mFEPZofRfzBnw9S1dP/iXWbtNWzjR0vfA8xae/O831HKZqtF1A/
	 Csoz9CpOcYbT4ZjqtLw8R+T1ACqWmBqPoEtoJQl5NjF2VrmylZ5f1ZwplsF//Jetec
	 5W2H8x6T4TGAiWjLzBa7QAriaBx6rYeuY1Oz2+fRMIHeewTUObT9b792vKRUCF7W+q
	 hmWM2E1YI4lNn/8fWHo8pYdMQFBunClhKuDQHunMD7zv0hZwvw90C54wFcc1XL1wuR
	 nxsiX4NyxL8Lw==
X-Pm-Submission-Id: 4hJQxK14jhz1DDLf
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:14:37 +0200
Subject: [PATCH v3 1/5] drm/bridge: nwl-dsi: Cleanup endpoint mux control
 selection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-nwl-dsi-fixes-v3-1-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
In-Reply-To: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
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
 Sam Ravnborg <sam@ravnborg.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346082; l=1958;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=XW6AnJUPIJ/6p17ZYvKjmVPpSue826KCAQU2igzRdEQ=;
 b=3611Z1XItbb5fq1kQSZa2gaINsGs3P0Q01dLmrM6v+hjI+QGBnul+gB5W2mTPu0i7h9nwRh82
 HeiDpiWUDm6AFt4PjHYMV25g/W1fVjkazSJe0cEUsWDeutXeSa4jL1l
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Using the endpoint define values makes it more clear that the argument to
mux_control_try_select() must be valid state integers, and not something
that looks like a boolean.

The endpoint value is kept, as it will be used in a following patch that
changes behavior slightly based on which endpoint is selected.

Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 3c9ae93c4f67..39be58cf5bd2 100644
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
2.55.0

