Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583547;
	b=dCISTQCzcgtFF1tO8hbQeThbGsOmaHFUcLP+bOh06EIAPOqxDVWbRn5A0jBkWkNrpqVO
	 CpDhstzU8xRsPnWnlLlw1uksDLPFGyrcVkw3H3jN/9q0T1/+jF2bQwJ3Lud7J+kLjcODX
	 ldjmn+bod4tz+6xXRWEuZ0SxayjaO0KsXTR2fGSJ6DWtu5BW3BWmy3Bmowo4KRdzlT2Q0
	 BGXm0/IgR4lpQyT65OkcUUN5nBw4ZBS2Ntj6hzmJ2qJYRSYLlNCjwG9369Oncfh5qPNOg
	 rgsSKOhV968fjH9Jyv2b8z7i5IsWIp/dDpzAByYGQQg01rqBTDF/i1HRvVkcoMGpAcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9yX9JcUljeqs7BEBakyfp0qQBgUQt2Hl4gns8pvuZyE=;
	b=XbgsL2RiFZumcl2IkxOaH+7DblsqaFdKo7Ylmx3kZ/7WDc5sXj6ywWGsFhTMQhDbD5LW
	 KnXyYMEQnUBYbn9wVks5UwEdzIcAzDK6Ym87bGiAeUyKBpg6c4afFKQxX8KX8Yg6C5nPk
	 TzP+BMcG3zxPzLrLwkMwKHkc4iPXyLVUPoQGQML3VMa7W+9a+n6reeTSqjIu2TfgYDArq
	 JChdjuFvkgexAxlpcXL88YJ5BYwlNSyaHDq7DQK2f6UBqMUFk/aYqZnnKSveusrJj5eXq
	 SmHlkC5mHlOGaepO7Vt0RJhDezYApjOjB61D1lgNkDX6RMOl+cTy6/CqI5aVEnGBCog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YS3yy/SK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A935606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS3yy/SK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AE01F000C4;
	Fri, 13 Nov 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583547;
	bh=9yX9JcUljeqs7BEBakyfp0qQBgUQt2Hl4gns8pvuZyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YS3yy/SKXh6EKUCqjYgwgw21sXxhv2E8p6AzkpKIw8fhSDUcvGKik1asrCRe7bk+b
	 6+74eXwY/EZTtx2tQ5IuTp0J3bgushvbEFxPtJ+HWZD/n+fdMbMsPEk5tyGBqg6Jlu
	 i6uIIyJx+kK2lA1cHx0L62wR58ezC6POy9kdk/qCk2cXGvQO3q2bSXCWDnNpOT9LcF
	 AVD18vhXgkK0sYTRTQqzFGoYS+2+pZtCq/UcQlLVDFsYEcvGLiScNBZfDG72RZ06Zq
	 Oxu/TBZvglk5nASk+RtGR8jPFTwJS5mkB6lXmnemgEML+ldHE7RQXnav4jMFBHnAJx
	 o3TqHi0D+NMKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (tmp108) Fix initial conversion delay and wait until ready
Date: Fri, 13 Nov 2026 10:25:45 -0500
Message-ID: <20261113150909.1867314-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201147-failed-6.6-7cd60538073e@kernel.org>
References: <20261109201147-failed-6.6-7cd60538073e@kernel.org>
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
[ sashal: Applied the probe change in tmp108_probe() instead of the absent tmp108_common_probe(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index c763efa6aac49..b4e55059e3387 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -14,7 +14,7 @@
 #include <linux/of.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -73,7 +73,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	u64 ready_time;
+	ktime_t ready_time;
 };
 
 /* convert 12-bit TMP108 register value to milliCelsius */
@@ -94,6 +94,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);
 	unsigned int regval;
 	int err, hyst;
+	s64 delay;
 
 	if (type == hwmon_chip) {
 		if (attr == hwmon_chip_update_interval) {
@@ -123,12 +124,10 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 
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
@@ -371,11 +370,8 @@ static int tmp108_probe(struct i2c_client *client)
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
@@ -405,8 +401,8 @@ static int tmp108_resume(struct device *dev)
 
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

