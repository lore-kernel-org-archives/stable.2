Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315182;
	b=ydwrb/lSMyvZvlI/BmuWK9ux0r4r5a/MqA+0vPJV37JL09HkLDhU+BjRrz9oZLOfOLnz
	 t/x0mw4Zd5rpTay8lyY3N+7xiK9K7bUlju8XQrfEP7gsBKzc3sW4QItXEUeKP+t4KjLL5
	 YC41lyyBbI65RVt07IfW6Tfu2IrdLs0eg7HIrggV8+pJ6WczTb4m09ke8cCE7ujSjO2dW
	 ZtzjUq6m4mKzvDnUc+8StNsk7iItJY2wTOZhsObsbo1wXsI97b6VY/SBVBtcqJV2jG3/6
	 /CqEVpD+LeinbdE9AWJYYFCH29z5sYd9WTGz1CRMAsbsdZ8yPgBX2LlsORlesc6+HzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TS28Ff6lf1K7mhhAW8xkudReoccU1TzjI9w0k4KcBUo=;
	b=GeFwayRjIvgP0fK0Nl7ypdXs713ylqGbXoghCyoBmPAecjocwF8ypC8RCdqfzHBo50AS
	 4mavKTdAmHY7eKNjbFpP+2xvJEBVZQCudjNftqsOgb+LCySOFSMV5oTsR+RkYv5XTO94H
	 wzRNPqxV3le4vooNcIshGy91CFtwdyracry0WtIC2aSo6xf0I6qQIHbprLvV85vZwsdSo
	 T3W/9uPQPYnjPM4TYnO6bMLT99tm9cq8pP+MUmJE9EKuTKR95PDVsmqiEDXl+3XPeXQQf
	 GgsLhzi8WBEAx7jeyoXJLB6XSylrtwJyld4rU3g1f/zO2CSKiUt+TXL5gq/hogTibTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIKz1iIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7719606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIKz1iIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53F11F0089F;
	Tue, 10 Nov 2026 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315181;
	bh=TS28Ff6lf1K7mhhAW8xkudReoccU1TzjI9w0k4KcBUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIKz1iIwnIM12f8z9WwiSN2iUo2jBCXLXJoXck34alDAoDoALgAuAQknOy1a6IBMb
	 XAFKoQxTCpNXvJtRVzlcB+JmxVxT5tJ71J52IM8m2csR7AIUmlG4YCIl768amO6BUV
	 jzfxmIWZNUXrxP3w5U4cbnWa8Dd0edLheSgovKDBLdPi0UZkVuSd+XVpgxDSAkrwp5
	 poLomhtPoX+2dwbNMDf9qKcbSdPum36sG86Z2CiJ4VEjDGdBbLqTmz4JiT3KB/sPSs
	 AS9+LgacGA8QIxkY5ozaxDSh0tJM8sf82UIKzJ9V/5omTZUh1ecamkEUy4YCT13R5p
	 j647MLrfMY+Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: i2c: og01a1b: Switch from .s_stream to .enable_streams/.disable_streams
Date: Tue, 10 Nov 2026 07:52:58 -0500
Message-ID: <20261110125223.1528685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051703-failed-6.12-a26c5ac46191@kernel.org>
References: <20261107051703-failed-6.12-a26c5ac46191@kernel.org>
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
index 68573122cd6ee..95ead31dda278 100644
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
@@ -1062,7 +1042,6 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
-	mutex_destroy(&og01a1b->mutex);
 }
 
 static int og01a1b_probe(struct i2c_client *client)
@@ -1146,7 +1125,6 @@ static int og01a1b_probe(struct i2c_client *client)
 		goto power_off;
 	}
 
-	mutex_init(&og01a1b->mutex);
 	og01a1b->cur_mode = &supported_modes[0];
 	ret = og01a1b_init_controls(og01a1b);
 	if (ret) {
@@ -1154,6 +1132,7 @@ static int og01a1b_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	og01a1b->sd.state_lock = og01a1b->ctrl_handler.lock;
 	og01a1b->sd.internal_ops = &og01a1b_internal_ops;
 	og01a1b->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	og01a1b->sd.entity.ops = &og01a1b_subdev_entity_ops;
@@ -1194,7 +1173,6 @@ static int og01a1b_probe(struct i2c_client *client)
 
 probe_error_v4l2_ctrl_handler_free:
 	v4l2_ctrl_handler_free(og01a1b->sd.ctrl_handler);
-	mutex_destroy(&og01a1b->mutex);
 
 power_off:
 	og01a1b_power_off(og01a1b->dev);
-- 
2.53.0

