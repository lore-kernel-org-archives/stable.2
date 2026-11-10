Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341483;
	b=3VR1fF/319uEcr0rbDIZm9v4rg3e7KSNLw4fGxn5vbTp0e4fxnaZf9Ij2/gKYK74jORh
	 JxLLyfLpohIilShznfYUgxJwrxMiAU54GexL6XtqzTbLGF1pXKpi5U4fLVNjyvhBMQ7f6
	 3qrXErGg0LkyeIj28V42FJ2zQJrqFrxSlFtOJlfDuJ1da3TYLpaSqtp60RFwEZb+EmB7W
	 cnpArPTK6SNwyNOMVq6eRsSom3YUFRFFLCGRTMnfIPX8RylE/J+I8dkkTjgMxhqnv25xB
	 UbGPWgEZoqngSHoyoiYLpcohAh5xB1zeFsT2DKbMZ2D+hQemideM0TU9QxuI3L3T19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=liHWpowTgOsRjZWhuH2ckQ+ood/zUb+tsorcpD2uwrQ=;
	b=wmDX64yPlBzcY9fvHLkN6oGwGrD4Mo3ZIlZIcEHWDkxxvg2s8CgYbSZUpFLqLGWasidU
	 FJG2pPeptOOYQxW5yOdHIQwTCUlNImJrpfcPmdJBNlLzNsrvbPAzDdqqStwaRxMpIvCTt
	 ++qcNl0rOes6qKAQlu9xtTD0pDpAn4UcKljSJDlJCeYkOVoX3KRm1fnT1Rsaj8xtX5zXm
	 gbOx2BEjxnMXxWNtEIMxeDLh2OEPsQjvTE1kvyk1yH4WEDMFlrzFH59vJDeXB9A64bBQh
	 PXjBPPIFfdp5TxEawG1AUR/NviYT0/7MytZs4ENBzfVzJRGzkUFJOVgVO6MR3oWLCUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yw94yLMC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E775606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yw94yLMC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5E11F0089F;
	Tue, 10 Nov 2026 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341483;
	bh=liHWpowTgOsRjZWhuH2ckQ+ood/zUb+tsorcpD2uwrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yw94yLMCtTehargEuagh7vWvPxhP0IMoIvx9IO2s7a9MGpXDX7gMGj5UOrdH7spYj
	 7u2QBKjvIZbRLgbpVgV683bQm9Orj+CmrBee3B4j1YZPLpVpsVWw/1TPIqBhY9sziE
	 pMrCSImx0q/FHxqPzQVzUJiDRU4NHew4+V0hXyhKAjUUcM8iZz7/L2zqdqSfCov3Yo
	 PQSpA6SGKPat9i0jBJs+qLukatemwOe6glB8ZPfS7L+oL8XB2+1Zl9G0lfUPy8poJk
	 Xi2uWK78PLQzMhgwcbnOLrI/oBSSp4HL9rHWw/RacnEIRdI9xdEn9GOCWiXyYMiF1x
	 go8bYmC/1cBXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes
Date: Tue, 10 Nov 2026 15:11:20 -0500
Message-ID: <20261110200947.3702749-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200947.3702749-1-sashal@kernel.org>
References: <20261107051054-failed-6.18-317a8be73091@kernel.org>
 <20261110200947.3702749-1-sashal@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit 317a8be730919177956be32422ebe00cf7e46710 ]

The ovl_* files documented in
Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
longer exist.

Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver
core") moved the attributes from each overlay's framebuffer device to
the platform driver's dev_groups and renamed them overlay_*. There is
now only one set of attributes for the whole LCDC. The callbacks still
expect dev_get_drvdata() to return a struct fb_info, but the platform
device holds struct sh_mobile_lcdc_priv, so they access the wrong
structure.

Restore the documented names and register the group on each overlay's
framebuffer device with device_add_groups(). Remove it with
device_remove_groups() before unregistering the framebuffer. Skip
creation when dev_of_fbinfo(info) is NULL, as the old device_create_file()
calls did.

Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.

Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver core")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 39 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 1b7b9dd19b623..07e1dbcec3afb 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1341,22 +1341,24 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR_RW(overlay_alpha);
-static DEVICE_ATTR_RW(overlay_mode);
-static DEVICE_ATTR_RW(overlay_position);
-static DEVICE_ATTR_RW(overlay_rop3);
-
-static struct attribute *overlay_sysfs_attrs[] __maybe_unused = {
-	&dev_attr_overlay_alpha.attr,
-	&dev_attr_overlay_mode.attr,
-	&dev_attr_overlay_position.attr,
-	&dev_attr_overlay_rop3.attr,
+static struct device_attribute dev_attr_ovl_alpha =
+	__ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);
+static struct device_attribute dev_attr_ovl_mode =
+	__ATTR(ovl_mode, 0644, overlay_mode_show, overlay_mode_store);
+static struct device_attribute dev_attr_ovl_position =
+	__ATTR(ovl_position, 0644, overlay_position_show, overlay_position_store);
+static struct device_attribute dev_attr_ovl_rop3 =
+	__ATTR(ovl_rop3, 0644, overlay_rop3_show, overlay_rop3_store);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&dev_attr_ovl_alpha.attr,
+	&dev_attr_ovl_mode.attr,
+	&dev_attr_ovl_position.attr,
+	&dev_attr_ovl_rop3.attr,
 	NULL,
 };
 
-#ifdef CONFIG_FB_DEVICE
 ATTRIBUTE_GROUPS(overlay_sysfs);
-#endif
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
@@ -1514,9 +1516,10 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
 
-	if (info == NULL || info->dev == NULL)
+	if (!info || !dev_of_fbinfo(info))
 		return;
 
+	device_remove_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1534,6 +1537,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 	if (ret < 0)
 		return ret;
 
+	/* The framebuffer device is optional, see fb_device_create(). */
+	if (dev_of_fbinfo(info)) {
+		ret = device_add_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
+		if (ret < 0) {
+			unregister_framebuffer(info);
+			return ret;
+		}
+	}
+
 	dev_info(lcdc->dev, "registered %s/overlay %u as %dx%d %dbpp.\n",
 		 dev_name(lcdc->dev), ovl->index, info->var.xres,
 		 info->var.yres, info->var.bits_per_pixel);
@@ -2641,7 +2653,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
-		.dev_groups	= overlay_sysfs_groups,
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,
-- 
2.53.0

