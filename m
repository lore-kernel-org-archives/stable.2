Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514497;
	b=AXgW0mWGxH5afCR75nNAD/bJh7ijnz8KAZpWXKF1zRcsI86055ZE9VorqWVtarSSY9n0
	 KtwTuJFGHYZKcKI2gdiWOCXhhaNPlY/NRsuzte53WVAyCOI8IbWSmMqV7T8nucx44iuuA
	 pmlnA7xw6d9qIwe9LT+ZNpXcVEtO6yPpww6k5riZWrKQI9RR7+RGEByFHpkRp6T0/MzDC
	 gw73QuIGg+z6QnwQSN7eu2wiEKWm+abeKUKTM7q1Km1hivkiehIfw/vxkAzI/F6QVsAS+
	 UBLzpm1I+VfLRqdu2e6mm+uLcXt6ie+jC/tji/ErqmNLx7khAmYcv8dlIuWc3iL/NFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FYu0ZyoaD1L2sdma2FJNCEQTwtHiOVFsF2IiZdwITDc=;
	b=sfcM/YoxG4zGxn3UymuFLnHoAsebSK0BkC7JWB0FWI00hRTwID+1bc/l+eUA6HsAmjWG
	 bzThAn+lWok/r+euHnZEffC4auAkiFs/mSLJaDge8XJLur7Amnhqd88ubhBdiNp1MPkkW
	 SnnlIj7ewHxnO/JBvw5P7XB5EzsMZZj/S+uglAKM/XZ/SMlXZqQYh6VdyxceGnYEdBynP
	 KfDrNm80a4pqvFKPG8VRaTvNXGfibqwC1uZJvgvfW8LZhiuDZaCR3ijNkKzxvvfFslmS0
	 5MN8jAFn7o+n41M4nNnrsDQNYRP51gOa1m2oZYkGpmcj6v146kUilEpG6DLne3ju9tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gC6CzjOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB2606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gC6CzjOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4521E1F000C4;
	Thu, 12 Nov 2026 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514496;
	bh=FYu0ZyoaD1L2sdma2FJNCEQTwtHiOVFsF2IiZdwITDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gC6CzjOlcvlEs/5tz0sidNNPfLjiIus/OdEFWbMzR5BMufTWps7YikI72ys+XonFq
	 MFMapPMQlDXyTRFIvEWyMm2O5mJMXXm8dG7x0nN/f2e2a8IjkEsTttMoLru0b9soy/
	 Jrg1Z9Rx5AtLxUZM/Jzg15ZDdQ8Jp1HY4jn2ZY5oGVKbrfFVz0kFA4VgjKW9PS5vg7
	 QEwBKP2Bh3XUUXQFPr8k7bo9Coz+6yy7Rj1k3Gz7ggMCxdv2Uq9+vCJ1dg+zQFjyUA
	 UstGoWgPMLrt+uzwVqd/sn5Rt8i6CzVIrBaLBSaVIm+r5Lt4lpIojhI9piQkzSu74x
	 ZvPWsSR44Picw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Thu, 12 Nov 2026 15:14:53 -0500
Message-ID: <20261112200225.3377761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200336-failed-6.18-7cd60538073e@kernel.org>
References: <20261109200336-failed-6.18-7cd60538073e@kernel.org>
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

From: Tom Verdonck <tom.verdonck@inspiral.be>

[ Upstream commit 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a ]

tmp108 records a one-shot deadline in ->ready_time at probe (and resume)
and, on every temperature read, refuses the read with -EAGAIN while
time_before(jiffies, ready_time) is true, in order to skip the initial
conversion.

->ready_time is an unsigned long compared with time_before(), whose
signed difference is only meaningful while the two values are within
LONG_MAX jiffies of each other. Because ->ready_time is set once and
never refreshed, jiffies keeps advancing away from it, and after 2^31
jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
happens ~248.5 days after boot: time_before() then permanently reports
"not ready" and the driver returns -EAGAIN on every read, without ever
touching the sensor, until the next reboot. The continuous-mode path,
which sets ->ready_time to jiffies with no added conversion delay, wraps
the same way.

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 66e1c9171339 ("hwmon: Add Texas Instruments TMP108 temperature sensor driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
Link: https://patch.msgid.link/525fa49d8c50922344fa53e22be5e6133c9bbb62.1790358356.git.tom.verdonck@inspiral.be
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Keep the opaque per-device parameter pointer next to ready_time so the
subsequent conversion-delay fix applies cleanly. The pointer remains
unused; the unrelated device-support tables and register-access changes
are not needed.

Stable-dep-of: 7cd60538073e ("hwmon: (tmp108) Fix initial conversion delay and wait until ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a971ff628435b..f8b2d88d14665 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -74,7 +74,8 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	unsigned long ready_time;
+	u64 ready_time;
+	const struct tmp108_params *params;
 };
 
 /* convert 12-bit TMP108 register value to milliCelsius */
@@ -125,7 +126,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp108->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n",
 				__func__);
 			return -EAGAIN;
@@ -362,7 +363,7 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -413,7 +414,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

