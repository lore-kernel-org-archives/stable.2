Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605787;
	b=A0kF19gnLpFdWCgJKWxNIZWsvpHztD/zJFI5cQ1nFddAsglqRjuSFhynjLIggSRPS3Hn
	 BAe7Kf/eBwTKeUaBCCiMiN7zIHREQZNfxKVVbsNMnfFcUbBwdCmTF0hH152BlgRiiPTK5
	 YRFuP0B2R5IbDtY9rSB/L70cJBMCo4BYInsBkcyoUbxP4u6a9wwItdOyahobF1rCcNUXf
	 s5ym4v0AjjWUaEk+FxkJ3jS3YehbsybYeRBawmkh9cabQ6k9aZ7rUkk9pMws0WiYrg3gR
	 IcghLurz93CaZfX+G/dJmqdDkdGV6ouAwyZagWoI833uwVuK33Uf9ZWhPFRNPU8ZWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605787;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gckm0Cqy1BADZ6Bs5Lu2D0ypAZKe/kLlhx9NzFBDuVE=;
	b=J1meMQiHRwbR9nqRWVd5tkCsRaZLWs43qvFfEGke8fE+gAaKbvky10X+1rrb1PPo3XLS
	 XU/c2mdHLTAHC1wMnDLWsOfR8Qb6sysxmXFYt+EQGQ8fr3uTPnZs9qXQouJoVOiHJjmbo
	 ieuyeOBnJhCgXV47t2Iq2yFqn1cJKeNFPdQXnfTsYI7Zf7Ry2iIPllGXdNoB8ubB19ciV
	 50B/4qJhuT2jjGt2zBAdV8m1QtGuOPMU+vycHH0r/6DjPMYjHXY/m3u72IEYFkOXk9hcI
	 dazUfq+nLGpTAFwSkjopEKseEAtXKroZJe41Lk2KUQhVplnswJ6H6yhebprQmCdVVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8+2dVoF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6E606A338
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8+2dVoF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6110C1F000C7;
	Fri, 13 Nov 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605786;
	bh=gckm0Cqy1BADZ6Bs5Lu2D0ypAZKe/kLlhx9NzFBDuVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8+2dVoFCnEVGTZ+1X3Iccdbd3rz5BzgoW0OkjwsNIyqSvxL7HKaajDvNobhzLd3q
	 NXnfevaae/yk0WTxy+M8o/xNYdzMYx4qQjAEPxj8Q4DT/hV3XgPiDBpi3bwYCurWJs
	 lU6wx0Jd0j0tK0TaRCR8OYX9ImYLIvZWBomt1599M2O1D/QT88cHtyCZ9LwseC1wGc
	 ghb27IeTGOvG8uDz4oLJ791VqBlqlZSt2MBX6M1yE5J1t1iRC9YEXH81//KaBRtYkC
	 GYK6n2MGJ455xEjl74x86LV2qD5T4j3BmE1yyeOpEYr3Iu0VNqo557aWAx3SieDRAR
	 UezdjDHlFIh+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vas Zayarskiy <contact@vasily.cc>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings
Date: Fri, 13 Nov 2026 16:36:25 -0500
Message-ID: <20261113213607.2697131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201634-failed-6.1-c221091f7e30@kernel.org>
References: <20261109201634-failed-6.1-c221091f7e30@kernel.org>
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

From: Vas Zayarskiy <contact@vasily.cc>

[ Upstream commit c221091f7e30c64280e4cbfa27dc4c05edc96d0c ]

High Flow Next power is reported in watts. Multiplying the 16-bit value
by one million can overflow both the signed intermediate and the u32
cache. Store power in long, perform the conversion in u64, and clamp to
LONG_MAX. The other existing power conversions fit in a signed 32-bit
value. Return -ENODATA for unavailable power instead of exposing the
stored error as a reading.

The power cache is updated by HID reports without the hwmon read mutex.
Read it once with READ_ONCE() and use that snapshot for both the
availability check and the returned value. Mark the corresponding
updates with WRITE_ONCE() so that the shared accesses are explicit.

Widen the shared current cache to u32. The Aquastream XT conversion to
milliamperes can exceed 65535 mA; clamp its negative conversion results
to zero before assigning to the unsigned cache. This also permits devices
with scaled aggregate currents to store milliamperes directly.

Fixes: aed80bb91de8 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow Next")
Cc: stable@vger.kernel.org
Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
Link: https://patch.msgid.link/20260927191316.4137752-2-contact@vasily.cc
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Replaced priv->fan_structure->power with the existing AQC_FAN_POWER_OFFSET constant. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/aquacomputer_d5next.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 8c7796d3fdd2d..29af6b00f658d 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
@@ -302,9 +303,9 @@ struct aqc_data {
 	/* Sensor values */
 	s32 temp_input[20];	/* Max 4 physical and 16 virtual */
 	u16 speed_input[8];
-	u32 power_input[8];
+	long power_input[8];
 	u16 voltage_input[8];
-	u16 current_input[8];
+	u32 current_input[8];
 
 	/* Label values */
 	const char *const *temp_label;
@@ -515,6 +516,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
+	long power;
 	int ret;
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
@@ -532,7 +534,10 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		*val = priv->speed_input[channel];
 		break;
 	case hwmon_power:
-		*val = priv->power_input[channel];
+		power = READ_ONCE(priv->power_input[channel]);
+		if (power == -ENODATA)
+			return -ENODATA;
+		*val = power;
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets) {
@@ -743,9 +748,9 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	for (i = 0; i < priv->num_fans; i++) {
 		priv->speed_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_SPEED_OFFSET);
-		priv->power_input[i] =
-		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
-				       AQC_FAN_POWER_OFFSET) * 10000;
+		WRITE_ONCE(priv->power_input[i],
+			   get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+					      AQC_FAN_POWER_OFFSET) * 10000);
 		priv->voltage_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
 				       AQC_FAN_VOLTAGE_OFFSET) * 10;
@@ -768,10 +773,11 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	case highflownext:
 		/* If external temp sensor is not connected, its power reading is also N/A */
 		if (priv->temp_input[1] == -ENODATA)
-			priv->power_input[0] = -ENODATA;
+			WRITE_ONCE(priv->power_input[0], -ENODATA);
 		else
-			priv->power_input[0] =
-			    get_unaligned_be16(data + HIGHFLOWNEXT_POWER) * 1000000;
+			WRITE_ONCE(priv->power_input[0],
+				   min_t(u64, get_unaligned_be16(data + HIGHFLOWNEXT_POWER) *
+					 1000000ULL, LONG_MAX));
 
 		priv->voltage_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE) * 10;
 		priv->voltage_input[1] =
-- 
2.53.0

