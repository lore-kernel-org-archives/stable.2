Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273396;
	b=vc4p5D8NrYUOKfxonDtqEVX/8tQSStQ7Jzm9n3Yp4BjotynhcyWWn3oQFCnpCCisgeph
	 0EueY3plUWDCTFW2oUMnCSej7/+RoOVnOaHmnUNfd44dmflfC5awN/hssPvj3SyAr4qst
	 l6H8+oFedtmjD4EjZ6BCB0dAAcQrAWpBjk8mrpZPMJtpblFxtHeDP+WVuX3qnmx/CE8u3
	 e++q0e1uaPCc51WNGeVcV0W2SFASHm4WLvIIMSo4PzXe1A2z6fGJMpkQRNszznKtWPhnt
	 xO3Lozk1fUtbGIdAHOUfjq5MNZmbqfCoDquPvz3t7deSF6vVX43ZDzbjbGBsIRZ8Ayg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2XIYBcuxNIXj8zwi5Hq6+PZOIE5aJNHvF2K26cMo04E=;
	b=FkVUaqIVnUwSW7vD0BrolTqObAzj1lotWX19M2HMsAsLNYFoYlAeza66Kw1oRrUhJU4S
	 smBWVrwqBdzwXxRRUtBbSEg+Ui8oXnF1ghYVOYEb0qsBvQ24lorCzSGkw1sN2Tmf3tLKa
	 akh7VR7hFlLIZA68PrT3CyfjGDuWtaQCw59xdf9UxMVAafZ1A5jtuKAU0eUecyh1pufaG
	 ZoUi/EImVdkb4gocg/4P1zEG9/orAh2alXe4QavArBQ2bSLv6Wj9IZyuLuYdEzn0MaAot
	 KTwWO8oxUy/ODSaYCF37UQ2OMYJyhoXUthil9NgsWzJOMB9NQ1MvFy5H63VwjiGzbZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tq2lCKzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tq2lCKzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F641F0089F;
	Tue, 10 Nov 2026 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273396;
	bh=2XIYBcuxNIXj8zwi5Hq6+PZOIE5aJNHvF2K26cMo04E=;
	h=From:To:Cc:Subject:Date;
	b=Tq2lCKzInd2jrQ+k3c3vFoOQuiMbeQRWs0I6fFqvW6AdciNUWfov6Sn7U1fQQ1y24
	 XDGRC3Tovw90z4AASONT4ZyUzGP4xTgypHgWobTnH6MfxkRE7dALhx4Tg8ET9DYnGE
	 4P4TEVLGbX2HOsCo0oJfxW70TglkQCcn04jepeB5wrXLrMsQHf6iHY+pF6BJzuw43Y
	 m+1JsZHO0zB9OVYi1sO30msI+t0xdBEDJzy7b8riszawFdnWrSCKIL8RF5c/JBikNy
	 OjNOZ3G0E4KVCfmxEAGa7OBboiDQr91QvDlsyvemnfheHn5m8IIKwrzlNw1NQOerUY
	 iNaHRedHjBNWg==
From: Sasha Levin <sashal@kernel.org>
To: contact@vasily.cc,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:34 -0500
Message-ID: <20261109201634-failed-6.1-c221091f7e30@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c221091f7e30c64280e4cbfa27dc4c05edc96d0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201634-failed-6.1-c221091f7e30@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c221091f7e30c64280e4cbfa27dc4c05edc96d0c Mon Sep 17 00:00:00 2001
From: Vas Zayarskiy <contact@vasily.cc>
Date: Sun, 27 Sep 2026 22:13:12 +0300
Subject: [PATCH] hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor
 readings

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
---
 drivers/hwmon/aquacomputer_d5next.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 6565731b0e71f..3d3786c829317 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/unaligned.h>
@@ -612,9 +613,9 @@ struct aqc_data {
 	u32 speed_input_min[1];
 	u32 speed_input_target[1];
 	u32 speed_input_max[1];
-	u32 power_input[8];
+	long power_input[8];
 	u16 voltage_input[8];
-	u16 current_input[8];
+	u32 current_input[8];
 
 	/* Label values */
 	const char *const *temp_label;
@@ -989,7 +990,7 @@ static int aqc_legacy_read(struct aqc_data *priv)
 
 		/* Calculation derived from linear regression */
 		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_CURR_OFFSET);
-		priv->current_input[0] = DIV_ROUND_CLOSEST(sensor_value * 176, 100) - 52;
+		priv->current_input[0] = max(DIV_ROUND_CLOSEST(sensor_value * 176, 100) - 52, 0);
 
 		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_VOLTAGE_OFFSET);
 		priv->voltage_input[0] = DIV_ROUND_CLOSEST(sensor_value * 1000, 61);
@@ -1019,6 +1020,7 @@ static int aqc_legacy_read(struct aqc_data *priv)
 static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
+	long power;
 	int ret;
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
@@ -1083,7 +1085,10 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		}
 		break;
 	case hwmon_power:
-		*val = priv->power_input[channel];
+		power = READ_ONCE(priv->power_input[channel]);
+		if (power == -ENODATA)
+			return -ENODATA;
+		*val = power;
 		break;
 	case hwmon_pwm:
 		switch (priv->kind) {
@@ -1383,9 +1388,9 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->speed_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
 				       priv->fan_structure->speed);
-		priv->power_input[i] =
-		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
-				       priv->fan_structure->power) * 10000;
+		WRITE_ONCE(priv->power_input[i],
+			   get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+					      priv->fan_structure->power) * 10000);
 		priv->voltage_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
 				       priv->fan_structure->voltage) * 10;
@@ -1425,7 +1430,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->speed_input[2] = get_unaligned_be16(data + AQUASTREAMULT_PRESSURE_OFFSET);
 		priv->speed_input[3] = get_unaligned_be16(data + AQUASTREAMULT_FLOW_SENSOR_OFFSET);
 
-		priv->power_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_POWER) * 10000;
+		WRITE_ONCE(priv->power_input[1],
+			   get_unaligned_be16(data + AQUASTREAMULT_PUMP_POWER) * 10000);
 
 		priv->voltage_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_VOLTAGE) * 10;
 
@@ -1438,10 +1444,11 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
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




