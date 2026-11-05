Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839756;
	b=sl/VCW4ERLNQbK/HHbzguiAy/kCUwS+1hPZhisDn4xclEtnt1hP6npyUfelqq1gEuOp+
	 J2jp0jueKVOdUkyZePGLsYVFY92DQDks57/Sssq0nTYAMPodyPahPhnC8FdinOdr7CTeW
	 42CMD/b+Uj/F9GAlJUGCwSKdEgqpzxHA8urfZDiGPA9GM0vMuHrY5Iab044oRIEGepzFl
	 w8GapzP74SkentNcVIFZeJvim7yRWqZ/gME1BtGqkBpHmTTt84Mgcza7BF+2jCTZO79wx
	 EQ4TBBq3gLhmOhgyMZIOP5VyUlWpo6G7MvgtJ3bDSM79ODWxSVLScBY/AgWdzZEE86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CpS7GLzyshZWps/kEoS9IRvjJQudydLT99khEiIz7VU=;
	b=jTavBFL/SawjlfDBtlVKGf7Wn7ZHvkpUCixVrrDjS31ElkDB03YkP4IxMdx7eGedssKI
	 +S7tNU+DYZp+KCHdIF11NaEV4DFdb6WjasWVgmnzblSwXP01qmZFQbn1A9wrXZekiTBeb
	 brvrywXGe+nkkRzVYFSudE25xdVSrVM0tSwRp/vJXpdwPuPDXX4aCrz+n9aeUun9Uh6nx
	 NakiMggZIUOyklsjCiDVR8dmFdxjfINyfrzF1q2wRQc+qPvH3luOaAf110XhBHvuzMcyC
	 8VvI9Upx0o95lEuQ03v7f2uvgnEyhZCC8Gqqmi9VZlRRREha3a0/9Mb/Kyrbr3i28Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSyi771a;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C0606A33A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A6C0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSyi771a
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so10524825e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 16:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793839754; x=1794444554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CpS7GLzyshZWps/kEoS9IRvjJQudydLT99khEiIz7VU=;
        b=jSyi771aSl1Rx4d1iTMMy3LLn2WobFNClF7Q1jPZHE35svH+Jbwk210AN47Q0QgFmf
         v1iILxJ9rIsDPBJx08DuZvs9EIvPWwS3vS6Gu2GpdwsIyZWm1t6KYXQ/Gz7caJgQQ+Eu
         +XkJaUkzQ3HcYhk9t8vR1Gu8cKoJ5/LUzhhwHHLkRPmHJTHrcfe+XG/Vx7515l+X2EtW
         OcW5VZ1a5WMrFgX8e+KntpjbaTPnjdUC3bH68LgZkEZDPDMcjtUrfxOC8dJGc52w1XtV
         n+0PBCqYiqPuOsokZsH/7HIBO86FPRYzLwbnrr4dyjWIInPpFANRcdTdih4prlSqG+CP
         e4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839754; x=1794444554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CpS7GLzyshZWps/kEoS9IRvjJQudydLT99khEiIz7VU=;
        b=pAjO5woC4dbftSpD1TIbxiz1R2GE1kOZql46nlBeWfVsTInmI8BHi1UcC0QBLfAI+Q
         7+2VbBVdBHIYHepeRX/CPddi9pfCCtx97jYG5qwUfCZiF5PBLI/cwSZzQt69Zj5Shfw1
         tvNHF+ScsPBGhvVE9kGTaLncP1WPCh+4OK1AeMeZu/iq3M6Zti6syucCMxnnQPYiAGFh
         sJN6LU0/JU/B/f3sHH+avjwQW9TKy5rju6uR/vYXlvx7/zIl8wj+EbDPD9SwwzGXRZ6D
         sjr+X/DVXCKLZkOrVQH7wt1SVyTaZPwuB02DSTuTabI6jY5LqYeVd+djKD0CxYXH0reO
         BmfQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6iyVxuId7b9Co214vKFXu3UZB3Glpry2fgjDnLmeilTRYQ3wvAqEbeADKvbLZbrYjCItZO7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QXbyw181fbVf99rdKbewCp6ZCSLZkWGtl2bi1tAbRro4DlhdR
	9LNpZLuCGp4ZGqI6D+eI5wUrO+iMc6886nuqkq5QBqrLwO5deanhoAn3
