Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315176;
	b=j0qoIN9CxpaGY71WyCAw6DgABKk3nFTXqNe0T+1lK+YJvNInIfNJeHJ0h9zZp4WrTzDS
	 yQieo2AhFI2ZF89+Awc5sTIU7pMAK02vMq7ZE8dzDat2u8WYdmZmBG6kud0VYH/4/VGLv
	 stswNAf7dl7q9sRV8p22Q/aErUq5swNuU3kgvRw6mIhAqU8lgKRb8tT0Nz9/EiWJONrFB
	 tVFsa/erl0m/uzdydcQvDQoNZZsoKdAvLKsU8H42BbIj0V0AJ0BqB8sKBDNeR6hpAvIl6
	 jNrvIFovZ9oVBXL+zErVdV8WeX1EB3Yhds7UoXUwvBDYm4VjpsqfQYQuN1bsm8eALKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jHQj1B/07kFYbSob5B83EW8pmfCGjRwAqZbw8ufsFvw=;
	b=clQWo9TNDXua6Vmp0eFKELl/KJDoDSCm5/VsNcSXCMXgO3duypCL3Ynxay/c+iJ4qbcw
	 +V1LHlcCj1Uv7a7laDtoJRY98Cr1qyUbtgCbwWaQrPt4LNSIzZLVhDmLIfZgshXJEeJcm
	 VU8BUeReJ+pXIUOdOL9/a9ilwzskass/LhUkkBK/EFrgGenB53VAHO7nQZQzm3rGPK1dX
	 Hm5oNbdbvIFnUY9Jx+t4ntrrw1b++5umjQ4dpbFxEskjbZFB7UsClQigDST3DpSXXGaN1
	 b4BTLfrE3vw3LBJ1lGrnyky0RwqkZASbhk31v1MMPbMrkbq/uViesahVFhwjQuaoFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnfPOfI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB093606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnfPOfI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B811F0089F;
	Tue, 10 Nov 2026 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315175;
	bh=jHQj1B/07kFYbSob5B83EW8pmfCGjRwAqZbw8ufsFvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mnfPOfI6uJTeXls8C44eHDDCoWKcXZ4toMgJRTJpHFFqVxCuZTtwWQPI+4Mx9xGTr
	 VnvfqohrPIRxhOuHesle+Is25kBWLgUm5ewYi4qPMeOJBN0S44JerULSDEwWDJI0hj
	 i53B4c37LWx9XXBJfxAvQFw85pwjevhsOz2cKrWZay7w+kwO1nI7DQuheGSEskpQyO
	 cgcBtzfaoVFFzeWbF1WSkPYalYXIqP8N1uijixDCN+A8NktcjKA/XNKQoas+vzhn4o
	 haSRhCM/rqcJKkfJvlDYLbCMYtC4tgJrIco9WlGTgqLFLpqzLfA5gSPKyeShPzoyEO
	 jnD+bRTRVv/7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 07:52:52 -0500
Message-ID: <20261110125207.1400304-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125207.1400304-1-sashal@kernel.org>
References: <20261107051751-failed-6.12-6b8b1d1d7bc7@kernel.org>
 <20261110125207.1400304-1-sashal@kernel.org>
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
[ sashal: adjusted structure context because the params member is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index e86bedb31189f..d95957d808e1b 100644
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
@@ -357,7 +357,7 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -408,7 +408,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

