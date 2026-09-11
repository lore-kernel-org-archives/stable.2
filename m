Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A73176EE
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136033; cv=none; b=RiSxAcsH0HiC63fGDcnYGH7LNa8x3i5MrDKoYO/BMIHZHRkYRMVJlx/lKsyQn2urTr4AGVtW7WdoBY0B3ydUxpNarVY3bgCDH02tp4QX0r+JsDCoG6o00St0023oYAjcyRXE2SJBYRmnExM75u8uywGp2eajRLq+ijA20jxf4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136033; c=relaxed/simple;
	bh=GWb+Uh6q/ROm7cxme2Ng2alA0gkOH2EAvbCgZCh0oJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0M8QpyAEITvoZwShaKP7T1w+K9bIa5D2Z2fp0k79m8xEXah2p9ze50vulivhqqxV9ART0dxwe+bI1pL7U2AzjUcX8M5sHpi5e5pLGau7lgwuBhxqNgMWod07toG6EaRBLYHKr/XiPdVHeWsDxpWmOSUFAGWjcSPNVUHVHbYWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSCXbVRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSCXbVRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B991F008A2;
	Fri, 11 Sep 2026 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136031;
	bh=mZrz2w3eaDDUlgHaK66m2Yybg/cf5QCnwqy/tP761pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSCXbVRzquqHwOxiqWTxozjdUn7KpwuNmVDFzuNDp2JGL4SQInpf2Azn9LZ4px/KN
	 PJie4S4yKgRc+Oxc+ww6LNdfC8d71DO2EuEQKd3b0g5qbcrp/J/ZfhqeGHQVtnCkJP
	 w9qqixjfexbSPlE/1dQ98AmlKL+jrDUQno3imUrhyPdekbhFTZQHw1VTKd/Mpfcn6H
	 OI9kyjzQISszD5AoIglDDBRpK/BY3ff0zleWXLpDrUCh28RvoqxZE6kgwVmwcsn2H9
	 lOLF1rkxUqeGTlP8q8KDw7IFot8A4vTShMWQ59h+7pgv2dM0GLDIs2KPvF740CyaDA
	 wZYwUNu+tR8oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: i2c: imx355: Replace client->dev usage
Date: Fri, 11 Sep 2026 10:13:48 -0400
Message-ID: <20260911141349.763256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090913-pedigree-concerned-351d@gregkh>
References: <2026090913-pedigree-concerned-351d@gregkh>
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

For the 6.6 backport, retain <asm/unaligned.h>: this tree does not have
<linux/unaligned.h>. Drop the firmware-property parsing hunk and its
properties declaration, since the corresponding control support is absent
from this driver. Remove the now-unused client local in control setup.
Also convert the two link-frequency diagnostics retained in this tree.

Keep the device pointer initialized immediately after allocation and
convert the runtime-PM calls, providing the context needed to apply
commit ee737bc3ccae7dc713ccaa83ffa46080c6031b3e unchanged. Preserve the
existing streaming and system-sleep handling; no functions are added.

