Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046256;
	b=tj/P4N3KtV4gRVLtuNVeO1GUJb6hM7s6yqSmJtU0ojCDRtYoMISsD2L4UIymFGIMJYJC
	 vpL+Nu6kZJdHHhM1/7/k7ekmJilGni3vgNLMdH0Zl7RjPbVAomCxocelWQXRbaRGlZ0MX
	 rZ0xbN+oR4uONcHxqXUxpa9z5hBzMKnB698BLtSk8Wu/z5T5u130l4P4yL72VGTP4B0j3
	 pgfbVy4cH3Nm5E4Md7mP+EOCg1LVRrCBUsSit59NYhePN5B7mFvcYqavvA8/8ygxes667
	 0JrFC18cMXr7i6A6emVuFojTjrAwZNnI9j/nzxrZw/Ijfzv24n+o1b1eoTIPwFXNB+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N2VDx6IPqMlV0ZCoPWpAtlouFfRFH6uhXczXX2K9qVc=;
	b=KEtjuC1ZwA4LKEQy2sv/Gx+kEN0updcIqqWADNhVp+v8YDcSbhELBYjxQcUILs6VfVDZ
	 7eGSl2z2dJg+dahkNQaGhkN/oxMhQE5zthl9c4z7g3ZhK6Plt8w0RNdsOq7bmAr7ONw/w
	 H3QSFREKxZHzFeVWlEO5IXAOXaCM93aqd7SY2KwjFV9L6tl6iBjGhNoILxeOhk1Ms6fDX
	 rVs94tmhwhWz1tGpu3YCwT3OjjqDIcj1gCQJ2H3Lpn4IDRt/NciZj1CKEsfxjyeHs5/MB
	 Ze6m/1UZJsuTsTGldssZUuzkqKv/knSW/L5l5B4qRIoBROKFWoi2S4eJ6mQ7eOBwEwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO57Ho0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB94606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO57Ho0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501231F0089F;
	Sat,  7 Nov 2026 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046255;
	bh=N2VDx6IPqMlV0ZCoPWpAtlouFfRFH6uhXczXX2K9qVc=;
	h=From:To:Cc:Subject:Date;
	b=eO57Ho0B/3rlccoCBwFtQKW1QD1G2rz0Sn1QR2XSBML+aEmNGYZ+uTI6rAd9dL+8I
	 gps8lwHBkxcY8plhKlCuz0PLAKJZjyLCIEYrU5FfoPAFduw2K7duqW8YYAhHGXy6GP
	 NIoWneqgVNzddAO5IKDllTGITJ9S8hTD5VZt4EszDbtj14AEru8x9W2fcTw83sqm7U
	 0acL72sDhW6DY+uERr63dtNDo8cl62m+/edVXKqb3CESGQLGsEF5/W7k36BjHGvJ6o
	 X7drbI+lsWbG59PGnYODn8eqN1KAKvgFTBPBBs67ZXOQ/wi8DmuB4Ol1pBCBCUFv9i
	 AFqPMcepFH8nw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:54 -0500
Message-ID: <20261107051054-failed-6.18-317a8be73091@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 317a8be730919177956be32422ebe00cf7e46710
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051054-failed-6.18-317a8be73091@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 317a8be730919177956be32422ebe00cf7e46710 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Sat, 12 Sep 2026 12:21:52 +0200
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes

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
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 39 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f6..5743c96d54814 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
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
@@ -1510,9 +1512,10 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
 
-	if (info == NULL || info->dev == NULL)
+	if (!info || !dev_of_fbinfo(info))
 		return;
 
+	device_remove_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
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
@@ -2637,7 +2649,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
-		.dev_groups	= overlay_sysfs_groups,
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,
-- 
2.53.0




