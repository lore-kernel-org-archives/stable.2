Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3753806D8
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296776; cv=none; b=R/dtder8xh1dAitVHl0hze172ikMLySaQJVdbnIJQA9kTODky5tgvlyAIq1mYIlYYy8wQccjg4dl1nPjczTivcDMYjiS1dLRN6+7u1glERCSE4ePF5XPAmuAhBXtXjVlyictElBRb32GDuxAQyrmBUxb0nYGI9mxSPqedjqLmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296776; c=relaxed/simple;
	bh=yFmVN3bgLtBmalKgw37FKNLIyAtzGS90x5MIiBm1dPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWYgci3R8v5tHdg6T21hx8gkjGBr5EqQVDnE9foQFjElLYcHbTTfzuXztabR8tuodLTUZq4Hy1pEHlIwVnCAwBI8iIuctX1GN82TGT5ev0fVFfllIwXm4aP4p9ROmsvZXFiytFOMj0PC0GzQ2LUUPIN2iF7T3MqFWNQ6DZotu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fn0X4+pP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fn0X4+pP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C3BA44E42DCE;
	Mon,  1 Jun 2026 06:52:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9127C602AB;
	Mon,  1 Jun 2026 06:52:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49D3910888CCD;
	Mon,  1 Jun 2026 08:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780296770; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=oJLELg61HGfPf14QsgfwoLBF1BU6+4ipnY2RieFlxq4=;
	b=fn0X4+pP2kYtkKoHre/h/NGL2cMFVLfsG4lapEV5/5q0ZAiJ9a2jLEykk/2hrmMf55V6Zt
	Vvsjgp2e2S4SeK1k50sukmbs6H3tPYxKxSl1xgt8a3Q1olSCJCLxt7r7F9dtIfEBHGjWvs
	QYEFqi/vpPUsm56KKssTVOtPyn1Fl7nRAciX/ygL2xjkPOiPluYoPF7m7J8h5Zf16WWGIE
	PteqAIAXwkglfESY/zRdEsZ8j+T8So3dmr/Ejghqqv+HIdKCgN3nCduLvuq8v6fL9p37ri
	N5hIt+rQbnMCbJ7froQiW6Ajg6jhKe02HBK88cyc1o0N/Axah8tvhEw3/aH6AQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jun 2026 08:52:44 +0200
Subject: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBMmIxddJVqYjjURFloSRHfPa
 vkW/18QKTBFaIsLAiWOvPqMqizATNqPJNhmg0SpsJFKLOvIJhlxaCdIDxXWDi1aglxsgRyf363
 rf8djmMns7wLu+wE1jBc+bwAAAA==
X-Change-ID: 20260526-logicvc-uaf-eab103f0d0de
To: Paul Kocialkowski <paulk@sys-base.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The logicvc driver calls drm_universal_plane_init(),
drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
should not be called with structs allocated with devm_kzalloc(), as this
can lead to use-after-free bugs. In fact, a use-after-free caused by this
has been observed on a v6.6 kernel.

Use DRM-managed allocations instead for panel, CRTC and encoder objects.

Found using KASAN.

Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display controller")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/gpu/drm/logicvc/logicvc_crtc.c      |  17 ++---
 drivers/gpu/drm/logicvc/logicvc_interface.c |  49 +++++--------
 drivers/gpu/drm/logicvc/logicvc_layer.c     | 105 +++++++++++++---------------
 3 files changed, 75 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
