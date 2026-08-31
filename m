Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803741B362
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182889; cv=none; b=IPH1GzLdAaKZDhD535zqHLKgoGvXOWcWyAUIk1wBbyByPhOPPS+7aD2/NgmcI+FZoXLgWPWCWQgOWGWEBfHkJ5voKibodHk+tYBVpDlzz8ZKM2GWZzLRloTSzD2PNS5Zw/xrVgxXFSsUcP7fg32vTZ0CfQrvi5FGgzPq2+X/REY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182889; c=relaxed/simple;
	bh=ag01qXAa2aIW3dSq2m0vudZwjm5eb/Q95y5o2MKYx18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAWgC16wUwZ22iDD+wQRb0GbddNQOA+t4o4AS+oa2y7zcjCH/o1sC54DejtcQ2lwwkA04XZgUzY/2k8a4GSOSl1vhrMON5fDujUG0C/OSP2sBC5lUpQuLIMBUkkjX1KaTzlEoArymzJ/T2JgDrmVj3F+CbjL9Dk2l3Czl0YCasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=15Anndom; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="15Anndom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788182883; x=1788442083;
	bh=a5dpSaLKghfNIm4oSZMav4+4dz7CwzYx+GQqHJE+ad8=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=15AnndomcQFJjI+63GmKI7hnFfJg8BKCE5mCs9tIEIGW6Fn9+AkeAB8mcjeOG7pmg
	 SDWZcw8triAo+lur3/PgKL9BngIO6gkrtQ6VVL5LzhipEvvgn2wGl9+Uznohx4/dks
	 HkZXqlCzL4TOHZ45SWdjblAkBOIpDSA3eCuLWAMXYqbstVQ3EAYzi9v+IXWe1SaACR
	 PxlR8NTAY6tXKj/Bctz0mQp2WgKyxQkJ1PEa5rJCrPsejLhjSMklZhlLLM6FW6hh69
	 H6U41nIeeTi2gl7iz3Gaz3pqeCdN0vauqU+7S9vUq23NBg85irR9RndJ2ezJ7j9rWZ
	 SGKN4fv7lesNg==
X-Pm-Submission-Id: 4hYVDK60C3z2ScPH
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 15:27:44 +0200
Subject: [PATCH v4 2/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nwl-dsi-fixes-v4-2-6a2a1cb23910@geanix.com>
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788182874; l=1455;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ag01qXAa2aIW3dSq2m0vudZwjm5eb/Q95y5o2MKYx18=;
 b=6jJFi+dt9uiYSGDebCufHHjPIhcbOINyJPUGDfpXKjz0h3IVZ0FRbMU7RBVTy8rlHQRktqGOG
 WP3woXbTAZKAdjsRYGJEDJ4pDm7Ooh3niy82qejff+aJVwJCYP/Rjgc
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When using DCSS with NWL, overriding the mode flags to enforce active high
sync is preventing the use of active low with downstream bridges, such as
ti-sn65dsi83, which will not see such mode flags set by the panel.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 80e26a947ae6..1aab46e1a168 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -823,10 +823,13 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 
 	/* At least LCDIF + NWL needs active high sync */
-	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	if (dsi->endpoint == NWL_DSI_ENDPOINT_LCDIF) {
+		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
+		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	}
 
 	/*
 	 * Do a full modeset if crtc_state->active is changed to be true.

-- 
2.55.0

