Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314599;
	b=GZk7GfxGNy0QlChz0PUQXblcol1PtEvSHH5pQxeOYDOGGjSvB4K6E/hJxnhxQYRmocWO
	 qa3ExW4VwagHRcDKyTqhOEqJsOKGYfMEL3gOw+4tIe2h2VQk0SnhF8cFYpNEI3xTvwdPT
	 Ircg3hXN6KPFYumO7ibz5AymrH9bhmG/5b8XBA1Rh4pj6KhZ4wFLR0reKwfkn1sHtgnMd
	 0XexhwzMV6x6ZmyZtE0SGsyD32AxVtti8ypcJTzvMHM92JkuiPA5B2J2FURY5FRivNhWC
	 V4lim+5eqttYq9UjcQTfs1bgBXBywca79MFRflcnzz/eNxZ98ypIQ007ypVRebbXZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2L9yxo5x5uqG0ZvYEMS7+gtZhWQlc+QJ/+eJbraGTeE=;
	b=W4wXB/Mu7y+821bUVI6P6fsD+Y6SLjfqCekPT5BBcw2ttOMN3EQ3WgKPLJ/+1BciHYpd
	 +i/qOwXQoIMfO1iWzW8hkzsUvfErwOE/ZSHk69tddaJeRMMDzLmtchkh5SYmCf/obJu+H
	 t4J8zHLZ0ncZHSLvTPVbt+qwrWF7qVdqC0xTHghHaALK/iCWqjtVBU5PExNJF/zuBnBrk
	 voxS1C+btbUlKRAc1uHESWP2EBrOemmV7qe3PPlfkSRgIoq0WITpvppl3+FC1f/upgEhy
	 TgH7elR2xA0vhJ5OYKFk3RP2AAqtjOSaQaBZ7PyZZco4qbpPL9KRSFlTLfRVIQBOKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3TTAndu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3TTAndu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6311F0089F;
	Tue, 10 Nov 2026 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314598;
	bh=2L9yxo5x5uqG0ZvYEMS7+gtZhWQlc+QJ/+eJbraGTeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3TTAndu1Oil519ZdpXg14Kn18H629/4hXfRw8Nqy3vWiPO6BKIS3lg4w648jmnJt
	 gGzXjhfT1u2XPallYa7ckgsG7LhbIOzmCIkK0wL4/oAATqJ5g+bN1IS0HVlpn25Tki
	 XEKrSI+l5XKrB21crFwgS0NK5O5GZr8F80ViTZB7cHVYDpCzth81N4Lvt3bh4E/E/O
	 KT6zsOSjrwuD/46TdVTwPYZhuiLvGUv7y2se3xthsbuFWn9EGnVjSd3ldElnyjWDCA
	 Zh2n5lBQ+GomuJRXMDcBuIhDWCT+V5jcefsS7/MpIHgCNFYXIqRRDwluFQ6ozngi+V
	 fFYgFuHD63AfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: i2c: og01a1b: Switch from .s_stream to .enable_streams/.disable_streams
Date: Tue, 10 Nov 2026 07:43:15 -0500
Message-ID: <20261110124246.1444734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050650-failed-6.18-a26c5ac46191@kernel.org>
References: <20261107050650-failed-6.18-a26c5ac46191@kernel.org>
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

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 3a594bb454ba1ecb005f753007fa1bb5c5e68bae ]

