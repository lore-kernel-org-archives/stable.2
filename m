Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582560;
	b=ZfR1PKkA/KWfJ6/VxRrEn6Yt0NPTzPto4c31XRS5oTaPSYNTccw2ASSNom8qoCIs5pU4
	 kjUw0K+hzdPMgo89Cwpd9t8YXaTjWyur2QS5EUEY2Nkt/SjdmveY4jt/7njC3ryRj2Zlx
	 ve1lKY9f1PMCkFcnzsszS7uaOvFFIkdswGKIWfQ7urc6I1pf2ZShfM5B8whd7uX+2mMz7
	 lRXElPaqXbegPZlfWLnrVQYr38DAatS4Eem6pW+qFo1OWALfF8Ef8M97B1Ew9CRIs60gP
	 XMEMFYFODNmImk8+xLxPXxLhlBYu+oHhHZhLHFzs3KfSksIUrX7TT21JQcpvEOHtW6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ExLLxGgYiTuTE0ubyRySuZ1SoID0V1GSu7ud+3dHDRM=;
	b=t01ckovuyoh1QrRSjHM0gfikVol0H3y6YZ550+Me3ENZyOHC9fFHXv5aS+JftEkil+PB
	 JIdeVpT82Gt/HCXkj1AUCe6ynGy0AkaKop+zTWhJkOYdfH7OuNJsyc4daf9sgD3iuVUWy
	 4t0P3JyeAEDSaj56JjNytkYvIPYcvEe+ritfhsRoGIxVNeG14uVOId+GIEAdc04buCJri
	 3buvnibmrSbLOg8f3Z59u6hcZzBWXlvY/69KLj6zU6RVl4O9IamVTSAINutz3JGewXOdi
	 4SQ/MHbtSkKLPW+WABSmH2LtCJ21GwmJP3YjpkDoKLv6V/hxj/ZrcevM7BuinaIBuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Gtm1QG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56039606A883
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Gtm1QG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA71F000C4;
	Fri, 13 Nov 2026 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582560;
	bh=ExLLxGgYiTuTE0ubyRySuZ1SoID0V1GSu7ud+3dHDRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4Gtm1QGjowRuabRcFsTlTmi7MR9dSG3+eqPiv72AKRuCQFMKFmDvpcU4HAe3IO6j
	 4hU707FBhXkLvxSQgc9LB2Ht7QxS7BTa3TraaoLNSFOCjuA5GukuddOT6HMJiUowXF
	 3rKtkZjJ8bv9tmcMZDdlWdy6Xy46M/JLyUce+veAU+T2Qh7R5LlFZAxGO9KR9wmF01
	 xKtt82eEyvHsDybQaXSVjfFsFkESKStIMzg0wyP4AwusZ3pnGWz1cjZAazP5ZxhuBl
	 YeN2dZBmhmjKjgazdFTwpCZqqa28E4TrUCavXUtaTNRKe1q3xLXTqo2oCYvkrHgFqM
	 piIRmvsBQstqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: (tmp108) Fix initial conversion delay and wait until ready
Date: Fri, 13 Nov 2026 10:09:16 -0500
Message-ID: <20261113150545.1865145-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150545.1865145-1-sashal@kernel.org>
References: <20261109200723-failed-6.12-7cd60538073e@kernel.org>
 <20261113150545.1865145-1-sashal@kernel.org>
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
[ sashal: Adjusted structure context to account for the missing tmp108_params structure and params member. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index d95957d808e1b..310f8cae1fd84 100644
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
@@ -357,11 +356,8 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
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
@@ -408,8 +404,8 @@ static int tmp108_resume(struct device *dev)
 
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

