Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88A3E4C90
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987768; cv=none; b=AFE1HiWB/7YguAce+v/motgy9oS9eDq3+k2E3iSo9QV3gO7P4GUohX3BRFZJB8EGb1xDO4YUPSwpkjlW31ULYrumPh4uhaSCBLtqZT9apGEVQnEmejVzrOmgWxtFSZXERXv622SosrtHJemscdMKOxNSLfhYJaQkP69qxu5OhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987768; c=relaxed/simple;
	bh=URW732EQx7Ne/f01+x4cxIvdq8e3brW7+hVxha4kXYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDS51cwtIEWQuEGS0gtItKBo80Zg1C2J+hAAV15rT5c32ePGADOMj8LIcJ4uKICjSsWRPYdr2x7tHnczqfVoOotXzCxjizk32tLeUGXrfgx8vKEAI3hdESsmy7J3Jai3WwS0M6rps8hu2GizIl9Ysp9s+7CIvx4jhkavwvsO+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/4o2YYg; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/4o2YYg"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-785d603efdeso2349915137.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788987765; x=1789592565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q46w9/u2wpQp5QGB3PuR+xp/kUloMNPv1YY/PPVAfY4=;
        b=g/4o2YYgxyatFKJ4/tZejSoWlK4jwYlOxHkfu8cEjZL8s9Zzchpm9GheNwNwX6zp36
         qfTEmOF3mhxnABDOWeJcsuOuw9OPm21r5ovvYAirSYuiE2rSYxOe8N4uWR8FflbUR/HJ
         ZYdKhzk83oso1ooi8FebhOXK4JJYvISd5A6R+PXlebJcrNJN1srK0jUTNCBBiLQrsAeo
         S25WtE1fq+UZTRVaynm/ACYMD33bkmyuovpgTR8boVpB7vicd7MrhygKUwOmbRR004lV
         SlB7HR4JPEOQeAGSTZo9bhKDdEU7d3CcLx2W0iX9HV1QEDCIvvSxBP850e32IXnghI2S
         RwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788987765; x=1789592565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q46w9/u2wpQp5QGB3PuR+xp/kUloMNPv1YY/PPVAfY4=;
        b=azIjdxJIS1OyE4FDEoK4dQ/nnKZimvIpIUEPoMBYQOy0Hvyvyk/xueihmjwnB2PuDT
         OsWbJMjwbEvzijwDEvZ+qbN8WrjHnN82/g649KmXoc8wEQjN/OREYM5+2Q1AZkKOq1Zy
         5wUMA6x2ZlNFYwZHHjZyyYJL8Uxix+wTh5Czn+dVTEfrdz1OYAwZ6r4ioKBTUvIqwvFm
         YEFxLujiPDn8tDOabwaYz2nBVG0BpfO+Pn/bpM2QfVpJ+kO6jLeALUw2/cp+PphwtK9h
         nS8YI4GjqJVgD35Q/ZrUgTtf2tRlR5QIFzUnK3uYDZY4fZzEoTRxfhN1jMyBnuiZoOl6
         zqUw==
X-Forwarded-Encrypted: i=1; AKwUvBw0Jozei17JDO/iCwudoi5vPbEOl30/seN0LUJFLg8iJglQwpDGwRHuQATGhHRR5BAW+Jcxgqs=@vger.kernel.org
X-Gm-Message-State: AFuF++kE2sdNSoNaQuYD8eTvHgIPy1qxiLcxydyq8rOXM+YZ5o38iz6N
	0NKWYn8QTdcvEuDW/g+0X0Q8SPU0H3VsVb7s+dwlNrkURNXGIuHliRYE
X-Gm-Gg: AYBFou3Q1CXmOd7JRnMVOY4Nvo7Z+Z2q1yjPJPJTE/y7K1DUzLSDCR51FCNeQxY+ELf
	sfGrsfVPiOmQ+/LLWfYEgaQPrhBR1qYLYLsEt0qxfk38F28DyNyR8dgEyVFLD5PoIfbZ2phO6dX
	kWsy/CK7vZOl3WQY0xhjleS4NaW/y7jlqxkM3qBJcLBTQk4CsU7a6nOcIYGNs9muEKh5fNgkYMO
	6KcTeyQ5piC8GGQDBCaQeE9hoRJvpVIvfjTH2WH2j85Cliy5QikNdv3Tl3MzvGUrasTRjBNYRyQ
	aVVsXSrAP5/Ka5G6n9U5QmHZ/LT1fAgqitEUJPjeyTRd20VZ/aN5chrW6On7+QV/YMzm5L+pJTj
	BsV+wCr4paA6Eg8oUR1Vq5GMiiGaeRIFiaATFKoYFnSt/qzr4lqcVLg4qDEUXimLIQ6wwgG/Q31
	HDE2ma6uXfeCBd60xwwpPJ33KTM+T2Ou1KzYeM0oPNvuPbFx1VxYVuIATa+16YnqRnszX7dWKmA
	v1VSPQ0AGMNQbLOB+EvUPD0xOe+GMPEAOhVZBm1cZfAoNrk
X-Received: by 2002:a05:6102:2d03:b0:786:77e2:d8fa with SMTP id ada2fe7eead31-78a4a943a32mr14848382137.5.1788987763467;
        Wed, 09 Sep 2026 14:02:43 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a803:6c49:659c:692c:9416:2f0d])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a4764e321sm12434590137.0.2026.09.09.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:02:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: mripard@kernel.org,
	imx@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Wed,  9 Sep 2026 18:02:13 -0300
Message-ID: <20260909210213.946159-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index e2173c4d6fc2..7e9f3b205a45 100644
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
@@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     "Failed to get bridge for endpoint%u\n",
 					     of_ep.id);
 
-		encoder = devm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
-		if (!encoder)
-			return dev_err_probe(dev, -ENOMEM,
-					     "Failed to allocate encoder for endpoint%u\n",
-					     of_ep.id);
-
-		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
-		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
-				       DRM_MODE_ENCODER_NONE, NULL);
-		if (ret)
+		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
+						   DRM_MODE_ENCODER_NONE, NULL);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
 			return dev_err_probe(dev, ret,
 					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);
+		}
+
+		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
 
 		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
@@ -131,7 +125,7 @@ static int lcdif_load(struct drm_device *drm)
 	struct lcdif_drm_private *lcdif;
 	int ret;
 
-	lcdif = devm_kzalloc(&pdev->dev, sizeof(*lcdif), GFP_KERNEL);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 
-- 
2.43.0