The change allows to simplify the driver code, in particular the explicit
locking scheme for stream on/off or format update serialization can be
dropped in favour to the one provided by the V4L2 core internals.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
[Sakari Ailus: Fix error handling for enable_streams callback.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: a26c5ac46191 ("media: i2c: og01a1b: power off sensor on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/og01a1b.c | 90 ++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 7b892b26203c0..4b6b9ac24594b 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -442,9 +442,6 @@ struct og01a1b {
 
 	/* Current mode */
 	const struct og01a1b_mode *cur_mode;
-
-	/* To serialize asynchronus callbacks */
-	struct mutex mutex;
 };
 
 static u64 to_pixel_rate(u32 f_index)
@@ -616,7 +613,6 @@ static int og01a1b_init_controls(struct og01a1b *og01a1b)
 	if (ret)
 		return ret;
 
-	ctrl_hdlr->lock = &og01a1b->mutex;
 	og01a1b->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr,
 						    &og01a1b_ctrl_ops,
 						    V4L2_CID_LINK_FREQ,
@@ -686,74 +682,66 @@ static void og01a1b_update_pad_format(const struct og01a1b_mode *mode,
 	fmt->field = V4L2_FIELD_NONE;
 }
 
-static int og01a1b_start_streaming(struct og01a1b *og01a1b)
+static int og01a1b_enable_streams(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state, u32 pad,
+				  u64 streams_mask)
 {
+	struct og01a1b *og01a1b = to_og01a1b(sd);
+	unsigned int link_freq_index = og01a1b->cur_mode->link_freq_index;
 	const struct og01a1b_reg_list *reg_list;
-	int link_freq_index, ret;
+	int ret;
 
-	link_freq_index = og01a1b->cur_mode->link_freq_index;
-	reg_list = &link_freq_configs[link_freq_index].reg_list;
+	ret = pm_runtime_resume_and_get(og01a1b->dev);
+	if (ret)
+		return ret;
 
+	reg_list = &link_freq_configs[link_freq_index].reg_list;
 	ret = og01a1b_write_reg_list(og01a1b, reg_list);
 	if (ret) {
-		dev_err(og01a1b->dev, "failed to set plls");
-		return ret;
+		dev_err(og01a1b->dev, "failed to set plls: %d\n", ret);
+		goto error;
 	}
 
 	reg_list = &og01a1b->cur_mode->reg_list;
 	ret = og01a1b_write_reg_list(og01a1b, reg_list);
 	if (ret) {
-		dev_err(og01a1b->dev, "failed to set mode");
-		return ret;
+		dev_err(og01a1b->dev, "failed to set mode: %d\n", ret);
+		goto error;
 	}
 
 	ret = __v4l2_ctrl_handler_setup(og01a1b->sd.ctrl_handler);
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = og01a1b_write_reg(og01a1b, OG01A1B_REG_MODE_SELECT,
 				OG01A1B_REG_VALUE_08BIT,
 				OG01A1B_MODE_STREAMING);
 	if (ret) {
-		dev_err(og01a1b->dev, "failed to set stream");
-		return ret;
+		dev_err(og01a1b->dev, "failed to start streaming: %d\n", ret);
+		goto error;
 	}
 
 	return 0;
-}
 
-static void og01a1b_stop_streaming(struct og01a1b *og01a1b)
-{
-	if (og01a1b_write_reg(og01a1b, OG01A1B_REG_MODE_SELECT,
-			      OG01A1B_REG_VALUE_08BIT, OG01A1B_MODE_STANDBY))
-		dev_err(og01a1b->dev, "failed to set stream");
+error:
+	pm_runtime_put_autosuspend(og01a1b->dev);
+
+	return ret;
 }
 
-static int og01a1b_set_stream(struct v4l2_subdev *sd, int enable)
+static int og01a1b_disable_streams(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state, u32 pad,
+				   u64 streams_mask)
 {
 	struct og01a1b *og01a1b = to_og01a1b(sd);
-	int ret = 0;
-
-	mutex_lock(&og01a1b->mutex);
-	if (enable) {
-		ret = pm_runtime_resume_and_get(og01a1b->dev);
-		if (ret) {
-			mutex_unlock(&og01a1b->mutex);
-			return ret;
-		}
+	int ret;
 
-		ret = og01a1b_start_streaming(og01a1b);
-		if (ret) {
-			enable = 0;
-			og01a1b_stop_streaming(og01a1b);
-			pm_runtime_put(og01a1b->dev);
-		}
-	} else {
-		og01a1b_stop_streaming(og01a1b);
-		pm_runtime_put(og01a1b->dev);
-	}
+	ret = og01a1b_write_reg(og01a1b, OG01A1B_REG_MODE_SELECT,
+				OG01A1B_REG_VALUE_08BIT, OG01A1B_MODE_STANDBY);
+	if (ret)
+		dev_err(og01a1b->dev, "failed to stop streaming: %d\n", ret);
 
-	mutex_unlock(&og01a1b->mutex);
+	pm_runtime_put_autosuspend(og01a1b->dev);
 
 	return ret;
 }
@@ -771,7 +759,6 @@ static int og01a1b_set_format(struct v4l2_subdev *sd,
 				      height, fmt->format.width,
 				      fmt->format.height);
 
-	mutex_lock(&og01a1b->mutex);
 	og01a1b_update_pad_format(mode, &fmt->format);
 	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
 		*v4l2_subdev_state_get_format(sd_state, fmt->pad) = fmt->format;
@@ -794,8 +781,6 @@ static int og01a1b_set_format(struct v4l2_subdev *sd,
 					 h_blank);
 	}
 
