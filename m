Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272845;
	b=BQj09NpYeCkilMetxQIX2RisqH2PrDUMs3YdS0+wJi9+azIC7bXrCRUFfBTUj5/r/ctb
	 6Wcmdi5Kk5nLI3iqRjlPpb8qtYiUlpqki6XZrrpt/sHlJh/yq1ST08onSS+qIy2fAc4Rr
	 AwXOoszbZlKP0FdaHQpTkD1wWzunjfFq8CEWYZ4saxJ3wXQeIMnzsFy2FAG5bmJpqN5t3
	 mrrl0X6qE6XbMXm+DIqqiYYoRBremxjE14s7+kTr01oN9pGY0O4kKCrCWoUoxt5x63PCq
	 2xgP5288hI1iR4oHKrePP4GmXLpRcBKpgauT7F956hm/VuZW1VdYc8xqQxLlWScuH/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BuEPuTVJ3RKMnaVeBqSEpH5nGmc4GpHW/Oq+8ctC/so=;
	b=BzAk4w1ZYY+upYK29S3cTwye8yG78nEh5Mc67oYLJawwimORTYLYnJdcfqgH8Hn+iGd+
	 scHQ7h5SWyuv46go7S6Y9sWyhR9IQd93DZZ84QO2QSi3KNyhg3DBdsiAZAd2eQo9odaVi
	 jK4qddL1/IJkQ2NOg+O9bIWn5YVyec27O9RUdZP/zziiH5QWhohTjRQ++ko2VbFYva0Dq
	 CrO4E9UsxaFSQyobgU/OeK1errJEI9DeBMr9VpqdO0fihRDGaUfkK9EZCNJG+RUYqvIZt
	 aLCELKrIR7EE3lU2mdXot0fZYZMq+3o8hsyv4eziccQder+m39NIo1vj+0pjR4UencQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqeCNxBg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E9606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqeCNxBg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29081F008A3;
	Tue, 10 Nov 2026 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272845;
	bh=BuEPuTVJ3RKMnaVeBqSEpH5nGmc4GpHW/Oq+8ctC/so=;
	h=From:To:Cc:Subject:Date;
	b=cqeCNxBg2k6leyrwF8/iW0ZYdTBVYaOKmLFupL5BxuX8KYZ0jaB0mPWqUOVylrI22
	 Sr6uEMo6qTLS+r0rMF4Uq+QEmV8OhjAuzaEC/Pq2x34Uvtxemxw8yQld4wAN3pdYSn
	 OgeTeoghWxoXeciLxQx2PDDgmsCvopKYFREfYFyT4vq1ueI8xIBzOQwNdlQO25gw8n
	 4Fuf42r4Sy6ScYqQd1sAoICRqmB3uxGVSgaxfGHBvN/FIdH0S5FLCg01KcnxEczvSg
	 xW7ZgR/3TW8Z7HmA91C4eW65hbA5zN4Boa53YKZruhppp1ztz4O3NHZuWey4EMjPSD
	 GmItdMC+De5mA==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix initial conversion delay and wait until ready" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:23 -0500
Message-ID: <20261109200723-failed-6.12-7cd60538073e@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7cd60538073e465310c94b2a2f0ea8d2f03768ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200723-failed-6.12-7cd60538073e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