X-Gm-Gg: AYBFou1Auon/2Zkqri7Y09mKLWOHPdgPI/lka7Msk98YtrdpvREGu6xdlo0rksXufE1
	DgDqUtaDrzjkN5HmPTMG4zXPBMmkkylPHiPNsAeoP1h4new6qXBmkkugmOJirkuyCVfksOykzzA
	JYYR+ZUW4dsrxBEav4FQBn8V5rT/SgXQIfAbjE1/5m8keYZ1kYFI7mLpiaEjMA1lbZg0t2mDwAW
	XzMr/lGSIze+W9SrWtByFihdIe3XU16gKzm35mc4+lX0eYgDxwnRsDi+be1pQGWTmNsQOPKPVVu
	4b4O3aj0niMGGDczl+4lwmB2CCCX+yDNztDldpCtEsC54JP15ccGg4tRwV0+/7rlgG9vLFs0age
	jM/U9yNsWWfYrxqC5Ebpn8V8Nm9mv7UFpxSjjpB8dvcgFWVGU9EfotUwEHZkfI1jFbpnpcBrHIo
	l9yZKPtc7SGnxHQ5R/wWAWf7dImJQv/vEfNJXF3krSpANZhqV2I+YJFaa+T+mIjTdAvc28b1HqN
	J7/OSnFend9Wpf1aQRAHPeWAvoccwFEMVqRK3GO0IciOjKVg3H8OEHyplviTqdYbzDejb5E8e/b
	2L66oercEZjsiLOR5qhbV7vGj0DuAfcxp6129Rxh0U/F5/wYGlQIac5AjDLfi8++EXCaF18MA9R
	BX7GCCKs3KQ==
X-Received: by 2002:a05:600c:6087:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4ac1765ce52mr372660305e9.20.1793839754380;
        Wed, 04 Nov 2026 16:49:14 -0800 (PST)
Received: from raviolimobile.tail5f26fd.ts.net ([84.70.180.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba0f3sm21341515e9.9.2026.11.04.16.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:49:13 -0800 (PST)
From: Fernando Rimoli <fernandorimoli11@gmail.com>
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>
Cc: Fernando Rimoli <fernandorimoli11@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hans@jjverkuil.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] media: i2c: vd55g1: Use the control handler lock for the subdev state
Date: Thu,  5 Nov 2026 00:49:05 +0000
Message-ID: <20261105004907.150545-3-fernandorimoli11@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105004907.150545-1-fernandorimoli11@gmail.com>
References: <20261105004907.150545-1-fernandorimoli11@gmail.com>
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

vd55g1_subdev_init() sets sd.state_lock to ctrl_handler.lock before the
control handler is initialised, while the pointer is still NULL, so the
subdev state gets a mutex of its own. vd55g1_s_ctrl() under
VIDIOC_S_CTRL, and __v4l2_ctrl_modify_range() and
__v4l2_ctrl_handler_setup() under set_fmt and enable_streams, then run
without the lock they assert, and format and control changes can race.

Initialise the controls first and finalise last. The blanking ranges
depend on the format, so set them, and the default frame length, once
the active state exists. vd55g1_grab_ctrls() now runs with the lock
held, so use __v4l2_ctrl_grab().

With the control handler set, v4l2_subdev_init_finalize() also enables
control events, which v4l2-compliance reported missing.

Fixes: e56616d7b23c ("media: i2c: Add driver for ST VD55G1 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Fernando Rimoli <fernandorimoli11@gmail.com>
---
 drivers/media/i2c/vd55g1.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/media/i2c/vd55g1.c b/drivers/media/i2c/vd55g1.c
index 69ffb3a..9f737ea 100644
--- a/drivers/media/i2c/vd55g1.c
+++ b/drivers/media/i2c/vd55g1.c
@@ -1113,10 +1113,10 @@ static int vd55g1_ro_ctrls_setup(struct vd55g1 *sensor, struct v4l2_rect *crop)
 static void vd55g1_grab_ctrls(struct vd55g1 *sensor, bool enable)
 {
 	/* These settings cannot change during stream */
-	v4l2_ctrl_grab(sensor->hflip_ctrl, enable);
-	v4l2_ctrl_grab(sensor->vflip_ctrl, enable);
-	v4l2_ctrl_grab(sensor->patgen_ctrl, enable);
-	v4l2_ctrl_grab(sensor->hdr_ctrl, enable);
+	__v4l2_ctrl_grab(sensor->hflip_ctrl, enable);
+	__v4l2_ctrl_grab(sensor->vflip_ctrl, enable);
+	__v4l2_ctrl_grab(sensor->patgen_ctrl, enable);
+	__v4l2_ctrl_grab(sensor->hdr_ctrl, enable);
 }
 
 static int vd55g1_enable_streams(struct v4l2_subdev *sd,
@@ -1580,14 +1580,6 @@ static int vd55g1_init_ctrls(struct vd55g1 *sensor)
 	struct v4l2_ctrl_handler *hdl = &sensor->ctrl_handler;
 	struct v4l2_ctrl *ctrl;
 	struct v4l2_fwnode_device_properties fwnode_props;
-	struct vd55g1_vblank_limits vblank;
-	unsigned int hblank;
-	struct v4l2_subdev_state *state =
-		v4l2_subdev_lock_and_get_active_state(&sensor->sd);
-	struct v4l2_rect *crop =
-		v4l2_subdev_state_get_crop(state, 0);
-	struct v4l2_mbus_framefmt *format =
-		v4l2_subdev_state_get_format(state, 0);
 	int ret;
 
 	v4l2_ctrl_handler_init(hdl, 16);
@@ -1645,15 +1637,13 @@ static int vd55g1_init_ctrls(struct vd55g1 *sensor)
 					     V4L2_CID_HDR_SENSOR_MODE,
 					     ARRAY_SIZE(vd55g1_hdr_menu) - 1, 0,
 					     VD55G1_NO_HDR, vd55g1_hdr_menu);
-	hblank = vd55g1_get_hblank_min(sensor, format, crop);
+	/* Placeholder ranges, set from the format in vd55g1_subdev_init() */
 	sensor->hblank_ctrl = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HBLANK,
-						hblank, hblank, 1, hblank);
+						1, 1, 1, 1);
 	if (sensor->hblank_ctrl)
 		sensor->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	vd55g1_get_vblank_limits(sensor, crop, &vblank);
 	sensor->vblank_ctrl = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_VBLANK,
