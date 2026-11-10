Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319090;
	b=ZOfCfSPjeBqQUE59biD3p/Bf5RriCWEZe/rwgKdnX4dFsoW0PUSlQpYm4P6wKHx0Nhbk
	 Rjp8MytRHxGH33Np3cIESaWTYhMDhXBFXABeOcbLoG6fYt5R4EtiMXNcP5ZtOItkPFld2
	 LGECHaK9otY9H2K+UPzuNMPhhlz/BIenOwpo9MzEi/WAw71UxuafeZoYVwEhV7w81axxo
	 vFetmfkbv50FC3rJu5BMg3vZ8OPqoH/yX5wpngocfW8gorR3FWvbi/ngFGcxfjYg4ZqAO
	 C6H+s9qOlym/b3KM9hAmQBX32ni07J0HZPO3BDwnEhpt58U8XpjK6uY60UP5F9AJCxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319090;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4+A/FaMtg2fKzIEKGeDViPqxdoLjGqHwSJGM5VlDSiw=;
	b=Zoi6ZLfB/St1eUqX+/ldokSwaUpOIIe1kQbOQtSCQjQAmbRawZ+xluPXjJcWMT/O0IfH
	 uCm9TM1KZs8gvvcp8znmmDRl1yVV1eUy91AIuk2gRuubefijS3tclbwpaJwznV6p/QYBU
	 nBMrLcbE+xHROj/a/EqfqX+vFCiAGwMxGtncxLzC71o3XzTGkYMgpC+azINF+hVy6bOM1
	 1NzgaNaYbHCzXtDrAmHkS2Dqp0GmosCn+28Puy+2P3QoouUa/EXbsfGHtB9UzqBL4dLa0
	 Ttb8AumjJXZ1Rms//eJiNT5l6Il2G9iLMQMgy5FctPQS9UK7UKOkwaLECKFcpDz4qmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnyfFtNJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DF606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnyfFtNJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4F91F0089F;
	Tue, 10 Nov 2026 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319089;
	bh=4+A/FaMtg2fKzIEKGeDViPqxdoLjGqHwSJGM5VlDSiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnyfFtNJxaoDpmNGSewuJN0xh5tquMRpJKIhOduKudlDmWAPGJt4nkxELoc29Lbcj
	 lFfpSA3XaG6sA8cifAXexpgKL78RWKM/zsbThNfVfglWMtv9ZGrQoIz8oyZQCi/C+k
	 rIkLASHyzaJHBLsNqB28AVetn8NmFXHf4nHe/EIzSH1A/xHbmtXumDDG7MfBATH9+3
	 9TLfG3RMYdCitCxvqiDHvZsodRlZvq9WETOEwLDcKrRF2XVrY9Y7T2++JNrA0NciBV
	 8Xn6RHYhGbz0WiUu2EuM0wlJnwPD0jBiDwlNb4TPXxfDvmAShXY/LZ99m/cQ9ia8+h
	 TXA7VR5WNDVCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 08:58:07 -0500
Message-ID: <20261110135750.1656001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061713-failed-5.10-6b8b1d1d7bc7@kernel.org>
References: <20261107061713-failed-5.10-6b8b1d1d7bc7@kernel.org>
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
[ sashal: adjusted context for tmp108_probe() instead of tmp108_common_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 5435664c3f6e5..4420774e6bff6 100644
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
@@ -405,7 +405,7 @@ static int __maybe_unused tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

