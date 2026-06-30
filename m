Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E13E168F;
	Tue, 30 Jun 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810629; cv=none; b=IiwdjzUZxNIR0zL+9xWm8Ez4EZmtc6MTlJv3j4+egjwJX0cjudPJS1Dh1UQaOo1qgtlt95mNUCtVw5+jLJWse3kjSmAfJPFEj9CR5NsUgd5oFkiA4evPlX/TvKn6tMGc102eePtbOo3bFQ1tSZXGp72Zj0q8RNBfnbU9A3UmXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810629; c=relaxed/simple;
	bh=wlsZ1d1D+9omPnJ8Yd3YGQRwsS3UOmRTB7Ohkib/F5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp2HSYeISVRM4qyYJvmhubzzI87G6CUWvS6Zm/p4pXbfIM5tlE1AcbRqW4T1p9Ah2FoiRmFRsbZM3MzHn0oPkQLmEWooDIKSSHTo4BJ5/Rndgr6KJA75MoiYKNk6ATOOikxdLg5H+GqlI3Pp8iVD1kzNnWLKCdy5vJUfcvKiZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SDMMgrOr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SDMMgrOr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 86CD6C5147B;
	Tue, 30 Jun 2026 09:10:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AB6260233;
	Tue, 30 Jun 2026 09:10:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8E80106F1D11;
	Tue, 30 Jun 2026 11:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782810625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yzMvSEdp01rr5KR/5H6RUPCfGWiLJuBQbzlhpv4cr8Q=;
	b=SDMMgrOrvvcwn5MVcoxpRUL4mEdsW27RLBuUnAK78sYHE+eNluzmSa/lHZ2lRa8db42FwY
	YPsfiqM/KKyTEw1RYRthSsKWgMJdO2RYgGcN0Ktpnrp6n7Kz8cTJ1s0irH9uaTMBmHf9ME
	DWkBbg9S2WbDrdsZ42uokQ6esz2YkWvwkc1Zy5O6m8EcQUrSmQpEbzzYsCUn9zrTh8Jfdb
	9Ra29Z/rtWkIDBupd0bSbSsoW9Whtps22+6PuYy17yYTPyITKy30B1ANxFjeQy3UCE0XcR
	R8ImRkT4TZlKTuzQyBBi2YrwPSo1cXHZn5ZZRLh+TgOxU28CYRAPmVy+uz3MDw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Jun 2026 11:10:11 +0200
Subject: [PATCH v2 2/2] drm/logicvc: Avoid using DRM resources after device
 is unplugged
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-logicvc-uaf-v2-2-99e881833860@bootlin.com>
References: <20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com>
In-Reply-To: <20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com>
To: Paul Kocialkowski <paulk@sys-base.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Jason Xiang <jx@jasonxiang.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Some DRM resources such as plane, CRTC or encoder objects could remain in
use after the DRM device is removed. Use the drm_dev_enter/exit() mechanism
to ensure that the DRM device is not unplugged before using its resources.

Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display controller")                                                                        │
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/gpu/drm/logicvc/logicvc_crtc.c      | 35 ++++++++++++++++-----
 drivers/gpu/drm/logicvc/logicvc_drm.c       |  9 +++++-
 drivers/gpu/drm/logicvc/logicvc_interface.c | 12 ++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.c     | 48 ++++++++++++++++++++---------
 4 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
