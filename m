Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B241D4D4;
	Mon, 31 Aug 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182893; cv=none; b=D9AS7KkbJd4yOU0QNlhG2orFIdciubqaozNjxdCX0r6gLcqRH2NFCNuB9Z35ljyZ0gTSZDwjeH1HNsGNtzqV18gE3HbfkRPD1UODxHYj8Xd3tyjbOK2RHNQ9wkMFDXK9YOnvjYBJEeDxs3DvJfaSB/Qau1mngI1V39P8fhxhw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182893; c=relaxed/simple;
	bh=XdjEUinjNT2C3KAlMGkOLvsEZ1P9NxDmJt7rE0Z6cwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwWp2KdOuqCdcDtbeV7hGwbUmuk6hFQNA8U3+8g8QXOYFjCGqM3UpVnBTOoHD6gmqgY6f4ZRH1Z9v/2nGUc2AoXISUEfPBMo8aRD60WizGkehGL8vFt2WYGMS/63XN/haugI2KoVecVEFkahPteSVNtv1mHdMV6+H2SYJrR1DUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=K9Zzub1Z; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="K9Zzub1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788182885; x=1788442085;
	bh=tHnO0TtSJZT3uwTmNJnMjCsYgQ5eOEaHFXCtJEWympU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=K9Zzub1Zv7IOGRfiJhTGBQ17DTzjIBPXUQNAr7NY1lAofHTvNfuq63F+pAm0tGslJ
	 3zRBAYGioljz+tzjdbRNL3ewWRDZrxNVn+HZ4uY3yRXbvwXHE+uMeQ+DPqpfFeF10e
	 yzfOyUYT+AixfJzCBn4B4HXhuLPOzrpQJrP8/E+oyntf+UZuCHPPWcfs1rV8j7rSTy
	 PCiHn7+1hmu0qLBAo6Ozxgrz4BZJRQuXmC65wQ4diPFH9maxaBXXzp3golHOLb/LDm
	 NhW/vWp0C7ykkcD47e3BByZxRZSn0ObXhG0kkGKw3WPuk7EtlwyWyUqTxXawOG9TqN
	 FmeoVmNIkTGSA==
X-Pm-Submission-Id: 4hYVDN0s33z2ScWl
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 15:27:45 +0200
Subject: [PATCH v4 3/4] drm/bridge: nwl-dsi: Correct auto-insert EOTP
 behavior
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nwl-dsi-fixes-v4-3-6a2a1cb23910@geanix.com>
References: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
In-Reply-To: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788182874; l=1534;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=kKsffolI3Qs7QhM0aRcvOCyPsNNcZdkiD1A5b8xHohA=;
 b=J4LsSxC5aITLgDQB/KpUb10mwQ9+TU75DNKgkf9gtJnRagL/g2POMbhlVmoQqvkvItbnynqH2
 i5az424w6E/DhIa1tfFb3tBZQqNqn10NIkJGysG1ivPL90VWoiN3f+5
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

From: Robert Chiras <robert.chiras@nxp.com>

In order to respect the DSI protocol, make sure that auto-insert EOTP is
enabled according to the NO_EOT_PACKET flag instead of the
CLOCK_NON_CONTINUOUS flag.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
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
2.55.0

