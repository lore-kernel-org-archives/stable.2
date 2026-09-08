Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553E2C027C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850973; cv=none; b=oxnfeIGkQSXeQP07gZ95soMUcwPpZD1lPUKWrdbrj13VfmBO0kR4GcpFN7syavBR9+VK/SMAbUEEaFOC5Mt7CYE3nTqTYL26lSVF1DsSn4Ha90VoFulv/BO0Wp0Uz4tq9w8L2jDxFNXmCfxG9oOF8RvwA61PriBP9vev1suu6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850973; c=relaxed/simple;
	bh=tFhVIGvqrdIyyVl0uRcPiZBn30HFsG0MOAbNQFMUjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxT20A+e9YVZYjfJxhSHSmaEcFBzZbBVsJLINX8BUKtBzpVtgtyRdj/sJQbOdqjNOAOJs31mtbRQA7oj1JyH0g490wTMeClHq+zu0NmnWdGeKIY76ZZORrMTP5VGYjfRxLdmhdfNbLK7MnhHg/4sW7R4BIeD9K7n7d4a0LnuZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEGyRlPE; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEGyRlPE"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86323e4853aso177407b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788850971; x=1789455771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NELnY7rhvN2fX0w+mwkpJWMxqnyiES6ZAAlSHyGONzo=;
        b=fEGyRlPEITQ2kEQ85nAVH7fMUjFKZbhONe9y8E8HzMths7YuWvazQWWlgyP8XIzHYB
         hPPm45TfELuWOhrJAi8vMQQiM1cvPWWGDfcYhdW9l8w3D5CW0/YQ0vunORjtWNJZ5/Sh
         9IUb9Pks2CUJlmlVXikfEJXAxa3f3KmzQ7SE6aXc2t7/L4j//ANo7BEBRPRcWyBNllWd
         2wRE9MaVzdyWWkEWsBl+naCUDQIhVNxDVhZ76OPbFkzmu0erDYXxZlpVHD1N25LbbMe7
         0q77/sD5cAGyrgpX7O7oZ2LnCnveozqplYphcvz/PP+mdrgvRajURJjyevZiRiOH3bF/
         pTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788850971; x=1789455771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NELnY7rhvN2fX0w+mwkpJWMxqnyiES6ZAAlSHyGONzo=;
        b=XnlSq3ufvHqpHns5UDRKQ4kbUXeBNIRcwGcytMvkjg7uLxpJL4YsfZpePR+K7reV8/
         4js5aLA7+joztv0uX8adYv+VBrVOSWv/568lk9OJNGkirk1CmGW64w6YnbRyXTMIsA+Z
         x0YS0jWVq2PoZicPC9OdRfBPVCr5w7ns0J5Yev8BIICnPiLn6NwtSqSM4Ovy1HiwDGab
         Pp0TQFmQpLsFTDIUefEJKzi9mmMhMKzz9xLDxJSvI68uU6OjntjF+bk8dCuRA1QdhmIu
         zSLvrufI6cvoLX1TT+hOSWf5PKiz3lNBunCokBqySpYAWVTl3wisO4e16WJtlx6GSyO+
         aHDQ==
X-Forwarded-Encrypted: i=1; AKwUvByvBXEpYoXsmGPqApwKOuHGIirvjRE0vNg53zSC+mAEnpy3KGG4N6LMgMfI8jZBzJBy7lN1qFA=@vger.kernel.org
X-Gm-Message-State: AFuF++m6fm1nG7IM7y5BW8aaWRR2r/X3ctVT4fMeA/u/n+iX52Vk8dEd
	0baAYjCG+7rHCxj/kZUQAqrykXU9uK92dqvs8Vsv0WNv2iVH8IUDeIOo
X-Gm-Gg: AYBFou0UDPugXgZkHY5p8cHeNAtuPSBEK9HycSCU0YRevvw+Q9xokVJkoqIArr0Mac7
	z6qNFI/jr/eeShPWMO2zonDB/Uf2MuVb5fM5/+PRwLIU3UtF5Df4jx7wiOtEDS4I73J/xr/xN/m
	s/JDU4a7KGeDuGUXKFqBcPJGZFho/q7XtV3wEvw5aN9DWskV+14SXwvr+eDFwK/oxo2dvJgfGAJ
	TrMhtABM+AKLYP/CnIsNMaBZqt9yylfs8215mE+QS2mCIIY/yOWH/7Zg/szePtTxvSGgy1pq65T
	SKZw5OEjwRVeiLWkrU5w0rJ4qs2WvuAU5cEw/8ssfB6uhRjasK5rRwZKBpAK/bSlBFVQDeEc2Zo
	M4Ic8aELqRM/hlwBL1Zczdg+q5wp8hB5aoXz3+OdphZG4w5nDqlcB6ei2UiUGkxlkOrywT2xDHy
	P9leh4nXgrH+wH9YKCwHNuse6kwyrRgHXP4Vr3j0ZuEBfn2/GmDffTmZm9sfNKyXtqYdNPV0FK3
	tpxQDPW7WfXFA==
X-Received: by 2002:a17:903:38cc:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2db276b8656mr203032685ad.1.1788850971418;
        Tue, 08 Sep 2026 00:02:51 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483ea94sm54981615ad.9.2026.09.08.00.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:02:50 -0700 (PDT)
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
Subject: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Tue,  8 Sep 2026 15:02:20 +0800
Message-ID: <20260908070220.41574-1-rmxpzlb@gmail.com>
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

The root cause is pipewire tries to close the HDMI audio device after
atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
checking tmds_char_rate.

Guard the register access in drm_display_helper callback function with
tmds_char_rate check.

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
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 1c214a8e6dc2..8729783d4eb6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -880,7 +880,7 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
-static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+static int __dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
@@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	if (hdmi->tmds_char_rate > 0)
+		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+
+	return 0;
+}
+
 static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
 				 size_t start, size_t len, unsigned int reg)
 {
@@ -987,7 +997,7 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	__dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
-- 
2.55.0

