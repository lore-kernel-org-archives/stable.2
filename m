Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514497;
	b=LnrBGKzqOVQHXoBtFM8EfltzhHE0C+a0+Jn6QUbB7w3C1BpmTMjoAaPWu0ScPAoxOGrl
	 8TaZcQ0JSOLxqmbjNgTY+NPCtMTgfV8PqQKD40jJYSqLsjhBHLZRsHUNeKa7xq04tYZsq
	 qBf+AQK77HEYOrukQ+NTW2LyYTSdHFGVa0V75KyAsCQ1cToe3I+oTi6SdnhErEoamoJKp
	 PwysIkT4gq62/Pe+mtEwbeKCIttxsEppTG/iIrZqRS2xXISwG8VQEXvEzLC64yd5nMxF1
	 IqWfYy5AYTB5FYOSK/zhRYLTQamC6n0szPs+u2D8X4AGNzJz/F+hl/MnDLSIRubvj8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g/CZDCoSG3PJAggCcQOSUNIaMatEG4InxHYvQELPhME=;
	b=Ew6UFfZ26YLnBCKJQ5oxE7s5HqUqnEuixEnJXAmFiLsr/G2FVy59pTewuIcL8/ap57GO
	 wKY+T5BkEgxQkKYQ/LQ9aDvql0Y+kNAg9LfbK+NLVh5x7zUevIZSH2OtdXVRDi3jgUuXP
	 0HM5E9KzKrzvit7ELctMHw/7W4jgNH+mH2lgO23eHvDR/0BJDkxe1DWDVrcLw3phiCLHK
	 00B5AEtE4Y/QoHQI2wv2PkesGj9UMAJo59YKG4jTgwWb3VdxQT9a72cE6Bwr0AguoVQR9
	 x/ZbZGYm8NaI94RDDnVZ6+HXYgFioY9ccYq5mGlQIa8Dq3UtPgGWiPRATufKy5IpxBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+cmq6bT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB4606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+cmq6bT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0788D1F000C6;
	Thu, 12 Nov 2026 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514497;
	bh=g/CZDCoSG3PJAggCcQOSUNIaMatEG4InxHYvQELPhME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+cmq6bT8YW43BTcFxT24jExfBmrGUjcXnBAO1bAUH9LU5HREyB1dHCYabZXNkO7P
	 oSCqjWQHgXGDNtiIM2POMhjZcqMDA9kWpSQC3LFmd6p/pOBq8L6KNRy2J2rz+LsPTQ
	 uk3EYzLamEKwpt994p7VPEoVrfwRN2hkfSnSDXTIlAnVQ+OukpHDT5slQFNRR7YXkb
	 XQttU+GoxElFrExRrbbRWti/DerHd9295aiN5gnZMbu8LLFlV0a3THf8nLxeu6mybk
	 JtEbWmGNjpisBEnZ5Qf0HCiz7k14em09WxZMYaHXTdTZMzgYOd6LU0z7Qo5Xt/8Ue5
	 CgsrIl4NrwNtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (tmp108) Fix initial conversion delay and wait until ready
Date: Thu, 12 Nov 2026 15:14:54 -0500
Message-ID: <20261112200225.3377761-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200225.3377761-1-sashal@kernel.org>
References: <20261109200336-failed-6.18-7cd60538073e@kernel.org>
 <20261112200225.3377761-1-sashal@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 7cd60538073e465310c94b2a2f0ea8d2f03768ef ]

In tmp108_common_probe(), the driver only adds the 30 ms conversion delay
(TMP108_CONVERSION_TIME_MS) to ready_time if the sensor was previously in
TMP108_MODE_SHUTDOWN. However, the TMP108 hardware defaults to continuous
conversion mode (TMP108_MODE_CONTINUOUS) upon power-on reset, including
immediately after enabling the vcc supply regulator during probe, while
the temperature register retains its power-on reset value of 0x0000 (0°C)
until the first conversion completes. Because the initial mode is not
shutdown, the delay is bypassed and early reads via thermal zone
registration or sysfs before the first conversion finishes return an
uninitialized 0°C reading.

In addition, returning -EAGAIN from tmp108_read() while waiting for a
conversion to complete after probe or resume can trigger an unnecessary
tight retry loop in callers or fail initial reads.

Unconditionally set ready_time to TMP108_CONVERSION_TIME_MS ahead in
tmp108_common_probe(), track ready_time as ktime_t, and wait for the
remaining conversion time in tmp108_read() using usleep_range() instead
of returning -EAGAIN.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 66e1c9171339 ("hwmon: Add Texas Instruments TMP108 temperature sensor driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index f8b2d88d14665..cb52b99eda4ab 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -14,7 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/i3c/device.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -74,7 +74,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	u64 ready_time;
+	ktime_t ready_time;
 	const struct tmp108_params *params;
 };
 
@@ -96,6 +96,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);
 	unsigned int regval;
 	int err, hyst;
+	s64 delay;
 
 	if (type == hwmon_chip) {
 		if (attr == hwmon_chip_update_interval) {
@@ -125,12 +126,10 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		/* Is it too early to return a conversion ? */
-		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
-			dev_dbg(dev, "%s: Conversion not ready yet..\n",
-				__func__);
-			return -EAGAIN;
-		}
+		/* Wait if it is too early to return a conversion */
+		delay = ktime_us_delta(tmp108->ready_time, ktime_get());
+		if (delay > 0)
+			usleep_range(delay, delay + 1000);
 		err = regmap_read(tmp108->regmap, TMP108_REG_TEMP, &regval);
 		if (err < 0)
 			return err;
@@ -363,11 +362,8 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = get_jiffies_64();
-	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
-	    TMP108_MODE_SHUTDOWN)
-		tmp108->ready_time +=
-			msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
+	tmp108->ready_time = ktime_add_ms(ktime_get(),
+					  TMP108_CONVERSION_TIME_MS);
 
 	err = devm_add_action_or_reset(dev, tmp108_restore_config, tmp108);
 	if (err) {
@@ -414,8 +410,8 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = get_jiffies_64() +
-			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
+	tmp108->ready_time = ktime_add_ms(ktime_get(),
+					  TMP108_CONVERSION_TIME_MS);
 	return err;
 }
 
-- 
2.53.0

