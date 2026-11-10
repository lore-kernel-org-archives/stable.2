Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316223;
	b=k7MVgST30tsaLGw0jpcr/pI7NWbTqyhS9i7JcPSYI+aSD7au3m6Q6HTM+5oVgVKtVAyX
	 F5GHZ7896TU+AhUP6UCyKnGmDF/FfAxBzaENRVw8lCxqmTrtGQ/skiitL+NprnknnNBpm
	 ivMWlZ79IopxTuaXp4NEs/zXymU+cPhem2DA6fjLe2icpHiUgbVM98r6gkMd5YUIrQgK1
	 CFgBdtAQGW2WTGxatMaFVxofBGpEoziY/wjuL2y3GH+nNAM8wu5jI2pivfdjPDRFgWWDV
	 1VCkIvQ5e9yN69M9eNOYZzqyMMe7DgpTEQLwUTt1ZfU4u7BRDt2BrYd4OferB8DE4tQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=fQCv38k3pTCw0BrKeHRMrviBVXzFv4wgTvyadDALiDU=;
	b=tmgJejBkNTSqVmXz8fRbhgZIGkQAvMrWWSyRRLBV8E4VN1wqS8Mr+BgesMq/oPakZ2Hu
	 pchoEIgkcYyTXixz3hH+o7hGKpWfspDZr3aOkfhh1kwjTa4PJeluMvhQSQiZ1jkYryCgX
	 eMiBYxOGrpEtOiKrKvbWnge9I3ah0HUE2Xv45mfHjMi8CjrJxwlRZ31OON15EuMiejcJn
	 DzRWYu9u8NLQriFdwP6jf/TLWQ8oO22SBwiX3a6cLZarobqsrxL3shnp2ZI1sjNe0aITF
	 sHWRHsGMc4jkaT+zpL8amDNi9n1D6+1t34iNywoBPnOQTgU2F/T2ZOD/Ecl4FBzfL9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=bM2aF6u+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015A606A75E;
	Tue, 10 Nov 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=bM2aF6u+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316222;
	b=q3XoEsqjKOUAaryhmurGB3ziNCDZ9fvHb+EHU+0LhQ9Vzl6+3ysSUNN0le+56Ww8idcK
	 AJvTHDrsvb/vQ1VeLb4m/dEsj/Ldpu+DXRmpEggTjfUjB9seIAN9wnjVTuwkx6gPCtU0b
	 SgPQSAmd8Y/Tje2vRAeyPutxZus1FxkIO/B9ukRUjCTtoOmaQtXhhAI4bblC5kGKyyHuV
	 GTa89bX5Gfg4iiBkLWWt6KIQN7PJ3ZdmBDVCw0N8BLFgQDG3ZBU9N2HZFRBFsr0+ZInGy
	 7Jca/2U0YDC5vlCfBPOFecXmuEtFLz681tYe2RY0oLsP+8fG6oP97GWtP4Hwz0rAruQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=fQCv38k3pTCw0BrKeHRMrviBVXzFv4wgTvyadDALiDU=;
	b=EFzY9nj86AcKFF8zUyDKYGdJuWZjYERYyAuoClRKpE3pw2ntGsQ6JahIOaRyXq8edpSr
	 WkBfIQldUod+LxSJbrvyNk7pGQVWylLqiLNT5Zo/9nCixtZmIJFPPOWuVoUC3itLtH5NT
	 XTTpKvRE906BkqC29DSs081ZpJcbtlUC/kbJGFkKyVnJicK4An5bTNAWSTuGl/tBGW998
	 vdEEaqmar/Jl0rJxBaEh4q+/mO+83LtaWBjQz+13Oz/yVwd5+Fs+F5yaXetYdq5srKrP6
	 aOUIYVPGqVFgtk06GUCjcJ1pF8Zbdgq38ZPM1lcp/seFQGyytB3sb2cBJ/h8XX2nzEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9E4001F008A5;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316222; bh=fQCv38k3pTCw0BrKeHRMrviBVXzFv4wgTvyadDALiDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bM2aF6u+Vhav3s+UbQ7nNTSNIBo/W8qTI5agb5uIMz39+P4CjwrH6HOu73y3lk6hF
	 tV+IXVbCQyZVa8CBSwRKYTrxW7jhXmO2zGTRU1xehdCsi9dqpArolE5/bk79t6CR6f
	 MEOD03YR1HRYYsiPHKuUR/eVZQzqqMYPShLSRCJc=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2696D48B72;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:13 +0100
Subject: [PATCH v3 4/8] media: i2c: ov9282: fix flash duration range
 calculation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-ov9282-fixes-v3-4-cb6df80cbc22@linux.dev>
