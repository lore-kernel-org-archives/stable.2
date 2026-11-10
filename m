Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316574;
	b=BnJ3J/MmoxV4+6JF0nNoqn4vdIATgIAxaeNXGD/4sPryqXu7uaNXuJRys/cRR2M3rm1Z
	 o45b7e0uFiEQxmB4MoRDCxSLd85pB6t/Hs/2Nrd7solok2uX3Qf0UKmskTYU0dn7wRg20
	 g85nIzJe4oPf4PdtpEkxb8jV3UWhjR2l7PrjGACOioPN4KedlKiqTIyJqWrVp1Jbyv72x
	 q+nbM9QmwjdfDvo/DV11UbVC2+L6njCMdjKnN2Jp5iDqDgIETWnVYwUF9MgXAzLxtvES5
	 CW6KQeIqlP4OBneu82kNLYCOP95UENMGm3lfOpARiJ1w5qr+7vV966xLc74YBaE7TLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4uPKM7KsH4LWeJjeo+1ooFDBhXoZzLOl6fU28Xz2zG8=;
	b=VdpcnOXpFk9vPGyWxuxb2vx1HMbcJG2FgMnYK81TLYkphvDYkKmudQyRsKRfWHi6YzcV
	 TkcY9RTTSqNHVcFVSiR45JNiBo9ySc16pT1mI4NYLmoydLwsYVR5eVeOoGjX/QM8sMn4a
	 39YqbLkaNeFJfywL86HqgETnsmFlJk1wvhwdLRxDlhs8jrb5CNsKdOE5/pR0Hul7GvVHC
	 S4myWx3XzxLqSVM+iGK9M5Q4nIFVIDQCdYms2KpLrdXazYDX3q8VA/yJPe7P6cqfq+Qzq
	 ozb+yI3ear2Sqn1hUSadmjZ7xKd6r6b3Zj2rsOleaOT1XqIBrn2KZ/BqIYDrkguweOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7uMtMrm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B32606BFE4
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7uMtMrm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFA1F0089F;
	Tue, 10 Nov 2026 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316573;
	bh=4uPKM7KsH4LWeJjeo+1ooFDBhXoZzLOl6fU28Xz2zG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7uMtMrmQcIQDbDdzd1oGWwXLSL9t7lwGIa4AUdRyTtntVd2Gahx5lTDu59HLp4Qo
	 pMz8cebEvmPO0Bay6NfVqRnZEComFmFd76JuN6NG+HvGzh8YOf+8zxAwzs8Zs1vZpJ
	 NnAgWFyC3UMMR+p2GLn5L1Tkq4dA+jV2043T/Gwa4b/i/ZlO8IbJ1bGExLXf1i+xuO
	 L1OfLGpIJShMu3BeiCkCCB6kInP7EI8FQEtp3GMs7M8uVpzU/niQtISSazIAkE00Sg
	 70pBH9u85OC0VxZjGdFZ26OuaO00yoDAhh9g44y8XUOjGigRlTGZPASeMDD5hNnfVU
	 /XQ+GNSyca6pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 08:16:11 -0500
Message-ID: <20261110131532.1704688-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061717-failed-5.10-56c1d32323e7@kernel.org>
References: <20261107061717-failed-5.10-56c1d32323e7@kernel.org>
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
[ sashal: adjusted context for the temperature check in tmp102_read() instead of tmp102_read_temp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index e867a0c2e5399..181373cc1289a 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -54,7 +54,7 @@
 struct tmp102 {
 	struct regmap *regmap;
 	u16 config_orig;
-	unsigned long ready_time;
+	u64 ready_time;
 };
 
 /* convert left adjusted 13-bit TMP102 register value to milliCelsius */
@@ -79,7 +79,7 @@ static int tmp102_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp102->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp102->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
 			return -EAGAIN;
 		}
@@ -245,7 +245,7 @@ static int tmp102_probe(struct i2c_client *client)
 	 * Mark that we are not ready with data until the first
 	 * conversion is complete
 	 */
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 tmp102,
@@ -279,7 +279,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0