index 3a4c347eaa648..f3a224a883b2f 100644
--- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
+++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
@@ -40,10 +40,15 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
 				      struct drm_atomic_state *state)
 {
 	struct logicvc_crtc *crtc = logicvc_crtc(drm_crtc);
-	struct drm_crtc_state *old_state =
-		drm_atomic_get_old_crtc_state(state, drm_crtc);
 	struct drm_device *drm_dev = drm_crtc->dev;
+	struct drm_crtc_state *old_state;
 	unsigned long flags;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return;
+
+	old_state = drm_atomic_get_old_crtc_state(state, drm_crtc);
 
 	/*
 	 * We need to grab the pending event here if vblank was already enabled
@@ -58,6 +63,8 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
 
 		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
@@ -65,17 +72,23 @@ static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
 {
 	struct logicvc_crtc *crtc = logicvc_crtc(drm_crtc);
 	struct logicvc_drm *logicvc = logicvc_drm(drm_crtc->dev);
-	struct drm_crtc_state *old_state =
-		drm_atomic_get_old_crtc_state(state, drm_crtc);
-	struct drm_crtc_state *new_state =
-		drm_atomic_get_new_crtc_state(state, drm_crtc);
-	struct drm_display_mode *mode = &new_state->adjusted_mode;
 
 	struct drm_device *drm_dev = drm_crtc->dev;
+	struct drm_crtc_state *old_state;
+	struct drm_crtc_state *new_state;
 	unsigned int hact, hfp, hsl, hbp;
 	unsigned int vact, vfp, vsl, vbp;
+	struct drm_display_mode *mode;
 	unsigned long flags;
 	u32 ctrl;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return;
+
+	old_state = drm_atomic_get_old_crtc_state(state, drm_crtc);
+	new_state = drm_atomic_get_new_crtc_state(state, drm_crtc);
+	mode = &new_state->adjusted_mode;
 
 	/* Timings */
 
@@ -148,6 +161,8 @@ static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
 		drm_crtc->state->event = NULL;
 		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
@@ -155,6 +170,10 @@ static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
 {
 	struct logicvc_drm *logicvc = logicvc_drm(drm_crtc->dev);
 	struct drm_device *drm_dev = drm_crtc->dev;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return;
 
 	drm_crtc_vblank_off(drm_crtc);
 
@@ -180,6 +199,8 @@ static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
 		drm_crtc->state->event = NULL;
 		spin_unlock_irq(&drm_dev->event_lock);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_helper_funcs logicvc_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51a..2112646386e36 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -71,6 +71,7 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, void *data)
 	struct logicvc_drm *logicvc = data;
 	irqreturn_t ret = IRQ_NONE;
 	u32 stat = 0;
+	int idx;
 
 	/* Get pending interrupt sources. */
 	regmap_read(logicvc->regmap, LOGICVC_INT_STAT_REG, &stat);
@@ -79,8 +80,14 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, void *data)
 	regmap_write(logicvc->regmap, LOGICVC_INT_STAT_REG, stat);
 
 	if (stat & LOGICVC_INT_STAT_V_SYNC) {
+		/* DRM device could be unplugged. */
+		if (!drm_dev_enter(&logicvc->drm_dev, &idx))
+			return ret;
+
 		logicvc_crtc_vblank_handler(logicvc);
 		ret = IRQ_HANDLED;
+
+		drm_dev_exit(idx);
 	}
 
 	return ret;
@@ -463,7 +470,7 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct drm_device *drm_dev = &logicvc->drm_dev;
 
-	drm_dev_unregister(drm_dev);
+	drm_dev_unplug(drm_dev);
 	drm_atomic_helper_shutdown(drm_dev);
 
 	logicvc_mode_fini(logicvc);
diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 0d037f37b950f..aa13338a29535 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -34,6 +34,10 @@ static void logicvc_encoder_enable(struct drm_encoder *drm_encoder)
 	struct logicvc_drm *logicvc = logicvc_drm(drm_encoder->dev);
 	struct logicvc_interface *interface =
 		logicvc_interface_from_drm_encoder(drm_encoder);