-	mutex_unlock(&og01a1b->mutex);
-
 	return 0;
 }
 
@@ -805,15 +790,12 @@ static int og01a1b_get_format(struct v4l2_subdev *sd,
 {
 	struct og01a1b *og01a1b = to_og01a1b(sd);
 
-	mutex_lock(&og01a1b->mutex);
 	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY)
 		fmt->format = *v4l2_subdev_state_get_format(sd_state,
 							    fmt->pad);
 	else
 		og01a1b_update_pad_format(og01a1b->cur_mode, &fmt->format);
 
-	mutex_unlock(&og01a1b->mutex);
-
 	return 0;
 }
 
@@ -849,18 +831,14 @@ static int og01a1b_enum_frame_size(struct v4l2_subdev *sd,
 
 static int og01a1b_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 {
-	struct og01a1b *og01a1b = to_og01a1b(sd);
-
-	mutex_lock(&og01a1b->mutex);
 	og01a1b_update_pad_format(&supported_modes[0],
 				  v4l2_subdev_state_get_format(fh->state, 0));
-	mutex_unlock(&og01a1b->mutex);
 
 	return 0;
 }
 
 static const struct v4l2_subdev_video_ops og01a1b_video_ops = {
-	.s_stream = og01a1b_set_stream,
+	.s_stream = v4l2_subdev_s_stream_helper,
 };
 
 static const struct v4l2_subdev_pad_ops og01a1b_pad_ops = {
@@ -868,6 +846,8 @@ static const struct v4l2_subdev_pad_ops og01a1b_pad_ops = {
 	.get_fmt = og01a1b_get_format,
 	.enum_mbus_code = og01a1b_enum_mbus_code,
 	.enum_frame_size = og01a1b_enum_frame_size,
+	.enable_streams = og01a1b_enable_streams,
+	.disable_streams = og01a1b_disable_streams,
 };
 
 static const struct v4l2_subdev_ops og01a1b_subdev_ops = {
@@ -1046,7 +1026,6 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
-	mutex_destroy(&og01a1b->mutex);
 }
 
 static int og01a1b_probe(struct i2c_client *client)
@@ -1135,7 +1114,6 @@ static int og01a1b_probe(struct i2c_client *client)
 		goto power_off;
 	}
 
-	mutex_init(&og01a1b->mutex);
 	og01a1b->cur_mode = &supported_modes[0];
 	ret = og01a1b_init_controls(og01a1b);
 	if (ret) {
@@ -1143,6 +1121,7 @@ static int og01a1b_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	og01a1b->sd.state_lock = og01a1b->ctrl_handler.lock;
 	og01a1b->sd.internal_ops = &og01a1b_internal_ops;
 	og01a1b->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	og01a1b->sd.entity.ops = &og01a1b_subdev_entity_ops;
@@ -1183,7 +1162,6 @@ static int og01a1b_probe(struct i2c_client *client)
 
 probe_error_v4l2_ctrl_handler_free:
 	v4l2_ctrl_handler_free(og01a1b->sd.ctrl_handler);
-	mutex_destroy(&og01a1b->mutex);
 
 power_off:
 	og01a1b_power_off(og01a1b->dev);
-- 
2.53.0

