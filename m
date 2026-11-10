Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273384;
	b=tLke0x9r5uKl/JkqnYm4sHuYscWBEcIYFQn2zuYjti296MPpl8zMUN8D444j4KbjVv5P
	 bnzI2MFM9EO1xsALhn6N9twf1o7MOqpr0kMqi0G/riEbTD81fXVc6ateR1h14YN8wMKjI
	 uxjQA1o3fE1VvcBaBz7/XbmaOn4tgipC0xmDAf0vUvPxgsuIGGaHq3uo1VBFB/GC6FacM
	 mQxb6dp34jDvehv4+c9PnWK6eBkpe/HE+6Yqx35yz9fngd5ihPHvg4zZ3CstcYZlFXdjt
	 vPmKv2WDA4HzFBfg9tfLBy/NouCrIYQJ4TgP1EO1JfAR4vx0kykXm/slbBDSZ8ICGuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R+cqP8Xtsf/AgrJjDAmxDhxHSxqU5doc1qQ9HACrq40=;
	b=1ouLiUSvVOhuedQluwOHztUAloIliIXlcAvTSEDP0WE4W5NVBZI4ZaqB3p2UyfFMn2hY
	 veMFtemihFpAWRk0CnPBKfg0LmInIZoFUiVjsl46Lf11jI7drpFtWksAuBJN5xM2a9uvS
	 IxSeZTp3YKSjWuNUTTGr7MmAfR3+Du0qfZiq1ZXKUjpm+3CYcr7TAkeVbGkMjhbySXWfL
	 mFEeeZzM2Gr6etDV02xrF1S3BGfjrKCh7Ixd4ekvT33EbD2Wqbl16gbX5HtjrCirP23u7
	 54RvKto6o+1GesPpTLJL/Sm/Gt3qFPoXeiqA3gZUXGKBpH8r1F7EcbSyTpM/gHgmDwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YR+uMIRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627160A2622
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YR+uMIRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C01F008A1;
	Tue, 10 Nov 2026 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273384;
	bh=R+cqP8Xtsf/AgrJjDAmxDhxHSxqU5doc1qQ9HACrq40=;
	h=From:To:Cc:Subject:Date;
	b=YR+uMIRzjmm7AqiVcZlAwctECE98fZMNv4/b6N8cyGFIaR+xAxadoCyoqnw9EIUWu
	 PzZYlKdm6JermRqSe8U8i1uy35OR8mLfl/InHL7cFIg5hHJH8GQpeMx/gcQWrHhltx
	 ZhPrmdtGS02hYJVfbAVVTfLXjhwHquBtJGKsLFP+rDxIdlpmm4gR/P6oJenv+BaKt+
	 6WqTL3ItIsDN5/VN1qyFrFt2gL61/Ghu82b+ByBULYgnAptu5edjTPupDGNdpSSLGM
	 XKx4+IShmrxWamzSENcqOiks6eFB5OF5dADgaLov0M29pcyZBVtkYfW+QfJDIvcCDy
	 n8DxMGj/aXVsA==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix initial conversion delay and wait until ready" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:22 -0500
Message-ID: <20261109201622-failed-6.1-7cd60538073e@kernel.org>
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
git cherry-pick -x 7cd60538073e465310c94b2a2f0ea8d2f03768ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201622-failed-6.1-7cd60538073e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