+	int idx;
+
+	if (!drm_dev_enter(drm_encoder->dev, &idx))
+		return;
 
 	regmap_update_bits(logicvc->regmap, LOGICVC_POWER_CTRL_REG,
 			   LOGICVC_POWER_CTRL_VIDEO_ENABLE,
@@ -43,17 +47,25 @@ static void logicvc_encoder_enable(struct drm_encoder *drm_encoder)
 		drm_panel_prepare(interface->drm_panel);
 		drm_panel_enable(interface->drm_panel);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_encoder_disable(struct drm_encoder *drm_encoder)
 {
 	struct logicvc_interface *interface =
 		logicvc_interface_from_drm_encoder(drm_encoder);
+	int idx;
+
+	if (!drm_dev_enter(drm_encoder->dev, &idx))
+		return;
 
 	if (interface->drm_panel) {
 		drm_panel_disable(interface->drm_panel);
 		drm_panel_unprepare(interface->drm_panel);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_encoder_helper_funcs logicvc_encoder_helper_funcs = {
diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index de1f4a8a61557..51fb68e642adc 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -87,25 +88,32 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
 	struct drm_device *drm_dev = drm_plane->dev;
 	struct logicvc_layer *layer = logicvc_layer(drm_plane);
 	struct logicvc_drm *logicvc = logicvc_drm(drm_dev);
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, drm_plane);
+	struct drm_plane_state *new_state;
 	struct drm_crtc_state *crtc_state;
 	int min_scale, max_scale;
 	bool can_position;
-	int ret;
+	int idx, ret = 0;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return -ENODEV;
+
+	new_state = drm_atomic_get_new_plane_state(state, drm_plane);
 
 	if (!new_state->crtc)
-		return 0;
+		goto out_exit;
 
 	crtc_state = drm_atomic_get_new_crtc_state(new_state->state,
 						   new_state->crtc);
-	if (WARN_ON(!crtc_state))
-		return -EINVAL;
+	if (WARN_ON(!crtc_state)) {
+		ret = -EINVAL;
+		goto out_exit;
+	}
 
 	if (new_state->crtc_x < 0 || new_state->crtc_y < 0) {
 		drm_err(drm_dev,
 			"Negative on-CRTC positions are not supported.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_exit;
 	}
 
 	if (!logicvc->caps->layer_address) {
@@ -113,7 +121,7 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
 						      NULL);
 		if (ret) {
 			drm_err(drm_dev, "No viable setup for buffer found.\n");
-			return ret;
+			goto out_exit;
 		}
 	}
 
@@ -127,12 +135,12 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
 	ret = drm_atomic_helper_check_plane_state(new_state, crtc_state,
 						  min_scale, max_scale,
 						  can_position, true);
-	if (ret) {
+	if (ret)
 		drm_err(drm_dev, "Invalid plane state\n\n");
-		return ret;
-	}
 
-	return 0;
+out_exit:
+	drm_dev_exit(idx);
+	return ret;
 }
 
 static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
@@ -141,15 +149,21 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	struct logicvc_layer *layer = logicvc_layer(drm_plane);
 	struct logicvc_drm *logicvc = logicvc_drm(drm_plane->dev);
 	struct drm_device *drm_dev = &logicvc->drm_dev;
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, drm_plane);
 	struct drm_crtc *drm_crtc = &logicvc->crtc->drm_crtc;
 	struct drm_display_mode *mode = &drm_crtc->state->adjusted_mode;
-	struct drm_framebuffer *fb = new_state->fb;
 	struct logicvc_layer_buffer_setup setup = {};
+	struct drm_plane_state *new_state;
+	struct drm_framebuffer *fb;
 	u32 index = layer->index;
+	int idx;
 	u32 reg;
 
+	if (!drm_dev_enter(drm_dev, &idx))
+		return;
+
+	new_state = drm_atomic_get_new_plane_state(state, drm_plane);
+	fb = new_state->fb;
+
 	/* Layer dimensions */
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_WIDTH_REG(index),
@@ -230,6 +244,8 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	reg |= LOGICVC_LAYER_CTRL_COLOR_KEY_DISABLE;
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), reg);
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
@@ -239,6 +255,8 @@ static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
 	struct logicvc_drm *logicvc = logicvc_drm(drm_plane->dev);
 	u32 index = layer->index;
 
+	/* No need for drm_dev_enter() here. The regmap outlives the DRM device. */
+
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), 0);
 }
 

-- 
2.54.0

