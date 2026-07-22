Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B415F1A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713774; cv=none; b=c3O1LmNfLMlFpkl/TtV37cCLDvHLu+00xrno8+84OKAwccs13B/56Che5vYT0TLuHWQBjEA9Q3K7rpcTMt6I4AVIDF0Zrnt1yuv89QCF2yZ1Sz+R/mhopobaD6Dlyns34pPoeEw4MZE28UlSrAk39gpbI0BLYVsiDYPSkC2WK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713774; c=relaxed/simple;
	bh=M993H7D+BqE+CyW6mZgB1dleZlufM3PRixzI0h7+OGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdfH77G3icKbUwCK1qdKqMf7W74mbriN5yI/ZyUJrOtv7nY2KL/7tzoIuj93mjoxZv2ygfojQU+RswQJ8O0cQ6olMiWifU0dRp2I4+HZveIMrrRZQgHp4WKcvscC3kUXMwUv+MWXNHOfAnlSGxphY/FWyXNB1qqb9Ije7J1ifJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tcDzR5BB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tcDzR5BB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9CEF14E40EC5;
	Wed, 22 Jul 2026 09:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69D3E60388;
	Wed, 22 Jul 2026 09:49:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9958411BD3A30;
	Wed, 22 Jul 2026 11:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784713768; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=stxIwdcEleIWpSaYIh2+fwHEePZ7UOvIiJ1idqO9hgI=;
	b=tcDzR5BBmWodymMvcvZB931nkbROUJXX4yFigAx1RfQMt1ncxXeIOq8vhFcGIEbfadqfnB
	gEisTvXUWwSCVBWGs0bL2nFE7nZn5FfApkSIghYXqzbButtEd9NHTGuOiS6l7o2OjExx7d
	DN8AzpBaXhMZJSK36HmnSftf+6/WVHHg6x9RdQWlKTcmXRUkpxc2ZTil11VPLkkt719MJw
	dSjCebsBS4Q6r5c+qhqAcgCUmBL6NBuP+HVKP2JaWbznmWpPt12oneNaX6rM9dF9B2n8Dh
	xdmugNDZfaD9i+rXuwo97K1JGEEXHvuQ0FDaqzArIXfQSRyJ4EKDZlAPf51sMg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 22 Jul 2026 11:49:13 +0200
Subject: [PATCH v3 2/2] drm/logicvc: Avoid using DRM resources after device
 is unplugged
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-logicvc-uaf-v3-2-f3b2319d58a6@bootlin.com>
References: <20260722-logicvc-uaf-v3-0-f3b2319d58a6@bootlin.com>
In-Reply-To: <20260722-logicvc-uaf-v3-0-f3b2319d58a6@bootlin.com>
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
 drivers/gpu/drm/logicvc/logicvc_crtc.c      | 39 +++++++++++++++++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_drm.c       |  6 ++++-
 drivers/gpu/drm/logicvc/logicvc_interface.c | 12 +++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.c     | 28 ++++++++++++++++-----
 4 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
index 3a4c347eaa648..e2575fa78ab25 100644
--- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
+++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
@@ -36,6 +36,21 @@ logicvc_crtc_mode_valid(struct drm_crtc *drm_crtc,
 	return 0;
 }
 
+static void logicvc_crtc_drop_any_event(struct drm_device *drm_dev,
+					struct drm_crtc *drm_crtc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&drm_dev->event_lock, flags);
+
+	if (drm_crtc->state->event) {
+		drm_crtc->state->event = NULL;
+		drm_warn(drm_crtc->dev, "Device is unplugged, ignoring pending vblank event!");
+	}
+
+	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
+}
+
 static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
 				      struct drm_atomic_state *state)
 {
@@ -44,6 +59,12 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
 		drm_atomic_get_old_crtc_state(state, drm_crtc);
 	struct drm_device *drm_dev = drm_crtc->dev;
 	unsigned long flags;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		logicvc_crtc_drop_any_event(drm_dev, drm_crtc);
+		return;
+	}
 
 	/*
 	 * We need to grab the pending event here if vblank was already enabled
@@ -58,6 +79,8 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
 
 		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
@@ -76,6 +99,12 @@ static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
 	unsigned int vact, vfp, vsl, vbp;
 	unsigned long flags;
 	u32 ctrl;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		logicvc_crtc_drop_any_event(drm_dev, drm_crtc);
+		return;
+	}
 
 	/* Timings */
 
@@ -148,6 +177,8 @@ static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
 		drm_crtc->state->event = NULL;
 		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
@@ -155,6 +186,12 @@ static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
 {
 	struct logicvc_drm *logicvc = logicvc_drm(drm_crtc->dev);
 	struct drm_device *drm_dev = drm_crtc->dev;
+	int idx;
+
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		logicvc_crtc_drop_any_event(drm_dev, drm_crtc);
+		return;
+	}
 
 	drm_crtc_vblank_off(drm_crtc);
 
@@ -180,6 +217,8 @@ static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
 		drm_crtc->state->event = NULL;
 		spin_unlock_irq(&drm_dev->event_lock);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_helper_funcs logicvc_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51a..fb66f5fb67937 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -72,6 +72,10 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u32 stat = 0;
 
+	/* The interrupt handler will be unregistered when the device is
+	 * removed. Therefore, there's no need for drm_dev_enter() here.
+	 */
+
 	/* Get pending interrupt sources. */
 	regmap_read(logicvc->regmap, LOGICVC_INT_STAT_REG, &stat);
 
@@ -463,7 +467,7 @@ static void logicvc_drm_remove(struct platform_device *pdev)
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
index de1f4a8a61557..4d9bfd57affcf 100644
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
@@ -92,7 +93,7 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
 	struct drm_crtc_state *crtc_state;
 	int min_scale, max_scale;
 	bool can_position;
-	int ret;
+	int idx, ret = 0;
 
 	if (!new_state->crtc)
 		return 0;
@@ -108,12 +109,15 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
+	if (!drm_dev_enter(drm_dev, &idx))
+		return -ENODEV;
+
 	if (!logicvc->caps->layer_address) {
 		ret = logicvc_layer_buffer_find_setup(logicvc, layer, new_state,
 						      NULL);
 		if (ret) {
 			drm_err(drm_dev, "No viable setup for buffer found.\n");
-			return ret;
+			goto out_exit;
 		}
 	}
 
@@ -127,12 +131,12 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
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
@@ -148,8 +152,12 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	struct drm_framebuffer *fb = new_state->fb;
 	struct logicvc_layer_buffer_setup setup = {};
 	u32 index = layer->index;
+	int idx;
 	u32 reg;
 
+	if (!drm_dev_enter(drm_dev, &idx))
+		return;
+
 	/* Layer dimensions */
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_WIDTH_REG(index),
@@ -230,6 +238,8 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	reg |= LOGICVC_LAYER_CTRL_COLOR_KEY_DISABLE;
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), reg);
+
+	drm_dev_exit(idx);
 }
 
 static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
@@ -238,8 +248,14 @@ static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
 	struct logicvc_layer *layer = logicvc_layer(drm_plane);
 	struct logicvc_drm *logicvc = logicvc_drm(drm_plane->dev);
 	u32 index = layer->index;
+	int idx;
+
+	if (!drm_dev_enter(&logicvc->drm_dev, &idx))
+		return;
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), 0);
+
+	drm_dev_exit(idx);
 }
 
 static struct drm_plane_helper_funcs logicvc_plane_helper_funcs = {

-- 
2.55.0

