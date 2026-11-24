Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519346;
	b=gNIdck+QoIna2Z1rt8RdywA4Lgfh93n8kJ/6MCMBy7nPuzv8HYCYQ4uOePxSIO8gVpNc
	 PqJFhUHgL3yrzhzye6e72AP71adY6TlM8phde2Y8bkoovqAOCGNr8b8qxkUiNPKWUNSWw
	 FqrbXxWf5pVBEOsMIWWSU5zbkUBRN/7CZYz3rOWgYLEPMf8+65PpZx006U09XUFiuy1lT
	 OMi/4zd6TQUddpRiwzJB04/yBF70KWEeFe9YosuxSEILpnePZCqUoWNHpGlRsFnp3QK5i
	 MXvJ87iApUk+qXue3crjNgSNAammQlwtufZMhepz3dL1FoCkcR3eWEaRQQLZM9hAmRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zOlLhiHGS+QvddYr4TaDXREtsHzHjMolopc6Gh+4/Zk=;
	b=TQE+Bfw+WCE2n2Wnxc6UG24zIcG4lnmCWox7GGX//CvveFYDhULFT8RnGSBvxeJnJ4Z0
	 6aH22GxgfMBaFDCOYAeqls2Q+QFq+jSjhHaX4KrS1hyk/fSV/5IPF+02AoyG1gez+U0Jy
	 ZlSVFWPM+RBxOmCDT5fq0ocoob3tZfa60NGCxYuCx5UA0EDHt1Y4EqjR4aHrdVs0NcLJU
	 FzoW0mCs26V7btkK7UBEgdj0+1zXtGpR/9oCReTuZ4DBykLiHmm4Il7TNydvM0H/rml1a
	 3x50atu3p/gh/mX9nNh1c16HSgcAVVqxF5NMr401xGlPK7D7XycpCWsWn6V6zXqQ0dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkvLiBYd;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E97606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E97606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkvLiBYd
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a315ed211so5437490eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519345; x=1796124145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOlLhiHGS+QvddYr4TaDXREtsHzHjMolopc6Gh+4/Zk=;
        b=WkvLiBYdN1G3E3sxLAQLbhP6Tmpr0yJYtCKLiLpIznXU+HxatPQp1NjiXK8FxnbVh+
         mJrqbhOoptGsBLC4hu6gvVUaPEwepvSJo1POFfi6Y2gB88HYfHurBN+vPue4+Xy3GUJE
         /DRUBcDHZdHCmHC/Us0pHR+YSm4qO7yKdA5miMT/tOSdnYufIDxtvwQdLWVUFdscMGv2
         xGp8CUE5aHiX778Fdxo7xcbsRoG3+qiml8v26RlPW64tTG2kesr6YL7dbKC6OUAjQYBC
         iHXXZ3v4tQUji8WNpDjqIY2nWdGxyHLgnPyQBJqG3xqZf1nslByC0rewfx1qqJU0gDHL
         MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519345; x=1796124145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOlLhiHGS+QvddYr4TaDXREtsHzHjMolopc6Gh+4/Zk=;
        b=pKhnHu4tbbF7kPxdNT64oBfeJgU+cQqtwa2NB9ySXIDgH0noifX0hdIMJnGtsGbPsZ
         W1wsILepUNI/iE0Wn14q8WhNMCZXIQVMogSO6bfO6+S8MtNIbaJEYFJzONCXjB08ma1P
         mVKZzkLjBQwxhtoRHdrSL0AqLDj3jD42KjKyZ6JY6Lxav4SP8ITjnRE2ubRlNKB4AEDt
         zDvUif0nXGoKIa6hwLDWpsikEWrCMtF0CztlQesd2TQJUQFEWYWavcXwOSxs1StzPGC4
         4zPbPKV8KAwYd9ySs7ArQunrD/PVjFxXAu/RCXzlbAR01AtqBB9CF05TYb0cWbd0KhYH
         4iLA==
X-Forwarded-Encrypted: i=1; AL+hErEP364LyN2JvY1427ASu9cA/HEWfCtOkhOtWGJUgURvRK+nU0NSyO/6+q0fdviPKbZ0ruJemk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sBjaLvs/oKDJhY3fnuQMNHASCNcUKRfhblrt60rnNK1HWpEZC
	m5PBlvdAw17QnRagqu3bMKGU6mSxjz7Jw+KA2DIXTF8X5tAX7eN5oKAv
