Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597055;
	b=Nsb0gZjF3ycGiMXVzQaQr4yrmBgqNx4k8yk6P04WYTc132sdvl8oMokQzz0QluKffWvG
	 Ov/fuwEaGHaoQR/GqdnFP9/8KYdU9vGzLRiIPsZCcpUCtkIJKW1l0jzbsyQpX5vDZgwv+
	 Zi/0AmgkJ0kx4jLTXKAmWaXRmEP0Iw/Af3mkxbmNpjftL2vvj0mO9GQvMxLke7HF/AmH1
	 1llw2+uxxB7FOoF+94SaMusvTMBkeo5JXYA5OMh3Lqcba6koEgTp8YrqCb74Hf1m9xbI5
	 UfQ/D1nx7k3ACRSoJh7oQqtO5cilDrfOf7TmFiXKmRAuWCpy9aGozcfDmqhm7U4DzyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LS9qMcB7qDWiQ1zJy+ajNKLkItL9/upfcdWNLW+0hhk=;
	b=rkbx5ban6+ATwYn2Abhrj+VNhsVFPnFCkCVyp4/GLhm09PEb3ybP+ufRglMlK8RksjrJ
	 3Ug735iuV4NNVz+20SsIr8yWZ+Zt0y8V2Vh5JuXYRJNiA8XgV05GAvD0xFbwjLyPXnstP
	 9MQXvcT3413O9YR61oDxm0txl+wd+ZdYp8N2jLBZl9E60xuKL5FzuzwcoVYgbf5B1YDJl
	 xsbjTuchQ0vdAEiF2Wil9UNTLobuhjWkUfEAzWTVRlt5Q0vpG0XRKwd8rB0plSmuh60+L
	 D8OPmisT36HSjIT15y0mpalQYUB4v2xYZdNpS0OBnZl8dpZ4xVqfl7wP4ZivWWNCiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR0aYwLM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC3606A333
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR0aYwLM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3851F000C4;
	Fri, 13 Nov 2026 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597055;
	bh=LS9qMcB7qDWiQ1zJy+ajNKLkItL9/upfcdWNLW+0hhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WR0aYwLML6Hd1ZqsZU6ZP6/s54uh7OqamA88AkVFq7H6YYgW8zY5REAXBz3yGsjSZ
	 1lJCrkTFXfRAYJSKRcHUHU/VJA5XEJPEyLiQR0AY/44lNWUq7unVBVZr1XvQM0ifse
	 pPOdB/5v31WmU7/5KukXo9ItyHi18lMWBUMH73DE+AwELixzNBdd9s5TxJbhc+U8ET
	 FYE/KWTpQrxDqoY7AR5xl4iw5E5caO4re9fUxqlwNcNVVEqh4YeGKqM6ochJyMUSho
	 g5VJjN97z/S1vB8aJxUBvdOPJSfOWvl/aDEjMKw4+KFwgfjbIvkWTmwXS1yxDFStwE
	 7pC4Zs2oRoQbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (tmp108) Fix initial conversion delay and wait until ready
Date: Fri, 13 Nov 2026 14:10:53 -0500
Message-ID: <20261113160253.1953753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201622-failed-6.1-7cd60538073e@kernel.org>
References: <20261109201622-failed-6.1-7cd60538073e@kernel.org>
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
[ sashal: adapted tmp108_common_probe() changes to tmp108_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 4807c7e8fe609..0bdcb395f52ec 100644
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