-						vblank.min, vblank.max,
-						1, vblank.def);
+						1, 1, 1, 1);
 
 	/* Additional controls based on device tree properties */
 	if (sensor->ext_leds_mask) {
@@ -1673,12 +1663,11 @@ static int vd55g1_init_ctrls(struct vd55g1 *sensor)
 		goto free_ctrls;
 
 	sensor->sd.ctrl_handler = hdl;
-	goto unlock_state;
+
+	return 0;
 
 free_ctrls:
 	v4l2_ctrl_handler_free(hdl);
-unlock_state:
-	v4l2_subdev_unlock_state(state);
 	return ret;
 }
 
@@ -1915,6 +1904,9 @@ static int vd55g1_parse_dt(struct vd55g1 *sensor)
 
 static int vd55g1_subdev_init(struct vd55g1 *sensor)
 {
+	struct v4l2_subdev_state *state;
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_rect *crop;
 	int ret;
 
 	/* Init sub device */
@@ -1930,6 +1922,14 @@ static int vd55g1_subdev_init(struct vd55g1 *sensor)
 		return ret;
 	}
 
+	ret = vd55g1_init_ctrls(sensor);
+	if (ret) {
+		dev_err(sensor->dev, "Controls initialization failed %d\n",
+			ret);
+		goto err_media;
+	}
+
+	/* The state shares the control handler lock, so finalize last */
 	sensor->sd.state_lock = sensor->ctrl_handler.lock;
 	ret = v4l2_subdev_init_finalize(&sensor->sd);
 	if (ret) {
@@ -1937,19 +1937,24 @@ static int vd55g1_subdev_init(struct vd55g1 *sensor)
 		goto err_ctrls;
 	}
 
-	/*
-	 * Initialize controls after v4l2_subdev_init_finalize() to make sure
-	 * active state is set
-	 */
-	ret = vd55g1_init_ctrls(sensor);
+	/* Set the format dependent ranges and the default frame length */
+	state = v4l2_subdev_lock_and_get_active_state(&sensor->sd);
+	format = v4l2_subdev_state_get_format(state, 0);
+	crop = v4l2_subdev_state_get_crop(state, 0);
+	ret = vd55g1_new_format_change_controls(sensor, format, crop);
+	if (!ret)
+		ret = __v4l2_ctrl_s_ctrl(sensor->vblank_ctrl,
+					 sensor->vblank_ctrl->default_value);
+	v4l2_subdev_unlock_state(state);
 	if (ret) {
-		dev_err(sensor->dev, "Controls initialization failed %d\n",
-			ret);
-		goto err_media;
+		dev_err(sensor->dev, "Controls update failed %d\n", ret);
+		goto err_state;
 	}
 
 	return 0;
 
+err_state:
+	v4l2_subdev_cleanup(&sensor->sd);
 err_ctrls:
 	v4l2_ctrl_handler_free(sensor->sd.ctrl_handler);
 
-- 
2.43.0