index 43a675d03808f..3a4c347eaa648 100644
--- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
+++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
@@ -13,6 +13,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -214,7 +215,6 @@ static void logicvc_crtc_disable_vblank(struct drm_crtc *drm_crtc)
 
 static const struct drm_crtc_funcs logicvc_crtc_funcs = {
 	.reset			= drm_atomic_helper_crtc_reset,
-	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
@@ -250,11 +250,6 @@ int logicvc_crtc_init(struct logicvc_drm *logicvc)
 	struct device_node *of_node = dev->of_node;
 	struct logicvc_crtc *crtc;
 	struct logicvc_layer *layer_primary;
-	int ret;
-
-	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
-	if (!crtc)
-		return -ENOMEM;
 
 	layer_primary = logicvc_layer_get_primary(logicvc);
 	if (!layer_primary) {
@@ -262,12 +257,12 @@ int logicvc_crtc_init(struct logicvc_drm *logicvc)
 		return -EINVAL;
 	}
 
-	ret = drm_crtc_init_with_planes(drm_dev, &crtc->drm_crtc,
-					&layer_primary->drm_plane, NULL,
-					&logicvc_crtc_funcs, NULL);
-	if (ret) {
+	crtc = drmm_crtc_alloc_with_planes(drm_dev, struct logicvc_crtc,
+					   drm_crtc, &layer_primary->drm_plane,
+					   NULL, &logicvc_crtc_funcs, NULL);
+	if (IS_ERR(crtc)) {
 		drm_err(drm_dev, "Failed to initialize CRTC\n");
-		return ret;
+		return PTR_ERR(crtc);
 	}
 
 	drm_crtc_helper_add(&crtc->drm_crtc, &logicvc_crtc_helper_funcs);
diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 689049d395c0d..0d037f37b950f 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -12,6 +12,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -60,10 +61,6 @@ static const struct drm_encoder_helper_funcs logicvc_encoder_helper_funcs = {
 	.disable		= logicvc_encoder_disable,
 };
 
-static const struct drm_encoder_funcs logicvc_encoder_funcs = {
-	.destroy		= drm_encoder_cleanup,
-};
-
 static int logicvc_connector_get_modes(struct drm_connector *drm_connector)
 {
 	struct logicvc_interface *interface =
@@ -84,7 +81,6 @@ static const struct drm_connector_helper_funcs logicvc_connector_helper_funcs =
 static const struct drm_connector_funcs logicvc_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.destroy		= drm_connector_cleanup,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -147,36 +143,35 @@ int logicvc_interface_init(struct logicvc_drm *logicvc)
 	int encoder_type = logicvc_interface_encoder_type(logicvc);
 	int connector_type = logicvc_interface_connector_type(logicvc);
 	bool native_connector = logicvc_interface_native_connector(logicvc);
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
 	int ret;
 
-	interface = devm_kzalloc(dev, sizeof(*interface), GFP_KERNEL);
-	if (!interface) {
-		ret = -ENOMEM;
-		goto error_early;
-	}
-
-	ret = drm_of_find_panel_or_bridge(of_node, 0, 0, &interface->drm_panel,
-					  &interface->drm_bridge);
+	ret = drm_of_find_panel_or_bridge(of_node, 0, 0, &panel,
+					  &bridge);
 	if (ret == -EPROBE_DEFER)
-		goto error_early;
+		return ret;
 
-	ret = drm_encoder_init(drm_dev, &interface->drm_encoder,
-			       &logicvc_encoder_funcs, encoder_type, NULL);
-	if (ret) {
+	interface = drmm_encoder_alloc(drm_dev, struct logicvc_interface, drm_encoder,
+				       NULL, encoder_type, NULL);
+	if (IS_ERR(interface)) {
 		drm_err(drm_dev, "Failed to initialize encoder\n");
-		goto error_early;
+		return PTR_ERR(interface);
 	}
 
+	interface->drm_panel = panel;
+	interface->drm_bridge = bridge;
+
 	drm_encoder_helper_add(&interface->drm_encoder,
 			       &logicvc_encoder_helper_funcs);
 
 	if (native_connector || interface->drm_panel) {
-		ret = drm_connector_init(drm_dev, &interface->drm_connector,
-					 &logicvc_connector_funcs,
-					 connector_type);
+		ret = drmm_connector_init(drm_dev, &interface->drm_connector,
+					  &logicvc_connector_funcs,
+					  connector_type, NULL);
 		if (ret) {
 			drm_err(drm_dev, "Failed to initialize connector\n");
-			goto error_encoder;
+			return ret;
 		}
 
 		drm_connector_helper_add(&interface->drm_connector,
@@ -187,7 +182,7 @@ int logicvc_interface_init(struct logicvc_drm *logicvc)
 		if (ret) {
 			drm_err(drm_dev,
 				"Failed to attach connector to encoder\n");
-			goto error_encoder;
+			return ret;
 		}
 	}
 
@@ -197,17 +192,11 @@ int logicvc_interface_init(struct logicvc_drm *logicvc)
 		if (ret) {
 			drm_err(drm_dev,
 				"Failed to attach bridge to encoder\n");
-			goto error_encoder;
+			return ret;
 		}
 	}
 
 	logicvc->interface = interface;
 
 	return 0;
-
-error_encoder:
-	drm_encoder_cleanup(&interface->drm_encoder);
-
-error_early:
-	return ret;
 }
diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index eab4d773f92b6..de1f4a8a61557 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -13,6 +13,7 @@
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 
@@ -250,7 +251,6 @@ static struct drm_plane_helper_funcs logicvc_plane_helper_funcs = {
 static const struct drm_plane_funcs logicvc_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
@@ -350,16 +350,17 @@ int logicvc_layer_buffer_find_setup(struct logicvc_drm *logicvc,
 	return 0;
 }
 
-static struct logicvc_layer_formats *logicvc_layer_formats_lookup(struct logicvc_layer *layer)
+static struct logicvc_layer_formats *
+logicvc_layer_formats_lookup(struct logicvc_layer_config *config)
 {
 	bool alpha;
 	unsigned int i = 0;
 
-	alpha = (layer->config.alpha_mode == LOGICVC_LAYER_ALPHA_PIXEL);
+	alpha = (config->alpha_mode == LOGICVC_LAYER_ALPHA_PIXEL);
 
 	while (logicvc_layer_formats[i].formats) {
-		if (logicvc_layer_formats[i].colorspace == layer->config.colorspace &&
-		    logicvc_layer_formats[i].depth == layer->config.depth &&
+		if (logicvc_layer_formats[i].colorspace == config->colorspace &&
+		    logicvc_layer_formats[i].depth == config->depth &&
 		    logicvc_layer_formats[i].alpha == alpha)
 			return &logicvc_layer_formats[i];
 
@@ -380,10 +381,9 @@ static unsigned int logicvc_layer_formats_count(struct logicvc_layer_formats *fo
 }
 
 static int logicvc_layer_config_parse(struct logicvc_drm *logicvc,
-				      struct logicvc_layer *layer)
+				      struct device_node *of_node,
+				      struct logicvc_layer_config *config)
 {
-	struct device_node *of_node = layer->of_node;
-	struct logicvc_layer_config *config = &layer->config;
 	int ret;
 
 	logicvc_of_property_parse_bool(of_node,
@@ -458,11 +458,30 @@ struct logicvc_layer *logicvc_layer_get_primary(struct logicvc_drm *logicvc)
 	return logicvc_layer_get_from_type(logicvc, DRM_PLANE_TYPE_PRIMARY);
 }
 
+static void logicvc_layer_set_config(struct logicvc_layer *layer,
+				     struct logicvc_layer_config *config)
+{
+	layer->config.colorspace = config->colorspace;
+	layer->config.depth = config->depth;
+	layer->config.alpha_mode = config->alpha_mode;
+	layer->config.base_offset = config->base_offset;
+	layer->config.buffer_offset = config->buffer_offset;
+	layer->config.primary = config->primary;
+}
+
+static void logicvc_layer_fini(struct drm_device *drm_dev,
+			       void *data)
+{
+	struct logicvc_layer *layer = data;
+
+	list_del(&layer->list);
+}
+
 static int logicvc_layer_init(struct logicvc_drm *logicvc,
 			      struct device_node *of_node, u32 index)
 {
 	struct drm_device *drm_dev = &logicvc->drm_dev;
-	struct device *dev = drm_dev->dev;
+	struct logicvc_layer_config config = { 0 };
 	struct logicvc_layer *layer = NULL;
 	struct logicvc_layer_formats *formats;
 	unsigned int formats_count;
@@ -470,28 +489,18 @@ static int logicvc_layer_init(struct logicvc_drm *logicvc,
 	unsigned int zpos;
 	int ret;
 
-	layer = devm_kzalloc(dev, sizeof(*layer), GFP_KERNEL);
-	if (!layer) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	layer->of_node = of_node;
-	layer->index = index;
-
-	ret = logicvc_layer_config_parse(logicvc, layer);
+	ret = logicvc_layer_config_parse(logicvc, of_node, &config);
 	if (ret) {
 		drm_err(drm_dev, "Failed to parse config for layer #%d\n",
 			index);
-		goto error;
+		return ret;
 	}
 
-	formats = logicvc_layer_formats_lookup(layer);
+	formats = logicvc_layer_formats_lookup(&config);
 	if (!formats) {
 		drm_err(drm_dev, "Failed to lookup formats for layer #%d\n",
 			index);
-		ret = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	formats_count = logicvc_layer_formats_count(formats);
@@ -511,24 +520,27 @@ static int logicvc_layer_init(struct logicvc_drm *logicvc,
 		regmap_write(logicvc->regmap, LOGICVC_BACKGROUND_COLOR_REG,
 			     background);
 
-		devm_kfree(dev, layer);
-
 		return 0;
 	}
 
-	if (layer->config.primary)
+	if (config.primary)
 		type = DRM_PLANE_TYPE_PRIMARY;
 	else
 		type = DRM_PLANE_TYPE_OVERLAY;
 
-	ret = drm_universal_plane_init(drm_dev, &layer->drm_plane, 0,
-				       &logicvc_plane_funcs, formats->formats,
-				       formats_count, NULL, type, NULL);
-	if (ret) {
+	layer = drmm_universal_plane_alloc(drm_dev, struct logicvc_layer,
+					   drm_plane, 0, &logicvc_plane_funcs,
+					   formats->formats, formats_count,
+					   NULL, type, NULL);
+	if (IS_ERR(layer)) {
 		drm_err(drm_dev, "Failed to initialize layer plane\n");
-		return ret;
+		return PTR_ERR(layer);
 	}
 
+	layer->of_node = of_node;
+	layer->index = index;
+	logicvc_layer_set_config(layer, &config);
+
 	drm_plane_helper_add(&layer->drm_plane, &logicvc_plane_helper_funcs);
 
 	zpos = logicvc->config.layers_count - index - 1;
@@ -545,22 +557,13 @@ static int logicvc_layer_init(struct logicvc_drm *logicvc,
 
 	list_add_tail(&layer->list, &logicvc->layers_list);
 
-	return 0;
-
-error:
-	if (layer)
-		devm_kfree(dev, layer);
-
-	return ret;
-}
+	ret = drmm_add_action_or_reset(drm_dev, logicvc_layer_fini,
+				       layer);
+	if (ret)
+		return ret;
 
-static void logicvc_layer_fini(struct logicvc_drm *logicvc,
-			       struct logicvc_layer *layer)
-{
-	struct device *dev = logicvc->drm_dev.dev;
 
-	list_del(&layer->list);
-	devm_kfree(dev, layer);
+	return 0;
 }
 
 void logicvc_layers_attach_crtc(struct logicvc_drm *logicvc)
@@ -584,14 +587,12 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 	struct device_node *layer_node = NULL;
 	struct device_node *layers_node;
 	struct logicvc_layer *layer;
-	struct logicvc_layer *next;
 	int ret = 0;
 
 	layers_node = of_get_child_by_name(of_node, "layers");
 	if (!layers_node) {
 		drm_err(drm_dev, "No layers node found in the description\n");
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
 	for_each_child_of_node(layers_node, layer_node) {
@@ -614,17 +615,11 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 		ret = logicvc_layer_init(logicvc, layer_node, index);
 		if (ret) {
 			of_node_put(layers_node);
-			goto error;
+			return ret;
 		}
 	}
 
 	of_node_put(layers_node);
 
 	return 0;
-
-error:
-	list_for_each_entry_safe(layer, next, &logicvc->layers_list, list)
-		logicvc_layer_fini(logicvc, layer);
-
-	return ret;
 }

---
base-commit: 44e151be23deb788d9f6124de93823faf6e04e99
change-id: 20260526-logicvc-uaf-eab103f0d0de

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

