Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097246;
	b=gRyfrB9MWFIvZYddJAZBbUxUwKMCwwHArTjw3NMmot3tzho05ndLXBb3tUYEPuwSvUJG
	 aYFyt+ZD+IlnESOzWw8hGVoYfXe7AgRDdY7d6Ebwk5FgYUkritLa4JfX0kMVCdP2vmgvA
	 wxmlz4iu191kFvuLC6E/Ih8EufDC4xQvtFjOWf96pCopAWbuEw+Beh54VfxmHnY1uzKvJ
	 +uItXgzJ7NhgQNwFFIP9NIAai18tZWPnoYhiVFI+z49aNPLa2nrFm22ylkLYi2jHI24rc
	 218qKL8x31cxD8yMdqYcmyt02lexIpbnZFfJ7Iqu8SdgJ7DHfJ+Ge2pYChTsVS34QVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097246;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zyHYjA31DuZghusM7MkgZ6KjeW0zjBMsh+d7uw7Mm2M=;
	b=bKLrFcA1uSe28lS8qh2/sKDXR9VCm+jkIa/hHdxh1Ml7egDuJB70EgTaN8l9YCUfpixL
	 AgPzthq0UOFwB/bYiculZOW8pm3C+70XNkhz+3H8SkbTWmrSjYEh9uKVr2Dq8rBLXO/Ic
	 Cy7u25PIWuHwDwucAxt4D7xOi7IZlV5DV8wu6DTr+klxSJTkyrmle1+6b0Ngmg79MSy42
	 cnSfsGiztdnTmz1P4JeXEUmnYxKY9TzXGongIRZ/V7KVbZ+1fdSwTLe14e/9SckX7KV3Q
	 agCa7Bd6T9wqVv9m+gB8DJdIGzunJsGLb6LImHTsdweoHK1j7y7Hb7BoX7nrM0/wsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=geanix.com;
	spf=pass smtp.mailfrom=geanix.com;
	dkim=pass header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=6+RbfjSH;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8F606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E8F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=6+RbfjSH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1793097243; x=1793356443;
	bh=zyHYjA31DuZghusM7MkgZ6KjeW0zjBMsh+d7uw7Mm2M=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=6+RbfjSHHdiTH/anRCtv3qs6gdsd1xsMxOVe0F3lL+9bYw0z+8PO+t7LmGYEiaF+u
	 8LafM1y4ke11kk4HIuV10Dr6Zk1kAlniDcsskPser6fSDgdGeqK6a8iHTEY7p1h7Hh
	 sldENg3yp4kKkLKkJDaTaKQwB5oWYce1N1Kv4kGecQIXwSCcvzzJ1uzXeDsxDkaVKH
	 Td7d6ANYeoyHOEnkuj5oDYV9LdqwzHvFz7/AZlkjdxdyUUbo9yTNIkbWfch7Wwh/rV
	 OPW25cMjrZ6zRUhLTcxj7Wak2AtebejcHwRKoXzEgzRiH0KAHk4px+e7VmBEXC0xV2
	 I2lozUh2fwQRw==
X-Pm-Submission-Id: 4jDRgG545jz1DF5K
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 27 Oct 2026 11:33:50 +0100
Subject: [PATCH v5 2/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
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
Message-Id: <20261027-nwl-dsi-fixes-v5-2-b6d1d3d2d356@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=1511;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=rOPluOxC/V700cj1dVNGgWn0UwFTiiAxYBj8sDkXCYM=;
 b=4f/VGKcGhGs1kYzfd5vgr1hlVTxhmoTClXmJz2lkDPw2itdPOFLH7aK5mPOdpCmbeujbvh5LT
 mfmgJsz5F6pATbEW8Edh2FtPywqeEf4lpWXJ56/mJCfy0yS1XW3rVNl
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When using DCSS with NWL, overriding the mode flags to enforce active high
sync is preventing the use of active low with downstream bridges, such as
ti-sn65dsi83, which will not see such mode flags set by the panel.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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
2.56.0

