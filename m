Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837047;
	b=o6LOxH3eCH9RJ4QAz7wR2u/DUz7VkbyVuazm3Iaq9iarFalwin2VdvZhmu9JDSFnCee0
	 LdNq2NyuxmKtFZBnogVGWTOd9wCzZzCeV9RtwIIi1SnQUQfv55vtLKur1iHpPUAzzMV2a
	 0jOnmSuih1ketN4G+m7WJkxweAHnvSnTSEu0zCy2AxUhvKowZmL8VHHIe4yc4Ao1y5dfb
	 ew0YL0OCgq3Y9Ro4jC7M3o8bEupsUeMH/5WQM/Bi17kgI2p32zbFW+1A1nWQAE2IyERn7
	 8WXDrjjVJf8Qos5UdIbdp5c2Tc3ue0qBVM4OFT57xxVnUhURU/qHBByuLRcJQiuI58A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837047;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=ZqYU/CdOVTaxSDe3Qma5I7mn1C5ke/zcFg4Dh6Ee7ls=;
	b=rhGS0jPBIlU3yasW/Hmmg6jREQQlI9Uv2uNYHI8Y7vSnpB3NFnmku9uEznTv/j1IsWXB
	 2Qo2XHi9Xl+1pS9Z8FC/lstIvXrqRSMSr0eZzfw7ezZyZRU20rN5t1uZj4RJc/fAYxrRN
	 +WnscNrx0lcVjq9h3+K3UvNj3Gkccj0XL8LPgkyKEyDc5akxgOpcUowHfCa0SKmK+ydsM
	 +KJr1nCe+sFVTe45iZLirLCWc36EgkLHG2jjXW6jun98rPcJzX8gus2oNrDC8kPSDa0Cd
	 AanhwLV799j5E0g2xJA6fjmhIdUo/iqxZ8JSva00PXkFjD41VYHEtfqHICUmjwmU7zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=LDhWTB5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789460A263E;
	Mon, 16 Nov 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=LDhWTB5o
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837047;
	b=DOL5E6UXI5Q2LiaGDDuJugxtPuV9FWgYiBlZBtnIYu+vL2z1tSmgU7i43fJKOWzmmCou
	 uj57+7F5t9BphDt29K/ACrCDsLv/TMQGGgQnmFMEsVJ2VidZlBPjoyseO/XR4IK7MbSKG
	 R4DPKL1M18+fPkZtzXEfhJAru7UlaAtwzYv0p1uJ7iq0S5EKbMyipL6HddYPEeyOCXgCt
	 Yiup+JGrxIPsYKPnbtZOAKaigejthNBJoWLQX60dnyrhQp9BeF0VDoGyjR69lVQ7oHh85
	 HFbU/bsF0XPOzdVFuPvC2o9bbOqfoCQHlw/qGHn5QJTBy0m+fsFuJFv8OXjBN/wscMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837047;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=ZqYU/CdOVTaxSDe3Qma5I7mn1C5ke/zcFg4Dh6Ee7ls=;
	b=ajAhRnhbrqy5KNN5UPOBv7aKwpM5wnvCH34UU143mxC0Oqc3dDRqv1w9cQsAQ0oC7w6s
	 jV0nskuuDLp7wpe6kmaJ68z6SJucBnEKgNuzjvIKG7UYmSd9jqELt1pllkF2gpSAS85/v
	 /LykJlS9Vvd6mbaBmktTfNEIchOowmKaEGVbIscom4tdt0hdSj0HEX783fGSABWMhLxee
	 9FEnKpahnkQ2moi+lIxYPH7Y1e1PqL62urtxufhexdXgNG4MYSse3hyDdm5Ro/2I3icLH
	 6VQWy2aexTlcJldMSCZROnKmlZNbXB2SDObrlrT7WSVbAVd2/XmO6UiCjso4PTYcFoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7FB201F00923;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837046; bh=ZqYU/CdOVTaxSDe3Qma5I7mn1C5ke/zcFg4Dh6Ee7ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LDhWTB5ognMRm1frBntqCNaZN4hbo1PDyvSwkBGA1n4AUWV5vb12n9G9B6EhVBT9t
	 opT4LSIyr+CYIYie14R2acdKdIgGdXqEKgudymlC/i65vDTMNvZHSbb0ojzMPOtp5/
	 PWD3/iPnIOug3uCfuu4ubD7KGoCAnbVDVRXDz6hQ=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 09A1B4A49F;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:25 +0100
Subject: [PATCH v4 4/8] media: i2c: ov9282: fix flash duration range
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
Message-Id: <20261116-ov9282-fixes-v4-4-f78e5d415c6f@linux.dev>
References: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
In-Reply-To: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=4574;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=Ytua7gIuVqx+NlU+kp7LwCqu6f2SkTSK9DNmk9zuxE4=;
 b=WRokr3NKiCr7PrGq3MOFlSRZyxvR6E0hl+yZaId08J1VHElweenHotDxNSUH1FTr8sI2SZwwL
 56mtsQPpg5JCaCumlDJ5JfeIGNBy4XuFo+dgqGBgbnvhOe3ts7JpT87
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
index 368f881eccbbf..df38ca6de4124 100644
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


