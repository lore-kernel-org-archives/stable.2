Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D8468C23;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960588; cv=none; b=TmyFPlt5/nDKsPE6hqtriycIq9M9oTVAOVzRvn9XgvzwMURwSY3AA0WU7JhGN9l/xH2fMS0whrdVaaoRthqGGz2tl+TGD+3QF5fsbXSmxHwhFpSvYbWMxEpfaqNHxw6GqYlSQvyV1tTAc8DEBnj0+vvLCZg5umnavoy0BGPFrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960588; c=relaxed/simple;
	bh=5AfeHxdzIe4On+d5DmZHfSd4BJhPKM5RlNXDO5HXWIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXzYL9N+C154UElhbM344vepwsANZ5Yf9Tb49DAI+o5a7clWanhs7WmA1uavFsqoozKR/acsxAP6yYSeCsz+DuzcBgac3QaRyTLCxxCXN6PYP3k0pPgkSzHsPYQiKGZWiKcTK3XGyD9+JskQBViFuzBx5+Z/YBhYtvO5xIGzcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pD5+ujE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pD5+ujE0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E1B3C4AF09;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=5AfeHxdzIe4On+d5DmZHfSd4BJhPKM5RlNXDO5HXWIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pD5+ujE0hqRTofsn52iZ6ej/MqZTJKEHTJV7WakHBihrUH7XkLz/fQUn5pUxKCOWW
	 G1tnpzMuRa0HUqL4F7IGKe5qC2+esSNmblML9FEIkqHH+GWUYyRPqTzxMf103xn2Cm
	 +v1xvUePwdGgsWXN8Bof7iprXLlAnmvLzXveZ7R4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D9CC6B25;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Wed, 14 Oct 2026 08:49:09 +0200
Subject: [PATCH v2 2/8] media: i2c: ov9282: fix pixel rate and line time
 calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-ov9282-fixes-v2-2-3bb376d8b1a9@linux.dev>
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=4066;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=5AfeHxdzIe4On+d5DmZHfSd4BJhPKM5RlNXDO5HXWIY=;
 b=qSaMlNS0F6xeT2c1ivRY011te6/+ewsVdNGsi/GLqDhkjWOKHKH2QL2FRQdBpHcfY30rfsM4a
 W9zOQr6JY21Bd38R9FTa4jhOr1/w612VoPnPRpu4c8JcpETPba6zXeX
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

The OV9282_PIXEL_RATE_8BIT is calculated incorrectly from the
OV9282_LINK_FREQ. The hardware scales the pixel rate by changing the
multiplier from 0x50 (for 10 bit) to 0x60 (for 8 bit). Resulting in a
x1.2 factor.

The current OV9282_PIXEL_RATE_8BIT calculation scales from /10
(for 10 bit) to /8 (for 8 bit). This results in a x1.25 factor.

As all the inputs to the pixel rate calculation are constant in this
driver also define the OV9282_PIXEL_RATE_{8,10}BIT as constants.
Additionally introduce a new function to calculate the current
line time in nanoseconds and use it in ov9282_exposure_to_us().

Kudos to Dave Stevenson for pointing me into the right direction!

Link: https://lore.kernel.org/linux-media/CAPY8ntBaSHjztuSLTOtv9KYvEbmcbinSMJ78ZDg+0sZg-1fz3Q@mail.gmail.com/
Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum")
Fixes: 43ac0cac18f41 ("media: i2c: ov9282: Add support for 8bit readout")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 50 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index c10b2e205834e..5907f57b34523 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -10,10 +10,12 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time64.h>
 
 #include <media/v4l2-cci.h>
 #include <media/v4l2-ctrls.h>
@@ -111,11 +113,14 @@
 #define OV9282_LINK_FREQ	400000000
 #define OV9282_NUM_DATA_LANES	2
 
-/* Pixel rate */
-#define OV9282_PIXEL_RATE_10BIT		(OV9282_LINK_FREQ * 2 * \
-					 OV9282_NUM_DATA_LANES / 10)
-#define OV9282_PIXEL_RATE_8BIT		(OV9282_LINK_FREQ * 2 * \
-					 OV9282_NUM_DATA_LANES / 8)
+/*
+ * Pixel rate: Derived from the PLL2 clock tree.
+ * For 10 bit it's exactly the same as the sample PLL configuration.
+ * For 8 bit the PLL2 multiplier (REG_PLL_CTRL_0D) is changed 0x50 -> 0x60,
+ * which results in x1.2 and therefore 160 MHz x 1.2 = 192 MHz.
+ */
+#define OV9282_PIXEL_RATE_10BIT	160000000
+#define OV9282_PIXEL_RATE_8BIT	192000000
 
 /*
  * OV9282 native and active pixel array size.
@@ -472,6 +477,32 @@ static inline struct ov9282 *to_ov9282(struct v4l2_subdev *subdev)
 	return container_of(subdev, struct ov9282, sd);
 }
 
+/**
+ * ov9282_line_time_ns() - Calculate duration of one sensor line.
+ * @ov9282: pointer to ov9282 device
+ *
+ * Return: line time in nanoseconds.
+ */
+static u32 ov9282_line_time_ns(struct ov9282 *ov9282)
+{
+	u64 hts = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
+
+	return div_u64(hts * NSEC_PER_SEC, *ov9282->pixel_rate->p_cur.p_s64);
+}
+
+/**
+ * ov9282_exposure_to_us() - Convert an exposure register value to microseconds
+ * @ov9282: pointer to ov9282 device
+ * @exposure: exposure register value to convert
+ *
+ * Return: microsecond representation of the given exposure register value.
+ */
+static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
+{
+	return div_u64((u64)exposure * ov9282_line_time_ns(ov9282),
+		       NSEC_PER_USEC);
+}
+
 /**
  * ov9282_update_controls() - Update control ranges based on streaming mode
  * @ov9282: pointer to ov9282 device
@@ -510,15 +541,6 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 					mode->vblank_max, 1, mode->vblank);
 }
 
-static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
-{
-	/* calculate exposure time in µs */
-	u32 frame_width = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
-	u32 trow_us = frame_width / (ov9282->pixel_rate->val / 1000000UL);
-
-	return exposure * trow_us;
-}
-
 /**
  * ov9282_update_exp_gain() - Set updated exposure and gain
  * @ov9282: pointer to ov9282 device

-- 
2.53.0