X-Gm-Gg: AZFdTZdAEsucUWXgEo7dEJFIDUquSXzC4Uliqf6Jj0PxxkHFYW0ZGnjMW8p7Sz1tPJR
	5hZWRa2imcYFLU7ur9hbL9RSK3WR5p2oRgzlDDj/5Prb5wY5w94KSXg1emGVz2SsOl7tjNmCMM7
	RaYdot8X+Zks94qO7dJwrde6KPOrw4LEstkA+smBPVh0KTYnVKPqNkshEvWpKX0gMTcm6qgpgwm
	uG6LMtXPELrKsmwqbN62YsQi/akoXzPs3EjDamtIPnwtvd6AHpjnV/+u94Py+GfCu1RSoOqNu1v
	2x/QL5wG9rIaoJ2/0GeCMDoqOlAGsI3ZURhk8bLujn7fStGCBCFlsnzZSM0Keexeux8YvuJkAlf
	/lnwA8fO3zxbLTn1Gw7MN7o20nEC897WAYiyHUuqsdledOVKitx7KHY7T1okNVvqYiyjx5P6rGZ
	ADHPR3FeAHICkAm+7tk7VJAAiucG8/j1iUCfeCC5WKV+1awM1vWN+2N0WRv/KOeHANkNP8asnAg
	GnpsupycmPLbewiR/0QfzvKz/phvjO2vmK5PdYcIHuDzJc0wrK/MWUoK4quYakZ3h6kL4XmuFon
	adundBJZtzDC1I6EUuH11TnCXVnnZsqY/2At7wJ3NRvlDec8gctlo8WKmmM4EexIAaFsgGg7nvm
	knUVxMle1SmklbZbY2ngDDoQ=
X-Received: by 2002:a05:7300:ce81:b0:384:a3c5:35b8 with SMTP id 5a478bee46e88-384b3986ee5mr18053216eec.8.1795519344585;
        Tue, 24 Nov 2026 03:22:24 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:549d:3701:4c51:db13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm55112634eec.4.2026.11.24.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:22:23 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: laurentiu.palcu@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	marek.vasut@mailbox.org,
	mripard@kernel.org,
	luca.ceresoli@bootlin.com,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Tue, 24 Nov 2026 08:22:15 -0300
Message-ID: <20261124112215.12255-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lcdif allocates its private data, which embeds the CRTC and primary
plane, and its encoders using devres. These DRM objects are linked into
the mode_config lists.

Since mode_config cleanup is DRM-managed, it is deferred until the DRM
device is released. An open DRM file can keep the DRM device alive after
the platform device has been unbound and devres has freed those objects.
The later mode_config cleanup then dereferences freed memory.

Allocate the private data with drmm before initializing mode_config so
that it remains alive until mode_config cleanup has completed. Allocate
encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
and removes it from the mode_config list before freeing its memory.

This can be reproduced on i.MX8MP by keeping the DRM card open across an
LCDIF unbind and closing it afterwards.

Cc: stable@vger.kernel.org
Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Return the encoder allocation error directly instead of storing it in ret. (Luca)

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index b7be7e17d1d0..2be5a76e936f 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -24,6 +24,7 @@
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
@@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
-static const struct drm_encoder_funcs lcdif_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 {
 	struct device *dev = lcdif->drm->dev;
@@ -74,19 +71,14 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     "Failed to get bridge for endpoint%u\n",
 					     of_ep.id);
 
-		encoder = devm_kzalloc_obj(dev, *encoder);
-		if (!encoder)
-			return dev_err_probe(dev, -ENOMEM,
-					     "Failed to allocate encoder for endpoint%u\n",
+		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
+						   DRM_MODE_ENCODER_NONE, NULL);
+		if (IS_ERR(encoder))
+			return dev_err_probe(dev, PTR_ERR(encoder),
+					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);
 
 		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
-		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
-				       DRM_MODE_ENCODER_NONE, NULL);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to initialize encoder for endpoint%u\n",
-					     of_ep.id);
 
 		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
@@ -131,7 +123,7 @@ static int lcdif_load(struct drm_device *drm)
 	struct lcdif_drm_private *lcdif;
 	int ret;
 
-	lcdif = devm_kzalloc_obj(&pdev->dev, *lcdif);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 
-- 
2.43.0

