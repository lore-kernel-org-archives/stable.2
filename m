Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273993;
	b=0tBwSo0peHj1omKvc+hXBrPeS7HVeZiudVWv0lzCNLFDP+W8AY7lLo3HuGNedc4sjUzG
	 PTI9iNHE5Ychxr8eqVLdF0sfZnMKh3BKm8jusTMOfXTEom6dvLMFudntWIU3vQdeWYXFh
	 iGpbDH4cAocrq5FL6wRKNU+pA3Zd0N7P1fh/tBeY6JGq8x+zrXRNQuRBAV6NuTEo2WqF5
	 QCBYC4qh5stdqJGdQw8tWg+CJI5a2JuqtCKSzruPlzHWJvpKXkVmAhEAxTMdIBUy0zz0t
	 +9rZ/9roeEBklcJ7zZ9Hpgsyj0K0LB8NSPT/dN6Zd3M3Rdba3FeJXmRhNZZM+CFD5GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I0ClRqk/WykpF2nJxtM1R05UGGJa8Awza8XPwptjj84=;
	b=02m6L+Ly6/ePBGpCEQy8H2xZI2HmdLUMsrHjmu+uemhJBovi2z1gqP26ohneteqvagPB
	 /VAjeobPWJYPjh9jQhns7FkJx4n91oMnKIWKORTulxgrDrbSAnli3+IOZF/OmxjIq/XSV
	 Szhm0o9UQK3YxhHS+KMYTJcNKjJH8Gd05JYoVAIrJaRHM9YLGaiA1u1U+Lc9NyNvCDKFZ
	 O+fe9ur9jmxtTimLAptLIS687W3EngYHP1fDY83B9St+zI340Zx+84B/dCRjwe5ia8O7C
	 9nKrLRNVhHh8gV0xUuhmDI/A9Bq5tFj0doWMKH+MEWHXfPmlkqYNJKzFNp8Vs4E/1/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3cxhLPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340966071851
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3cxhLPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A181F0089F;
	Tue, 10 Nov 2026 01:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273993;
	bh=I0ClRqk/WykpF2nJxtM1R05UGGJa8Awza8XPwptjj84=;
	h=From:To:Cc:Subject:Date;
	b=o3cxhLPD0ThmVEb3UL1FBnfdyxKqh6HbPy77p46dFh3DXZGaiAx/tr1pSUTm4gxsB
	 F9hw4l8pODp72zsTbpSzzF0+WiRGNqgi5VKXOoN/7Bujxb1kdYxPGyHtbtyQQ2Zu7D
	 VvA5htv1/s6Uu5ecBKayA5kAZEGv6cXkpvml5EjVdnhiBUj3FGnmj6topW76wcd78N
	 /0TJIcBV00V6uwe/5ccALNXP1BvQY/HGaoSvjNcyFCNv5/hCw3ySMY9Z9j7PoCgcFA
	 ZBW0tz5mfquzBgKLFhvJiKrQog951i82qaPV4pKHn0sDR93MaLN5dJqgCikUEV8Isa
	 y0spWfTjvAksw==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix initial conversion delay and wait until ready" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:31 -0500
Message-ID: <20261109202631-failed-5.10-7cd60538073e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7cd60538073e465310c94b2a2f0ea8d2f03768ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202631-failed-5.10-7cd60538073e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7cd60538073e465310c94b2a2f0ea8d2f03768ef Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Oct 2026 20:02:08 -0700
Subject: [PATCH] hwmon: (tmp108) Fix initial conversion delay and wait until
 ready
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/hwmon/tmp108.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 91d20a1ce1120..862b944d3e609 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -13,7 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/i3c/device.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -78,7 +78,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	u64 ready_time;
+	ktime_t ready_time;
 	const struct tmp108_params *params;
 };
 
@@ -121,6 +121,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);
 	unsigned int regval;
 	int err, hyst;
+	s64 delay;
 
 	if (type == hwmon_chip) {
 		if (attr == hwmon_chip_update_interval) {
@@ -137,12 +138,10 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 
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
@@ -477,11 +476,8 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
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
@@ -528,8 +524,8 @@ static int tmp108_resume(struct device *dev)
 
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




