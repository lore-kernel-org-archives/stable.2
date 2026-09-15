Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D834FF62
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468508; cv=none; b=s2hvvyBwtxUg40R8TQXAD6e3Zf7VIoMMpXJv2tx0f8JeBrBwY4WK5M6b9yobxKT4NM+Hi42YvJkq7f34Q/Aq+5bs6MB/7tnUckvWafU1e7MQ25bXL6sIZ3ItE7jBWacoQWO1QBDiCxY5gWC7D1JYRi1nTLyidj8mzWKLarb3b88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468508; c=relaxed/simple;
	bh=k5wsIxWZlCCm+zBCiy2Xg9RXJFsK16kuEX6gTF/iiVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gF4Xb5rUwwX4niTQAGql7oFd/DrcLr8gRU52q07tt9qju/LRY/d9RX9M9ICVbb+xj1LxvPqUkrl0m3kiNVpL0GND4KS4zYH4wnOLZ+AeLxHo1COQDhkrWZoAryXZolNuNfY829fxvXBmPsn0IJTVegeYJq3d4Lr0dEorsI/TmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrQiXsRo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrQiXsRo"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d6ff23d81cso3596025ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789468504; x=1790073304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ct/p5G8yFAnha3FVWj3nnL27FNsWn5+Pk7HzweSOSA=;
        b=BrQiXsRotSMlxANC1SPiJ5jTllc49hyLifIa6o95A6YM70m39vFkfIBIt0OO2DSDXh
         kWu7D7xPPkOzpNS/Ajdth2oVTk+cAFK4roDK01ooSfCNNPfFhnezE+dpL8JFXA6sWls7
         qrd5PTwlsHotEdJeCRzA/Ga1nsagrcrk5LaE0ZErnYJ885L3a/96v8OaIWu61WEk0ac3
         8Uh9bO+LdRMYZu30BSvYLQoOOHmGcA0yjYr2Q8goVebzdRd1L3fNleToLlEX5XmDSO9y
         Omp+zefWw1y0WYiFGw/kXGedUYmL+4J+fhVdrDHOkq1ZfYtTzUajNkviZttZZtrvXnog
         Ah6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468504; x=1790073304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ct/p5G8yFAnha3FVWj3nnL27FNsWn5+Pk7HzweSOSA=;
        b=zPc+gHib7H2nTYXW1qumTKFbskPHG6Y2Muepvt6T+u1rETKywnEUUh3xnhguHx14hj
         DqwCHly+JyvUHjB08s5WQTlzQv1bwOw7tmh+lHwr6aGr+w9mDBgYVBmxQXcuYs/rnM3K
         itB3vJoGAlG6HY1rl1IVO7RwRX/NtJrg7MU6KPS54i3A9c/spB0MwZss7symSn0h/oP3
         BXEs1LVqPz8GM8qLK+2+Q06YQBxvULKRL8jDQkBiOJfuOGbZR8vJgcnTzwFHO6q9MGho
         ouuKwvdjEMjJu1ZyqiXB0Mbimce0AYs8tmPrNr9z1k7Oi/+dY5diXzAFNAyZrj3Cf9pY
         OSWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtVkf/C62RXaZdtwYVVn5sV2mFRsNAnbYUouwth8wj/6QM/teA7rpe5B5x3c6kvOBQcemO8F4=@vger.kernel.org
X-Gm-Message-State: AFuF++kL+kghTp+c7C4dI/qq3th2s+1GwriXE3qE9goMHLX7w/xNmf34
	XTR0ZUSyo12tACGVjgmBJ4otNnsXOnq2Yl9gyizhNbcAA/nCnGppWflH
X-Gm-Gg: AYBFou0uiqCGlc2QQ4bnKJyTwI2tEoBGPr+N65RCASBL8JYbSDuzi2q5B+5hZARJMTe
	R2eQR3L40RZv4+YLA6h6zeMm3Tu8ZX4eIipB9C753Zcc9FSIjc/stup3wdv0ERmmyAQdYon4+fi
	0ubiCNmki/EKkhsv5zDQlDwqCX7leG2ItKMtqIM3aSxGs6XPuLahtx9DtJYBDRi2cveXNeTuC0Y
	30GUwyIVfDaaBLjmylJz+CpsP+IAqAK6WmNueMBNDbUqYb0jplfspxESFEEOee0ZGajOYSHwGDT
	BUGI5ouUNmblavJUSyhAfemwsro18suaAXSoqt+latdIaUBLy8cLKtZ1RaGHnDiG7x/A3PTOGm3
	R4eq81I0GXzbp2gBFA9c9/HnQ1bPaqFHlvtD/zV/7nIQA4Y74c4IqCkfglRWH2u4JbtUQmGo1ep
	7XYnndCRseJPTQOXgdTw+BLr59pym9SSgxC1bgnxkSevV5yc4mjt0iZH6/LVz3WB0kJizIt5DMd
	d0EwQNO8/qCS9VyhRlynJSD
X-Received: by 2002:a17:903:b0e:b0:2d6:3c1a:85ef with SMTP id d9443c01a7336-2dd6c848391mr95107925ad.4.1789468504342;
        Tue, 15 Sep 2026 03:35:04 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b8asm64721195ad.5.2026.09.15.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:35:03 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: royalnet026@gmail.com,
	Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	luca.ceresoli@bootlin.com,
	cristian.ciocaltea@collabora.com,
	daniels@collabora.com,
	detlev.casanova@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	sebastian.reichel@collabora.com,
	macromorgan@hotmail.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks with PHY enable/disable