Stable-dep-of: ee737bc3ccae ("media: imx355: Avoid calling imx355_power_off twice in error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx355.c | 60 ++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index f49fc5663d221..d5c3232e3ee7e 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -98,6 +98,8 @@ struct imx355_hwcfg {
 };
 
 struct imx355 {
+	struct device *dev;
+
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
@@ -1138,14 +1140,13 @@ static int imx355_write_reg(struct imx355 *imx355, u16 reg, u32 len, u32 val)
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
 
@@ -1180,7 +1181,6 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct imx355 *imx355 = container_of(ctrl->handler,
 					     struct imx355, ctrl_handler);
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	s64 max;
 	int ret;
 
@@ -1199,7 +1199,7 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
 	 * Applying V4L2 control value only happens
 	 * when power is up for streaming
 	 */
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	if (!pm_runtime_get_if_in_use(imx355->dev))
 		return 0;
 
 	switch (ctrl->id) {
@@ -1233,12 +1233,12 @@ static int imx355_set_ctrl(struct v4l2_ctrl *ctrl)
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
@@ -1388,7 +1388,6 @@ imx355_set_pad_format(struct v4l2_subdev *sd,
 /* Start streaming */
 static int imx355_start_streaming(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	const struct imx355_reg_list *reg_list;
 	int ret;
 
@@ -1396,7 +1395,7 @@ static int imx355_start_streaming(struct imx355 *imx355)
 	reg_list = &imx355_global_setting;
 	ret = imx355_write_regs(imx355, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
-		dev_err(&client->dev, "failed to set global settings");
+		dev_err(imx355->dev, "failed to set global settings");
 		return ret;
 	}
 
@@ -1404,7 +1403,7 @@ static int imx355_start_streaming(struct imx355 *imx355)
 	reg_list = &imx355->cur_mode->reg_list;
 	ret = imx355_write_regs(imx355, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
-		dev_err(&client->dev, "failed to set mode");
+		dev_err(imx355->dev, "failed to set mode");
 		return ret;
 	}
 
@@ -1432,7 +1431,6 @@ static int imx355_stop_streaming(struct imx355 *imx355)
 static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct imx355 *imx355 = to_imx355(sd);
-	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	int ret = 0;
 
 	mutex_lock(&imx355->mutex);
@@ -1442,7 +1440,7 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (enable) {
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(imx355->dev);
 		if (ret < 0)
 			goto err_unlock;
 
@@ -1455,7 +1453,7 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 			goto err_rpm_put;
 	} else {
 		imx355_stop_streaming(imx355);
-		pm_runtime_put(&client->dev);
+		pm_runtime_put(imx355->dev);
 	}
 
 	imx355->streaming = enable;
@@ -1469,7 +1467,7 @@ static int imx355_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 
 err_rpm_put:
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(imx355->dev);
 err_unlock:
 	mutex_unlock(&imx355->mutex);
 
@@ -1510,7 +1508,6 @@ static int __maybe_unused imx355_resume(struct device *dev)
 /* Verify chip ID */
 static int imx355_identify_module(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	int ret;
 	u32 val;
 
@@ -1519,7 +1516,7 @@ static int imx355_identify_module(struct imx355 *imx355)
 		return ret;
 
 	if (val != IMX355_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+		dev_err(imx355->dev, "chip id mismatch: %x!=%x",
 			IMX355_CHIP_ID, val);
 		return -EIO;
 	}
@@ -1559,7 +1556,6 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
 /* Initialize control handlers */
 static int imx355_init_controls(struct imx355 *imx355)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 exposure_max;
 	s64 vblank_def;
@@ -1635,7 +1631,7 @@ static int imx355_init_controls(struct imx355 *imx355)
 				     0, 0, imx355_test_pattern_menu);
 	if (ctrl_hdlr->error) {
 		ret = ctrl_hdlr->error;
-		dev_err(&client->dev, "control init failed: %d", ret);
+		dev_err(imx355->dev, "control init failed: %d", ret);
 		goto error;
 	}
 
@@ -1727,6 +1723,8 @@ static int imx355_probe(struct i2c_client *client)
 	if (!imx355)
 		return -ENOMEM;
 
+	imx355->dev = &client->dev;
+
 	mutex_init(&imx355->mutex);
 
 	/* Initialize subdev */
@@ -1735,13 +1733,13 @@ static int imx355_probe(struct i2c_client *client)
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
@@ -1749,13 +1747,13 @@ static int imx355_probe(struct i2c_client *client)
 	imx355->link_def_freq = link_freq_menu_items[IMX355_LINK_FREQ_INDEX];
 	for (i = 0; i < imx355->hwcfg->nr_of_link_freqs; i++) {
 		if (imx355->hwcfg->link_freqs[i] == imx355->link_def_freq) {
-			dev_dbg(&client->dev, "link freq index %d matched", i);
+			dev_dbg(imx355->dev, "link freq index %d matched", i);
 			break;
 		}
 	}
 
 	if (i == imx355->hwcfg->nr_of_link_freqs) {
-		dev_err(&client->dev, "no link frequency supported");
+		dev_err(imx355->dev, "no link frequency supported");
 		ret = -EINVAL;
 		goto error_probe;
 	}
@@ -1765,7 +1763,7 @@ static int imx355_probe(struct i2c_client *client)
 
 	ret = imx355_init_controls(imx355);
 	if (ret) {
-		dev_err(&client->dev, "failed to init controls: %d", ret);
+		dev_err(imx355->dev, "failed to init controls: %d", ret);
 		goto error_probe;
 	}
 
@@ -1780,7 +1778,7 @@ static int imx355_probe(struct i2c_client *client)
 	imx355->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&imx355->sd.entity, 1, &imx355->pad);
 	if (ret) {
-		dev_err(&client->dev, "failed to init entity pads: %d", ret);
+		dev_err(imx355->dev, "failed to init entity pads: %d", ret);
 		goto error_handler_free;
 	}
 
@@ -1788,9 +1786,9 @@ static int imx355_probe(struct i2c_client *client)
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
@@ -1799,8 +1797,8 @@ static int imx355_probe(struct i2c_client *client)
 	return 0;
 
 error_media_entity_runtime_pm:
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(imx355->dev);
+	pm_runtime_set_suspended(imx355->dev);
 	media_entity_cleanup(&imx355->sd.entity);
 
 error_handler_free:
@@ -1821,8 +1819,8 @@ static int imx355_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(imx355->dev);
+	pm_runtime_set_suspended(imx355->dev);
 
 	mutex_destroy(&imx355->mutex);
 
-- 
2.53.0

