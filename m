Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473253;
	b=qx3g14mnJQjQ0JaIPT5840rtOuQe3rneCXw8OwvZH+BW6Y9zTfT6N4Q7vz2kN4mP1GIZ
	 3gmTxQOhciKLBth6J7tfWpynytgJdx2wXDlN5kNsk9xyrD04yKn160O4N6/opGvyfOZOg
	 7mExQsiBaQ1zusF/c8L3DdvpEM1hfYqVdVPRt1GCIQLXku73AusifLAf8S7J82OAbLbDw
	 yqu7P5gCV59hacpHCTKYW3o8E0ZACzEFhu+u6uk3Bw3fpBpQJ4Afvqmy5WDCYVpzhevgY
	 qRQ3S5IIysP2uZ0EkWkdktY1FmS3XkWUf6VFCN/GtFshoJdC/lXOWPUEMKwYhBuvBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=03w06bSm1yONRYYXB48Ye2MeketUdFgM5u2hRd5PsVE=;
	b=0nAg3o6xNesWelOcJA59tfqiEkFsm/N9kxa6rdtvPBG3iIJsryWgHD8krBO1Vu/x9V68
	 b7RBVnY8auAU/AFAbHVqSUthR+CHsZxpG+r8IyPnWGerRDkGfP2wzBIDRYejAFuNDZuye
	 xquKGWDn9aOmCFKImFhqMayYTdWAfp0kjWU86b+gxQHVdwOyu8N8pU0HGgAN8CSyrb869
	 uXACrfKzzRyUODCv5GU8LFyz8iAWBNEd4Z4n0beo/pl9naxod3uRJ6hk754lTyq8KShwC
	 ZH4eTarcosVtZTOzKcTaaqTYe2oONDERUwTi7yjvcKHlqfwbuwLSqa/7kqpbwfh8FTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjLYtXrA;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622B606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8622B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjLYtXrA
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99e0082c434so898748241.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795473252; x=1796078052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=03w06bSm1yONRYYXB48Ye2MeketUdFgM5u2hRd5PsVE=;
        b=EjLYtXrAc3UlzR3T8RzWHffjsUR5UVohVDSnop8XhH9PVdN8bbaJremTeNb65hFOgD
         hF8x9A8buy93T7dvFRtMNiTAMS+hkYsqW59iWi7J4hkHtzEYKeoPQjsRQu6iS460o4Xe
         XBzmHmMK7YTOTpeYMMnu9V1HJ0QanN4U84ONMjueWj/uJHZN9yc4cQ50ZzdbYd3nf26c
         YIBM3ncAyzH8gY+HEDnManwqyJrOQDQwPiPxYI2Z3/Abg5YwoBek8GyngRdBgjA/gSE/
         jqPRTSgYwJZSPyFWa7ZhBVQttpZwLdE5JYgMXF60EJU43mMVRqfTn5rr6UvLFjySWaqt
         axaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473252; x=1796078052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03w06bSm1yONRYYXB48Ye2MeketUdFgM5u2hRd5PsVE=;
        b=TlUj/2QWhNr714Ooh5Hu0XuCNGE0rCOjhtNPnlZ/9qVGJKFvKoJuO+5RuZDg/s0LGG
         zTyRnVdB4kYGIkGGOmf0QBCGX/YokbH0ViwunLDqzR3LdNji3goohxTu3Bs3LxPDZ784
         9E/CZgDeD24vi9nvnfRVl3ciF7fEexoLhiUuV1XxP9O9zqvMb01R04BHMOJ2cyqnHv2H
         bI2MHX64SBDji2RmatFH8Id2O2mTuv153hXiBQIygVlW2oqxoZFy/FfIZyOtHiAB00cn
         h7uXDPB4TQH1D+AGRynAwAJc8B022A/Z7GjQQcy99Zz/kio5QuZyq/yhWfBFvKzupvgj
         YE+w==
X-Forwarded-Encrypted: i=1; AL+hErEd3gcxypbRyhe1u2/RUzl7NOjLHA9ST4o7MmgAnYYaakxI6JG1UU0DG2eSXzPvAP09nSfVrec=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZCukQ1P9/L8MXkYqkYKczcEjFEN4Jk3av8dXbw1vuqLW6C9cb
	8nEHxp4I6tHs97CmVwvqJUVreL7mlVtMvqQdJYQk9c6c72SRlPgklgzVRh+0ZQ==
X-Gm-Gg: AZFdTZfOp9cBA8PuyDzEX/L5w5hV//7tsfbI57qIIU20oSu2clNi2JrcK7QsoP75MUS
	q4GoKXloxNJbnfLpw/KuurL6Lmth3rLtOiZBm7oFQmXkWmgBjPBlK6FvCgqMhQGGdb691JS565G
	YC2dA56B+80P8CdT63EbYp9c6DAHIOn7xF4+UGAAMyC5c9id4W8Rsh/9UGfABwslLgcMvJRmPdk
	kLXB0Y9hGWxLKOCl1bfgOQStUp5+L0QweI+c3sWMCh4wW7mqKDSMjgkyCunj3Y8M+9jwoiHpeJD
	A9fgXRbH5LKBZC7wx4hQBUZ5MRKZkbB66e8VK71moVPvZomUvDmjIFNfD1gJWZRYC9mJSFHD92L
	uuiZ9kztpomksDCnP6hHx+Ys3uRr0XqlJtZDAtbhzZpWeTHom9vNXTU2QILcukTylV8plc44Bfk
	ZUXSk7amW1lEm6GZW6OY8aFZtrRTwR2mnSLMHd1+RNt/HbnXY4/90xASsQ654fy5gqJq58mG7QF
	agqGhH6loGYkJule4oKgVedqKOq1B45FKLVn2lAL0X/3EDLDUFxc2QsRwf7H7Fk9QkTD39b9gXd
	GByGmekPfFhCsbuMm2ESr2ikVdMqyI/c7CAYjlR7BrXIMW6P5hATxKv08w6FUHsfTzGJyOLhd1X
	DXk+lrCZnDm/FcF6vS+Tf19I=
X-Received: by 2002:a05:6102:3f16:b0:7d6:e716:8e05 with SMTP id ada2fe7eead31-7d7392a486amr5876555137.5.1795473251968;
        Mon, 23 Nov 2026 14:34:11 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:59e7:dd47:a2cb:e700])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm12729378241.1.2026.11.23.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:34:11 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: laurentiu.palcu@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	marek.vasut@mailbox.org,
	mripard@kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Mon, 23 Nov 2026 19:33:57 -0300
Message-ID: <20261123223357.535424-1-festevam@gmail.com>
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
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Rebase onto next-20261123 after the devm_kzalloc_obj() conversion.
- Add Laurentiu's Reviewed-by tag.

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index b7be7e17d1d0..bc1a9a2fc6bd 100644
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
 
-		encoder = devm_kzalloc_obj(dev, *encoder);
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
 
-	lcdif = devm_kzalloc_obj(&pdev->dev, *lcdif);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