References: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
In-Reply-To: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Gyula Kelemen <gyula.kelemen@advasolutions.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=4577;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=usS5DrW8tPZbsTVsTMBDQAnUgGIvevUFDPNMekfxlto=;
 b=81FWcfzxPK5BwY+PG/mXwXUBb06vy+Be9+BS9XBZCVC8ctpa20wgAM544Ngbpk48aFuwrLMF5
 o7Pd0f6JcVsDiVxvcSg2j3XKM2ZKkWf/lE9kZAMA1ghEv1x8Iu2M+V5
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

The flash_duration range calculation was broken. The maximum was
calculated from the current exposure time. This limited the hardware
without a strong reason. The minimum was fixed to 0, although the
hardware treats register values 0 and 1 equally for the strobe_duration.
The default value was never calculated from the raw register value to
actual microseconds.

Furthermore the flash_duration range update sat inside
ov9282_update_exp_gain(), which ov9282_set_ctrl() only reaches if
pm_runtime_get_if_in_use() doesn't return early. So with the sensor idle
the range kept whatever value it had when it last streamed.

Fix those issues by correctly calculating the values on line time changes
(i.e. HBLANK updates) as this is the "time base" for the register value.

The maximum is chosen to be S32_MAX microseconds. This was done to keep
the code short and avoid additional back-and-forth conversions. As the
hardware allows strobe durations from 1 up to U32_MAX line times, S32_MAX
microseconds is always in this range. Line times for the supported
modes, hblank values and pixel rates may vary between ~7.5 and ~205
microseconds.

Fixes: b95d8058a2786 ("media: i2c: ov9282: implement try_ctrl for strobe_duration")
Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 9dfee500a73af..44ac2043f5651 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -514,6 +514,26 @@ static u32 ov9282_us_to_lines(struct ov9282 *ov9282, u32 duration)
 			    ov9282_line_time_ns(ov9282));
 }
 
+/**
+ * ov9282_update_ctrl_flash_duration() - Update flash_duration control range
+ * @ov9282: pointer to ov9282 device
+ *
+ * As the actual microseconds value of the flash_duration range (default,
+ * minimum, maximum) are dependent on the line time recalculate and apply them
+ * to the v4l2 property in this function.
+ *
+ * Return: 0 if successful, error code otherwise.
+ */
+static int ov9282_update_ctrl_flash_duration(struct ov9282 *ov9282)
+{
+	u32 fd_min_us = ov9282_lines_to_us(ov9282, 1);
+	u32 fd_def_us = ov9282_lines_to_us(ov9282,
+					   OV9282_STROBE_FRAME_SPAN_DEFAULT);
+
+	return __v4l2_ctrl_modify_range(ov9282->flash_duration, fd_min_us,
+					S32_MAX, 1, fd_def_us);
+}
+
 /**
  * ov9282_update_controls() - Update control ranges based on streaming mode
  * @ov9282: pointer to ov9282 device
@@ -577,12 +597,6 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
 		goto error_release_group_hold;
 
 	ret = cci_write(ov9282->regmap, OV9282_REG_AGAIN, gain, NULL);
-	if (ret)
-		goto error_release_group_hold;
-
-	ret = __v4l2_ctrl_modify_range(ov9282->flash_duration,
-				       0, exposure_us, 1,
-				       OV9282_STROBE_FRAME_SPAN_DEFAULT);
 
 error_release_group_hold:
 	ret_hold = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0, NULL);
@@ -616,6 +630,11 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 		if (ret)
 			return ret;
 		break;
+	case V4L2_CID_HBLANK:
+		ret = ov9282_update_ctrl_flash_duration(ov9282);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	/* Set controls only if sensor is in power on state */
@@ -1192,8 +1211,9 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	const struct ov9282_mode *mode = ov9282->cur_mode;
 	struct v4l2_fwnode_device_properties props;
 	u32 hblank_min;
-	u32 exposure_us;
 	u32 lpfr;
+	u32 fd_min;
+	u32 fd_def;
 	int ret;
 
 	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
@@ -1262,11 +1282,12 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 			  V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
 
-	exposure_us = ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
+	fd_min = ov9282_lines_to_us(ov9282, 1);
+	fd_def = ov9282_lines_to_us(ov9282, OV9282_STROBE_FRAME_SPAN_DEFAULT);
 	ov9282->flash_duration =
 		v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
-				  V4L2_CID_FLASH_DURATION, 0, exposure_us, 1,
-				  OV9282_STROBE_FRAME_SPAN_DEFAULT);
+				  V4L2_CID_FLASH_DURATION, fd_min, S32_MAX, 1,
+				  fd_def);
 
 	ret = v4l2_fwnode_device_parse(ov9282->dev, &props);
 	if (!ret) {

-- 
2.53.0


