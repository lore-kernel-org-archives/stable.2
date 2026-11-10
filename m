Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315423;
	b=y1zZ3wb5J9gLFVaWIobIX/ae5D+iW4JQ9C/pcoX9qJg6orOJ1Djse5GLkTY6tTUTGyj5
	 nrmvcWSDPlZ8mPiKU3VYMhPSFsKoJ/LC/JgqXuMsk5SRAsOWcENGPQISbfC+XsQB1kTsE
	 jbf6M6K9wcgkkuIfrZha38VojtbOTgAczD/GjDqny6groCO4rZZJx3QLzO2uUNk8VFnQ2
	 xDfubb/fiGzzC1Z/reZpAp96hG3P7spnC/BfN3t3fhjBuHwdqBlTL7EYU9rnmmbrpmU73
	 T57NRv9rOFepKRl6y6QzHPcmAqBzoqQSmsvb1pwUBFXyR4OUMQrT6ewxB/Py2mJW3JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xY4CSkSZ9QhYdlsvFD8nPchk3mebSuIUIsE4tIFpWuA=;
	b=3LKAmJnFNX9NESr8FP3pT/wtNbs07O3XU0dg2iUPtOsZ7WYkXU5pYZW4RSql1UZ4axSN
	 HEm0Ejn/YFDSifdZY8/2C9n13ORkPDKVuI0+zwy8nX7x7/h5e+z5n6seMnY2J8YhpATiD
	 vr8F5oZL/lSr3nBkplpVVvBvHAGVMm+9fTllFEJbf+65J4nDP0CQzrEEBjgvsxo79FyNa
	 eFLM+GkTuSbX35dIkL5nVTDUcQvl3HXoDFJG9TRtII+6QxWjSPXJzz7EUdAx2Zvqen6tl
	 HLFhouXrNpKEOg9y1+YAGn2vZB4XcadpWCl3kMmAfnJzU23xdWATo5ee5Tj5fburo2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+3nU2LG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508B60A3825
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+3nU2LG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBBF1F008A5;
	Tue, 10 Nov 2026 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315423;
	bh=xY4CSkSZ9QhYdlsvFD8nPchk3mebSuIUIsE4tIFpWuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+3nU2LGgkfNPLXq+YtIMSDEKcu+euEQ+j058x1X4mJ/l14dzWl5z33Mf2TnO9OXX
	 nlx9Fh6JI9mzRgKN49YOn0ZKXfL5h6GGK+HnTsIOKWK7NX5+cHIrqF0ge4pfk4u+/w
	 zcbzxHoFTUH7zIcQKfdmqtP3yV2J0NGwfNtfvTqnGeE3cgpiFKXEzoUPCUcv23KMRY
	 wRih01m+Bjyks3xHdwMdJuRw6H+t2ZtUHu043FNwnhJs2+YJ3g1inDF+MF3VkIYp0e
	 6YGPuA6sqhKyWhO3GkOtQbbfEj9b4WFVePDM2xLIlMwfDaE/wMWWqJnQCLEtVkINJZ
	 zPinBEHillRaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 07:57:01 -0500
Message-ID: <20261110125645.1564329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053024-failed-6.6-6b8b1d1d7bc7@kernel.org>
References: <20261107053024-failed-6.6-6b8b1d1d7bc7@kernel.org>
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
[ sashal: adjusted probe context from tmp108_common_probe() to tmp108_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index d7a09ab2bc112..c763efa6aac49 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -73,7 +73,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	unsigned long ready_time;
+	u64 ready_time;
 };
 
 /* convert 12-bit TMP108 register value to milliCelsius */
@@ -124,7 +124,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp108->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n",
 				__func__);
 			return -EAGAIN;
@@ -371,7 +371,7 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -405,7 +405,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

