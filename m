Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315615;
	b=cIAamNth6ui17k/Si/lXCE/1asvoe0DbS0sZK/a1OXFLpX44ynNUXtQZgGzkwQdpg96h
	 vKnLmtqhlgaaeJ/t0hGXhTtZIdftBQ9Uhcqw9qiVai6H52ELZjAeWNbI7Q7Njl7h/lSRE
	 YZRsvpSmDjj9uiOB1UmlxMfmhmV0XBovmYffWZCQKPcHdf2EIZK1X1jUMnZUG5Ev/V8Ys
	 IkoU325xBXYwXkCbLe6/fiYngt7HMKtxfM1WhIZb32iMtRSJeDyzYzndn3kUvEczDpAAR
	 2T+UoFMJ2y5sKG5Hsc51COe9NiO4tEOTWlq8G0z/ImtKrG/cD/ig+aaHOqz6liF/Oiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=begtnCSSWqrWLX7apVfnWeTlakMDG12dSaC8xCfdfn0=;
	b=J4kufoGiOQ8pEnDTTVk4t8i1j9ZqclWPy/VXZ9e8J3jj9+Z0uxhYRW20k3JuR44tQwJj
	 HrEKlTfEsXUXP8m2p7QHKOrC73yVLChnfVpPMM+YFkfTs+CfT83Tyon+66SrXk6MunDwE
	 DJZzywZTOL+uGQM7tfO17ECCncZzwQOOK29MKla/zih3Uen3YfFU09yonzrHrNt7zai1D
	 PsBeOECC71lxDnn/U01k8vRXyIxlepOVC/dq2r5iyisMldb8qXJs8fTOwsVQmPmbtw+i7
	 mHKag7lk/vxRTL/j/n/2anAjedyKQ2sw/nBUkDAnndX3wPMTm1hMTDlvbuuHEENxiUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+oDnl1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2063606D5D6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+oDnl1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EBF1F008A2;
	Tue, 10 Nov 2026 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315614;
	bh=begtnCSSWqrWLX7apVfnWeTlakMDG12dSaC8xCfdfn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+oDnl1I3EAMFDqex/I1MdZg4ujZeCiPSeYyhw8IIYNiRuFJq5YOUSCPOZL0efPPU
	 jfWRhEu/yUDYUUwD+40es9UQBEOZCpVYE5rjPUaksMSgLgdJ5z9E/naH+hP5nEwILH
	 rzimZx+5gXh8+3oiE4TXEjFY7UF7IfZJHi7+8YPChj2ugZHxdXZ/9WLHNNOJWeGaCR
	 +abpreseWb39x8xfoUgGLt/rjRZUKZMJ+yu8tBq+fsq/S3BE9GKhDxAtKXvnYBN20U
	 xOd9vucpiD4bKMDtnksW5pZzZ3rN45BReZbTKrhqbiycV1oVz2mD99Cxh68vyZh8u7
	 ypSHMOSu7NVkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 08:00:12 -0500
Message-ID: <20261110125950.1617250-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054305-failed-6.1-6b8b1d1d7bc7@kernel.org>
References: <20261107054305-failed-6.1-6b8b1d1d7bc7@kernel.org>
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
index acb4ba750b09c..4807c7e8fe609 100644
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

