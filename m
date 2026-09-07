Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F3E1693
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747535; cv=none; b=REtm1Kp9pg77cPns9fZMQ2t6FRlHjNGdCVRnPggUeaCQ6CtYAYN1OaOgCMd4vzpw8f2HEBRjipvueyQd0+GDmS/gwlvzPb8zxcdvtKF62AaEFn1J6OCWSX9mX23t/9d+rj6p+E4FV0vXT3EPh5p10J+ftn5SASZ6akTSSqXkIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747535; c=relaxed/simple;
	bh=tAjnkzKNrxs4iWZRhFTUOpI2X3brnrApqpb8xgY0oPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OH5q0tbbgvkZw8U052ABE28rctqPDd4faSre6lqMqV6ewT2NhU8dnzl/FnBFpNEhhDhMtfpeS6dnjKSDhZ7+6wuKb+1oaV0EBK+YFTriekBO0TAXtddK3Mxe3Ec95ardOS8W9uA5GzAmU+Mm0qsL3U83npisZEMJCuT/aHSbTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piIhbASF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piIhbASF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441fa5c37so2112644f8f.3
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788747529; x=1789352329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AIZYWJVjQUnBNnHeOHBqUSKoQJf+SCAcPIAInF4Y+OU=;
        b=piIhbASFwQ5V2inJkGKKo0dA6rhveg1xPPy94ksmTHRAHO9tkWqBvRwS4/pN78G+OB
         JVhCDaOfY8bJTIyiWTn3pHSjL9w0Z2LR37Ip4nxFU0CK0VvWUbx8ctA8fOF/CqC+ZHZ1
         eZ9LRb1vXs/xc28MBxVwJktIq6cdGw7ZGaOvZuaNiFgqz7Y6M/HISHJ4hcVzoHnFErZY
         /QqbQv1w+EyOp6TgkDAYMeKwaYhXmJLG+Zw4ahugVMaHeGOnZIu39BgjAEVjbHXcHlzR
         EWxPyLBaJ31w/+JnJYoLj2Xi6KPX9RvIi51rdnSFsv9uoQBDndxu5+HRztbmcVhvpJfb
         mVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747529; x=1789352329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIZYWJVjQUnBNnHeOHBqUSKoQJf+SCAcPIAInF4Y+OU=;
        b=g6+bqR/EF7Ma1541aeXmitHExE3OWNklx7rzLzTFxmrWU4Cpz7mIAEixfOHQBp0sgQ
         kC5kHH6nbejeV01XRVxaoQP+mOgSgui2qF52qv/lR9Otz4yZzBOd7IkyTJ7d++vCZcad
         pedc4/WGDPvxzPbEcleS3uMmGOZ0NeGwmiLzurIweFsX9s5adLrBqkbhawLVSn2J04SB
         KZFitgAVYd8HK7N/Paz09aApJTwx6lbuYikmleHnE6Kn3u7t59tBpJ+Vw5mNmienA+Ki
         KVATKe9vutDRfLuAk3ja+RCnKLDDWT9/v22XlDvz/BIa0quYakVLLGu+1uxlUCK9ThQD
         PJNw==
X-Forwarded-Encrypted: i=1; AKwUvByGeP5XbT4aRGroCkZgoRN7+2wQimYiwrPOL1AWlsVKwHrmBViLMA6hKqW4vbfT8OlgHy5SM+U=@vger.kernel.org
X-Gm-Message-State: AFuF++lDx3tEzLuY0NwbznIbqaJc8l3k+3fy2H077t0zw8giAxwOHPbr
	an3mcydnNioRqUuFP4LmYgXLUgqoe9sFXUkvnteDOqM3hI1kWFcxDnFushElk5Qw
X-Gm-Gg: AYBFou1kJ/DG3LOZ7UNsCuebmCUqrXE+fzyfSmNqMQabbaUTfPE5IHGOECoYGsYmtLJ
	yXGQQJx9mR52RoEH+rViKxF3OLDv+b/2WjDGBfAXLyQH7/EJWKFZBHnAY2kJ2yn/y2EQfUkh0mz
	bX6T1/GK/vLmgjHFa9WbxZGBKw5O+rsKtosy3swBOc1VVUhvrwy2cDLQyUUa2bqrIYMB37MwNVB
	j7aYTXJWhwKjhqG5OhgQOWAN8BQlpSrbGnDI50jLgLW3O66xd1lhNSW68Bmx9SREtajscKTEVZc
	MUaQxvzk7USPxegplQ+qL/6DoH5E4krx8btQqSoOaNAY/xguFBW2WZuFNb0LNmdFl9ccqmYXP0w
	MUWBrEo8AJZq5NhBEHdKuPSvzs4BB+F4m6rV6a/bczCPmJM1tnWVuw0QMCE6lggHD2UjHMNnqSd
	blDEav8HmRdmYWokNcgV4+6ygCLzYgLllqw7h5FDmIa3+NGZ7V7GCqK+gU45JAN1jr5nT7AZYsv
	kXvC8KhzYVLit+21q78nlYWBhgVpskDh1rnyxrf9PrZ0EK/vsPpuwAUnBgaRpipUz+JVFVmRJ+U
	g+XW+YvGayup4alY6Gfbz83Fl7vG3clBkp+ZHe0roovXzhx0kob75Src6oJ8+PcGPsVQGEX7XHH
	gNl8w83r+3z6Cq4WA
X-Received: by 2002:a05:6000:4703:b0:485:93c5:856e with SMTP id ffacd0b85a97d-48593c58629mr10071101f8f.9.1788747529298;
        Sun, 06 Sep 2026 19:18:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-9daa-d59e-970b-f46c.310.pool.telefonica.de. [2a02:3100:b0c9:3601:9daa:d59e:970b:f46c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm21411912f8f.2.2026.09.06.19.18.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 19:18:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Chintan Patel <chintanlike@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes
Date: Mon,  7 Sep 2026 04:18:44 +0200
Message-Id: <20260907021844.25497-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
creation when info->dev is NULL, as the old device_create_file() calls did.

Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.

Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver core")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Found while reviewing the sysfs ABI documentation.

Compile-tested only (allmodconfig, W=1), I have no SH-Mobile hardware.

 drivers/video/fbdev/sh_mobile_lcdcfb.c | 37 +++++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f..18fc4e465283 100644
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
@@ -1513,6 +1515,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 	if (info == NULL || info->dev == NULL)
 		return;
 
+	device_remove_groups(info->dev, overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 	if (ret < 0)
 		return ret;
 
+	/* The framebuffer device is optional, see fb_device_create(). */
+	if (info->dev) {
+		ret = device_add_groups(info->dev, overlay_sysfs_groups);
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

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0
