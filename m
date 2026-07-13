Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9234D3B0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965459; cv=none; b=X8QCsrghCiUBuU4UxBhMPE7GfefXYHM/Ck+oDzKPeH4oN7VM68FXpynXawh4VzkFPFhH+/9qW0p6Rg7acDNXICFG1LJ3md7A0fWl+GpTkFIXn+NxgtTuX7L1vFtQIy1oyNnKYWphX/Rk6WvrrtxS/IJDMEIFYd7ckc5flnLdaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965459; c=relaxed/simple;
	bh=1QlsY5rU9NfH6hD/zubc+2LFb5UgaNK3kyoqS2xxSy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeEndo7ylkKrYfXWQ9LYstnLkRyj3WFtTosVSWdZu4efnG8vD0lbT3cIz/nkbD5MrHUAJ02gsRhIbfJ55QWw1dtg3rNcszmYMRarYbFM8aXjroQ3MAcERyqHXexDAHPv8SJaCue9gerO7Pv2hTqv4Qilp0BTQKJwJQnIS6Hdmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaJNF1o1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaJNF1o1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061421F00A3D;
	Mon, 13 Jul 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965457;
	bh=vUUp7MSmtVU1mttDz1u6K47mjBh0cTysm+9DPzq0WLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TaJNF1o1KjjHD/XVEKsB4kENbPkdLwJqpKxagYnjAEh8XuJyhC6Sgg7MCUiLfrXWf
	 PuJ2yAn2SURmZ77gJ6IpOfk0ugswRxQCCQyxLjJ2YBHIb3fhaNbJF1v/ytWsgM8/0E
	 WAPjjuoRnC1twXDJa1cDbaBpCZsemzv/aPkjlvRdHqQrYPra7DE/x4vFxqAbpuasDm
	 jdmBFW7nHG8saaj3SlSM81OT3LzajRL7uYubGWlR8+pPq0vjPD7opqE0L1mDD8+zRk
	 WOMJ/GmmFSGULkcuJV6hhhOwC80yHKEgSh/20HazmWaDqGzwdN5tvG3dwbM88PUd7W
	 3NT3L96FB1lkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: hid-sensor-rotation: Fix stale or zero output when reading raw values
Date: Mon, 13 Jul 2026 13:57:33 -0400
Message-ID: <20260713175733.1907391-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713175733.1907391-1-sashal@kernel.org>
References: <2026071306-provider-scrap-2570@gregkh>
 <20260713175733.1907391-1-sashal@kernel.org>
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
index 5a5e6e4fbe34ba..83a0b0283605b0 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -74,6 +74,13 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
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
 
@@ -83,8 +90,37 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
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