Date: Tue, 15 Sep 2026 18:34:33 +0800
Message-ID: <20260915103433.13163-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
Call trace:
 ...
 regmap_update_bits_base+0x70/0xa8
 dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
 drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
 snd_pcm_release+0x4c/0xc0 [snd_pcm]
 ...

The crash occurs when HDMI audio callbacks access registers after DRM
atomic framework disabled the PHY.

The root cause is a race condition exists between ALSA and DRM atomic
framework. During a modeset disable sequence, the DRM path disables the
PHY, while ALSA may still execute HDMI audio callbacks such as
audio_shutdown(), leading to accessing registers while the PHY is down
and eventually a kernel panic.

Fix this by introducing a mutex lock and PHY enabled state to serialize
PHY state transitions and HDMI audio callbacks. This ensures that HDMI
audio callbacks can only access registers while the PHY is enabled.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

Changes in v3:
- Add a tmds_char_rate guard in clear_audio_infoframe path.
- Decouple write_audio_infoframe from clear_audio_infoframe.
- Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
- Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/

Changes in v4:
- Update panic stack on 7.0.5
- Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/

Changes in v5:
- Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
  tmds_char_rate guard in new callback function.
- Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/

Changes in v6:
- Add mutex and state to serialize HDMI audio callbacks with the PHY enable/disable
- Link to v5: https://lore.kernel.org/all/20260908070220.41574-1-rmxpzlb@gmail.com/

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 1c214a8e6dc2..a4789050a09e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -159,6 +159,8 @@ struct dw_hdmi_qp {
 	struct {
 		const struct dw_hdmi_qp_phy_ops *ops;
 		void *data;
+		struct mutex lock;
+		bool enabled;
 	} phy;
 
 	unsigned long ref_clk_rate;
@@ -467,6 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return -EOPNOTSUPP;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
 
@@ -480,13 +486,23 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 	bool ref2stream = false;
+	int ret = 0;
 
-	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
+	mutex_lock(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled) {
+		ret = -EOPNOTSUPP;
+		goto err_res;
+	}
+
+	if (!hdmi->tmds_char_rate) {
+		ret = -ENODEV;
+		goto err_res;
+	}
 
 	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
 		dev_err(hdmi->dev, "unsupported clock settings\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_res;
 	}
 
 	if (fmt->bit_fmt == SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
@@ -495,9 +511,13 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 	dw_hdmi_qp_set_audio_interface(hdmi, fmt, hparms);
 	dw_hdmi_qp_set_sample_rate(hdmi, hdmi->tmds_char_rate, hparms->sample_rate);
 	dw_hdmi_qp_set_channel_status(hdmi, hparms->iec.status, ref2stream);
-	drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector, &hparms->cea);
+	mutex_unlock(&hdmi->phy.lock);
 
-	return 0;
+	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector, &hparms->cea);
+
+err_res:
+	mutex_unlock(&hdmi->phy.lock);
+	return ret;
 }
 
 static void dw_hdmi_qp_audio_disable_regs(struct dw_hdmi_qp *hdmi)
@@ -526,6 +546,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
 
 	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_audio_disable_regs(hdmi);
 }
@@ -754,6 +778,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
 	unsigned int op_mode;
+	int ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (WARN_ON(!connector))
@@ -763,6 +788,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (WARN_ON(!conn_state))
 		return;
 
+	mutex_lock(&hdmi->phy.lock);
 	if (connector->display_info.is_hdmi) {
 		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
 			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
@@ -774,10 +800,19 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 		op_mode = OPMODE_DVI;
 	}
 
-	hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	if (unlikely(ret)) {
+		dev_err(hdmi->dev, "failed to initialize PHY: %d\n", ret);
+		hdmi->phy.enabled = false;
+		hdmi->tmds_char_rate = 0;
+		mutex_unlock(&hdmi->phy.lock);
+		return;
+	}
+	hdmi->phy.enabled = true;
 
 	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
 	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
+	mutex_unlock(&hdmi->phy.lock);
 
 	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 }
@@ -787,9 +822,10 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
+	guard(mutex)(&hdmi->phy.lock);
 	hdmi->tmds_char_rate = 0;
-
 	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
+	hdmi->phy.enabled = false;
 }
 
 static enum drm_connector_status
@@ -880,10 +916,8 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
-static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+static int dw_hdmi_qp_clear_audio_infoframe_regs(struct dw_hdmi_qp *hdmi)
 {
-	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-
 	dw_hdmi_qp_mod(hdmi, 0,
 		       PKTSCHED_ACR_TX_EN |
 		       PKTSCHED_AUDS_TX_EN |
@@ -893,6 +927,17 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return 0;
+
+	return dw_hdmi_qp_clear_audio_infoframe_regs(hdmi);
+}
+
 static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
 				 size_t start, size_t len, unsigned int reg)
 {
@@ -987,7 +1032,11 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return -EOPNOTSUPP;
+
+	dw_hdmi_qp_clear_audio_infoframe_regs(hdmi);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
@@ -1299,6 +1348,8 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 
 	hdmi->phy.ops = plat_data->phy_ops;
 	hdmi->phy.data = plat_data->phy_data;
+	hdmi->phy.enabled = false;
+	mutex_init(&hdmi->phy.lock);
 
 	if (plat_data->ref_clk_rate) {
 		hdmi->ref_clk_rate = plat_data->ref_clk_rate;
-- 
2.55.0

