Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCB39DBF4
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346094; cv=none; b=kLx4ahT30vvm0OiHCa1AtJ6rddMbNDGjDdXqZfgaiUQm00+9eIg21Ki2zhd+/QHq2FcvHrIOBCOd41IJ+iFBEPZ/NJib3qKim6wY0bIKDi4Qrpgg4/S6lC3Ukgf6QTX0hTvSjawIbk8QJRYvgXdgmsxoiN0oq5gi9AjAA6hMS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346094; c=relaxed/simple;
	bh=ybpHHip3mJEGeNkHM6B8y6xjeCgFvYd0piX0R4XK18g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l92EhjO7Z9EKofhRKAgGycF5HJKMiYdbVnWMcccBp38cmkPXh5G5Mpwo8ulaHoz9imyVEwx0NRew/BpqnDiNAfXecZ/vrnSA5Ws3zBEpecMwB9hP2Hg+LP2R0JHpwtN/7WT+zoYLQp6JS0bzyZh3n4I/+ptKH6C6ccaKhWgCOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OmeTkIQd; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OmeTkIQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346089; x=1786605289;
	bh=JQQ9TMEugEucDHVTnXkrZEPpBuBBfgLOHL8udwc85/M=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OmeTkIQdVjIEFLfJawa7Gx4rs5CPYVQLx+0lKlR0rPar4ySPvE15GSXAu2X3UTGXf
	 dlQCngkmxva+9utziFSaQIYCh2u6AVGxQ60gG4NIQFZG0PlveKWilA/W1QrKpQgFmF
	 HBuZ9he7gyT5p4Oo7+7xbxOChPZlWmPo7MagDCWtvPOcd5Oc1oQIZqATf2W9rz7m4r
	 07a8MmK6g84QPfoBzZ0g23rJ9lwKFjFFkiwsaheRXOSPZxjdJHEimzQiR7L40MhmEC
	 Wf8BNiRHap5BNvmc65v0NziGWwaGqR6p/VToEwaFs2Q/JqTV0xuqa0rbg+E5TJAEvt
	 yWgXMWJKDKUzg==
X-Pm-Submission-Id: 4hJQxM039nz1DDs5
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:14:38 +0200
Subject: [PATCH v3 2/5] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-nwl-dsi-fixes-v3-2-256da9d672e1@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346082; l=1455;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ybpHHip3mJEGeNkHM6B8y6xjeCgFvYd0piX0R4XK18g=;
 b=WHXOY7dEpyBJTO8+q1izP0YvHBMjly2JQsYu8ZWJg7Tmt/GQMzuiUE5SbAh5fBd5DldvInrEQ
 ZEvY0nmm2G1DeFeOgAO5Aa+ouTfhDA1FyFw9wKoPhb9l1N3hb29xmLg
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
index 39be58cf5bd2..374884e76f25 100644
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

