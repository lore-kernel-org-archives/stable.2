Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DE46D548
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125988; cv=none; b=HwhvEvY+tLYScskE1w7Z7CbwhJsmUoLQGqbetBzS+8ciuU5u45KR/60qi32JAPhoijD+T2jZR9whFVh7M2mGDVN62AnkmguwJQtRZ5kQsqjSiGZNRz2Vo6CYeJHOTFFgIvxX9aLH+XAjX0PXpMx+II4bMxV4ipJ+xi2jxEtt7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125988; c=relaxed/simple;
	bh=vqORI82zJRBI4y/rME7lSrkws2CB5ui3NnWJ6rsVIwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kThG4KIsTjKg10EKdt5rQ6oNIGHVFmp/Up3PquyFZ66iakNTZlJm7SGG+C9SEmMM9UUUGh015hJsBrRDwInY4uFomCRgVPS6l6X610V4Kc8df80L6fWsEbtSIkIUdDrdakK4B7xyqfEBG7/3iwRllhZnYKuw0VLbL02t1FXx2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzAiAHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzAiAHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC361F000FF;
	Fri, 11 Sep 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125980;
	bh=JCrAaXsOiHYX8v6IqFGOLIzbHh3KaYbHdmczeAmL22Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjzAiAHdVmZxtf9aahECkfdRYtH+48kBGIcodJGE2vsA2vOkuCQEESC2lWYrig3vy
	 aRSYnIdBEOhj46OftVK3qiS+p44FMjGjkSzILMuHOLmgn0zZuj5yttyc1drmUaPgKa
	 QZCr8qiIBlmPix6gzRH3i+eO+vSIlH25jSiOnGbbhEG6j2XY7xnFZLH6eWbhbmcK9Q
	 eXMuo0VOg0d75YwGCNNt/0lzZzybFOp/1TRV/DwOUJ3nUtlW/CtZYjKuYbN+BPoKNV
	 A+FwQKb5cmLJsmOcE3qoJ/GknnjRDU2c/P9AtCI/txr0haDEEtQIreID87Ldudzeoc
	 0rsAlRinM3p3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: i2c: imx355: Replace client->dev usage
Date: Fri, 11 Sep 2026 07:26:16 -0400
Message-ID: <20260911112617.381156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090912-lid-cattail-734c@gregkh>
References: <2026090912-lid-cattail-734c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 49c6ac166cf77cd53eeda69e8ccdcbe4a57a4fdf ]

The driver needs to access the struct device in many places, and
retrieves it from the i2c_client itself retrieved with
v4l2_get_subdevdata(). Store it as a pointer in struct imx355 and access
it from there instead, to simplify the driver.

