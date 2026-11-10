Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314425;
	b=K8nr46VIIyiTipEfDwZ/taPBcKoqgzjk6MfSrp4tSCJlzrvHB7P5l4izEnXJ8FmXp/K7
	 wNAAaBGnep2oq+XmTOorn8AGi+zYYBlfWVs2nWOcI56ap+MItIznBtf1n2uSpUujZJwZb
	 aF0Diqf5g68A6OAJLYVRIdkG8TE6rSMkfeTbxKtX1ssIqRtwfu8x1IwtrrqzAuxUDPih/
	 gQbqHnw+bLjEKxYz+7zim5U7GdIcB4C9tjkjdEzv8LCQ92USiKyDuxMLjoUFJwd08KItr
	 i2+uqpiE4XHm3sogXtuyKibYZRS1Yc7ZiRfjHr6B+QtswY0yrY3bTrTg146oGgLtCwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zFJ/S0+JEf/6tSbYvlYrb5+miveH3EIj6YC7ZoHeGnM=;
	b=UbgvAZ5QYpyyqDEZORQHY2xVOsZeoDKM+B2H4F4xZnMXicX+KMK5QLr0gmboBV+6IrjZ
	 jqWvOUxUUPy/YSxHc/5Vqi01/g2PoZjaPKTarNeVOSAGpQsLsmU8t5FIBmX8P/q6cxWTy
	 qPs/LdtB2TxndNoX0uieSWO+3UDk4mpbBtSxsbgWqiIBuMDLAZfSVzDQ4+UZXHT/vwuci
	 btIk7CJcSfHNp/q+kg2dHxuK0BLHlw0JeHkbGrAjEf3RAbB3OhqnOsCbO1i9Rl+wSsmJD
	 +USMAUVE6HlDCFCzekHbdO9QZ9jiPU9jTd3ehUJjOT+iVPflV8p0SsdZt2KY5xL5CsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DZmCS/8f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0660A263D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZmCS/8f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43391F008A4;
	Tue, 10 Nov 2026 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314424;
	bh=zFJ/S0+JEf/6tSbYvlYrb5+miveH3EIj6YC7ZoHeGnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZmCS/8fMdR0oTWKhPvDlmRaD+Vv6DVPLiPs17FG8Jn6QLkT+5wZh+N6qQBRt9jEp
	 d8V6rH0BbSr2gaDPOt10kkovxmex3KNNnKqWPQINri962CHKVyVKA/r8TKXQswW70r
	 j+5JB4hdXotC8eEFkgCWGn1FzmjpZvBYZGBuNuPIO6vs43bIfYsS49T1d2oJul8DqH
	 mN09D4mNHIrAVIcRx4pNfdKkQJdVjq7EoEwOWpqd+OpzxG7z8gcU+9kWhjKQNqnIEX
	 CN1eyU4rv+Qo6vXPwoy/9PW4jpEAIZw7ZRk13X0dyL7WQkMMUxWiTcct2VCKNbhgeJ
	 l2ov6rBjviUkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 07:40:22 -0500
Message-ID: <20261110124006.1286707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050726-failed-6.18-56c1d32323e7@kernel.org>
References: <20261107050726-failed-6.18-56c1d32323e7@kernel.org>
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

[ Upstream commit 56c1d32323e773b8b927316f8beeae9238576335 ]

tmp102 records a one-shot deadline in ->ready_time at probe (and resume)
and, on every temperature read, refuses the read with -EAGAIN while
time_before(jiffies, ready_time) is true, in order to skip the first
~35 ms conversion.

->ready_time is an unsigned long compared with time_before(), whose
signed difference is only meaningful while the two values are within
LONG_MAX jiffies of each other. Because ->ready_time is set once and
never refreshed, jiffies keeps advancing away from it, and after 2^31
jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
happens ~248.5 days after boot: time_before() then permanently reports
"not ready" and the driver returns -EAGAIN on every read, without ever
touching the sensor, until the next reboot.

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 3d8f7a89a197 ("hwmon: (tmp102) Improve handling of initial read delay")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
Link: https://patch.msgid.link/2952f070f82913aea96eec25d28008d3b9058656.1790358356.git.tom.verdonck@inspiral.be
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Adjusted struct tmp102 context to account for the missing sample_time field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 376e0eac8cc1c..62a7bee9e4b95 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -56,7 +56,7 @@ struct tmp102 {
 	const char *label;
 	struct regmap *regmap;
 	u16 config_orig;
-	unsigned long ready_time;
+	u64 ready_time;
 };
 
 /* convert left adjusted 13-bit TMP102 register value to milliCelsius */
@@ -91,7 +91,7 @@ static int tmp102_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp102->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp102->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
 			return -EAGAIN;
 		}
@@ -270,7 +270,7 @@ static int tmp102_probe(struct i2c_client *client)
 	 * Mark that we are not ready with data until the first
 	 * conversion is complete
 	 */
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 tmp102,
@@ -303,7 +303,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0

