Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D37351C2E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965817; cv=none; b=cH3pBQGB4hsOvbkJXuuaW27UCZfr1pbp5KpCi7vzz4wDeAF5+g9IBXSHVbRLULiN0mi2+uSwAIgtr0t9gRLNYTqG+fJgB8rIuZsspABtZRsEfh9gNXeAWzEQcDhc/XBUU+/mu8lXTatcCNF0AtMycT/YfIM91jFK4SjhsEeZ2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965817; c=relaxed/simple;
	bh=Le6oY5PASA0NV48ao2YWVY8YgR+m7Ld2UTlSyiIBuOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC7TMeUSL6bVX748XtNNKTDO6MrDuiD7r0cv2tW7o56Ct1BDNL6zg3zQdmKki7PfoU/DyuKx9O82gJzMFxxqsRhbYAXITKPTscp6VoEYG67C5/MNGwcyGKBraQCl6n/GtNGPCZoY+JN/RHTy3p5zQdUedv5oJ/Lt0s+LADydrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnXIlpzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnXIlpzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F341F00A3D;
	Mon, 13 Jul 2026 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965810;
	bh=FNtBoJeRos9K4GzPlBKXU3c362gLxjZKK19P9Y/xqbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnXIlpzXl/aWwHFrk2vEzCRGdjk/rLVpdPHV0ry1TySQDEhnuLW1TrB08zjUlwvop
	 QkhUWCsUBrXBHepeZ7a8Yh8o7gts4l7lGdAz4z0oqMLXM5JezcHEmbStbzpa0pXMcQ
	 Lfk9Dluc6U/g9tRcxRdQ6Zof6ogSyfFVcIhL9D7hGKq9YWSlnAoxfBSITFJrE9Dbjm
	 EH58NBKP7o7sAvCKc8ES0+rXxe+XJwgyP0ckhC5zkwmVrhquqiQOBbbwwyTl6ow9t6
	 7Cz0qfpfLrP/8btqHTUM4Qy4obcRtiG0Rjs8c3b7pCxYBDvSN6v30yzFQPNnIk4VxH
	 kVPrZvuQOKCCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: hid-sensor-rotation: Fix stale or zero output when reading raw values
Date: Mon, 13 Jul 2026 14:03:26 -0400
Message-ID: <20260713180326.1923554-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713180326.1923554-1-sashal@kernel.org>
References: <2026071306-treachery-glare-d08d@gregkh>
 <20260713180326.1923554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 3ce8d099e0afc5a7da75a2007a67f67c4f5a4af1 ]

When reading the raw quaternion attribute (in_rot_quaternion_raw), the
driver currently returns either all zeros (if the sensor was never enabled)
or stale data (if the sensor was previously enabled) because it reads from
the internal buffer without explicitly requesting a new sample from the
sensor.

To fix this, power up the sensor, call sensor_hub_input_attr_read_values()
to issue a synchronous GET_REPORT and receive the full quaternion data
directly into a local buffer, then decode the four components.

Fixes: fc18dddc0625 ("iio: hid-sensors: Added device rotation support")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 5e8cadd5177ae7..a0cf5d2a87fba1 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -69,6 +69,13 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
+	struct hid_sensor_hub_device *hsdev = rot_state->common_attributes.hsdev;
+	struct hid_sensor_hub_attribute_info *info = &rot_state->quaternion;
+	u32 usage_id = HID_USAGE_SENSOR_ORIENT_QUATERNION;
+	union {
+		s16 val16[4];
+		s32 val32[4];
+	} raw_buf;
 	int ret_type;
 	int i;
 
@@ -78,8 +85,37 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (size >= 4) {
-			for (i = 0; i < 4; ++i)
-				vals[i] = rot_state->scan.sampled_vals[i];
+			if (info->size <= 0 || info->size > sizeof(raw_buf))
+				return -EINVAL;
+
+			hid_sensor_power_state(&rot_state->common_attributes, true);
+
+			ret_type = sensor_hub_input_attr_read_values(hsdev,
+								     hsdev->usage,
+								     usage_id,
+								     info->report_id,
+								     SENSOR_HUB_SYNC,
+								     info->size,
+								     (u8 *)&raw_buf);
+
+			hid_sensor_power_state(&rot_state->common_attributes, false);
+
+			if (ret_type < 0)
+				return ret_type;
+
+			switch (info->size) {
+			case sizeof(raw_buf.val16):
+				for (i = 0; i < ARRAY_SIZE(raw_buf.val16); i++)
+					vals[i] = raw_buf.val16[i];
+				break;
+			case sizeof(raw_buf.val32):
+				for (i = 0; i < ARRAY_SIZE(raw_buf.val32); i++)
+					vals[i] = raw_buf.val32[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+
 			ret_type = IIO_VAL_INT_MULTIPLE;
 			*val_len =  4;
 		} else
-- 
2.53.0