While at it, fix a mistake in the sort order of include statements.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: ee737bc3ccae ("media: imx355: Avoid calling imx355_power_off twice in error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx355.c | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index b2dce67c0b6bc..2315393f32e7e 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Intel Corporation
 
-#include <linux/unaligned.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/unaligned.h>
+
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
@@ -97,6 +98,8 @@ struct imx355_hwcfg {
 };
 
 struct imx355 {
+	struct device *dev;
+
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
@@ -1136,14 +1139,13 @@ static int imx355_write_reg(struct imx355 *imx355, u16 reg, u32 len, u32 val)
 static int imx355_write_regs(struct imx355 *imx355,
 			     const struct imx355_reg *regs, u32 len)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	int ret;
 	u32 i;
 
 	for (i = 0; i < len; i++) {
 		ret = imx355_write_reg(imx355, regs[i].address, 1, regs[i].val);
 		if (ret) {
-			dev_err_ratelimited(&client->dev,
+			dev_err_ratelimited(imx355->dev,
 					    "write reg 0x%4.4x return err %d",
 					    regs[i].address, ret);
 
@@ -1178,7 +1180,6 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct imx355 *imx355 = container_of(ctrl->handler,
 					     struct imx355, ctrl_handler);
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	s64 max;
 	int ret;
 
@@ -1197,7 +1198,7 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
 	 * Applying V4L2 control value only happens
 	 * when power is up for streaming
 	 */
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	if (!pm_runtime_get_if_in_use(imx355->dev))
 		return 0;
 
 	switch (ctrl->id) {
@@ -1231,12 +1232,12 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	default:
 		ret = -EINVAL;
-		dev_info(&client->dev, "ctrl(id:0x%x,val:0x%x) is not handled",
+		dev_info(imx355->dev, "ctrl(id:0x%x,val:0x%x) is not handled",
 			 ctrl->id, ctrl->val);
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(imx355->dev);
 
 	return ret;
 }
@@ -1385,7 +1386,6 @@ imx355_set_pad_format(struct v4l2_subdev *sd,
 /* Start streaming */
 static int imx355_start_streaming(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	const struct imx355_reg_list *reg_list;
 	int ret;
 
@@ -1393,7 +1393,7 @@ static int imx355_start_streaming(struct imx355 *imx355)
 	reg_list = &imx355_global_setting;
 	ret = imx355_write_regs(imx355, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
-		dev_err(&client->dev, "failed to set global settings");
+		dev_err(imx355->dev, "failed to set global settings");
 		return ret;
 	}
 
@@ -1401,7 +1401,7 @@ static int imx355_start_streaming(struct imx355 *imx355)
 	reg_list = &imx355->cur_mode->reg_list;
 	ret = imx355_write_regs(imx355, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
-		dev_err(&client->dev, "failed to set mode");
+		dev_err(imx355->dev, "failed to set mode");
 		return ret;
 	}
 
@@ -1429,13 +1429,12 @@ static int imx355_stop_streaming(struct imx355 *imx355)
 static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct imx355 *imx355 = to_imx355(sd);
-	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	int ret = 0;
 
 	mutex_lock(&imx355->mutex);
 
 	if (enable) {
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(imx355->dev);
 		if (ret < 0)
 			goto err_unlock;
 
@@ -1448,7 +1447,7 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 			goto err_rpm_put;
 	} else {
 		imx355_stop_streaming(imx355);
-		pm_runtime_put(&client->dev);
+		pm_runtime_put(imx355->dev);
 	}
 
 	/* vflip and hflip cannot change during streaming */
@@ -1460,7 +1459,7 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 
 err_rpm_put:
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(imx355->dev);
 err_unlock:
 	mutex_unlock(&imx355->mutex);
 
@@ -1470,7 +1469,6 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 /* Verify chip ID */
 static int imx355_identify_module(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	int ret;
 	u32 val;
 
@@ -1479,7 +1477,7 @@ static int imx355_identify_module(struct imx355 *imx355)
 		return ret;
 
 	if (val != IMX355_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+		dev_err(imx355->dev, "chip id mismatch: %x!=%x",
 			IMX355_CHIP_ID, val);
 		return -EIO;
 	}
@@ -1519,7 +1517,6 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
 /* Initialize control handlers */
 static int imx355_init_controls(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 exposure_max;
@@ -1600,11 +1597,11 @@ static int imx355_init_controls(struct imx355 *imx355)
 				     0, 0, imx355_test_pattern_menu);
 	if (ctrl_hdlr->error) {
 		ret = ctrl_hdlr->error;
-		dev_err(&client->dev, "control init failed: %d", ret);
+		dev_err(imx355->dev, "control init failed: %d", ret);
 		goto error;
 	}
 
-	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	ret = v4l2_fwnode_device_parse(imx355->dev, &props);
 	if (ret)
 		goto error;
 
@@ -1689,6 +1686,8 @@ static int imx355_probe(struct i2c_client *client)
 	if (!imx355)
 		return -ENOMEM;
 
+	imx355->dev = &client->dev;
+
 	mutex_init(&imx355->mutex);
 
 	/* Initialize subdev */
@@ -1697,13 +1696,13 @@ static int imx355_probe(struct i2c_client *client)
 	/* Check module identity */
 	ret = imx355_identify_module(imx355);
 	if (ret) {
-		dev_err(&client->dev, "failed to find sensor: %d", ret);
+		dev_err(imx355->dev, "failed to find sensor: %d", ret);
 		goto error_probe;
 	}
 
-	imx355->hwcfg = imx355_get_hwcfg(&client->dev);
+	imx355->hwcfg = imx355_get_hwcfg(imx355->dev);
 	if (!imx355->hwcfg) {
-		dev_err(&client->dev, "failed to get hwcfg");
+		dev_err(imx355->dev, "failed to get hwcfg");
 		ret = -ENODEV;
 		goto error_probe;
 	}
@@ -1713,7 +1712,7 @@ static int imx355_probe(struct i2c_client *client)
 
 	ret = imx355_init_controls(imx355);
 	if (ret) {
-		dev_err(&client->dev, "failed to init controls: %d", ret);
+		dev_err(imx355->dev, "failed to init controls: %d", ret);
 		goto error_probe;
 	}
 
@@ -1728,7 +1727,7 @@ static int imx355_probe(struct i2c_client *client)
 	imx355->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&imx355->sd.entity, 1, &imx355->pad);
 	if (ret) {
-		dev_err(&client->dev, "failed to init entity pads: %d", ret);
+		dev_err(imx355->dev, "failed to init entity pads: %d", ret);
 		goto error_handler_free;
 	}
 
@@ -1736,9 +1735,9 @@ static int imx355_probe(struct i2c_client *client)
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
 	 */
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_enable(&client->dev);
-	pm_runtime_idle(&client->dev);
+	pm_runtime_set_active(imx355->dev);
+	pm_runtime_enable(imx355->dev);
+	pm_runtime_idle(imx355->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
 	if (ret < 0)
@@ -1747,8 +1746,8 @@ static int imx355_probe(struct i2c_client *client)
 	return 0;
 
 error_media_entity_runtime_pm:
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(imx355->dev);
+	pm_runtime_set_suspended(imx355->dev);
 	media_entity_cleanup(&imx355->sd.entity);
 
 error_handler_free:
@@ -1769,8 +1768,8 @@ static void imx355_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(imx355->dev);
+	pm_runtime_set_suspended(imx355->dev);
 
 	mutex_destroy(&imx355->mutex);
 }
-- 
2.53.0

