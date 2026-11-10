Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316329;
	b=iXwuhBNzBdhBO/DwBWmxRwEDoEuYKTGTqrMYq5kmgb7GjKQIjVYXaUzReigeSQbXDWhv
	 lQu7NONijhtchY9MbnHZKfNo/+fuc35A/erOZk8C92d0a9X1GqQXzuBY7c70eZLDtbkNp
	 ccve+0F3aMKoz51R8PPYzqXOHZG2V8lykxoI6Julauoi3JsMpxUhBlKDM0NhXFFzP8QBx
	 8DVEkIb62uEOz/ZhDUd5uGEu3eqyKQAPMMyTGHg8MXOpKqGKOiksGHFsuzApHv4gQLhbr
	 BzpWv+qz/kZhtiw3k74ERV3qIQnhT4Z6C4dkJlyuz/8QFdWXowSY52wYpf7BwigQsuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pE22Gztr5bQmWJ+g55NKq3r2d5hgLjACeuD5cUfGKUY=;
	b=b/oOA/DTEcirXZQ0i/ieeKdth//nAsF/XUYoHtdz0A5MBaSLQDDBMDg5rumrn1tcoutw
	 XhLltg1LgJWzas0WEOy1r+kFds24Xpx0hY2i4ExcgPvC6rE43ot8y2QrlD8PvZl5klJ+E
	 Aa5W6VCfOHqaapderTxqXpIciGsFD0OOpNWql3y1RKoytcPdgahmDSHbP3aNF8bdMZjYP
	 AkQIWd66KqHPW5+zgnnU+sGTYx75Av0vbPiUJ7hu5wLKQlIA3ni2a6FZ9ehlI8Dc5DJWd
	 CBf06zX+1EkoBzT+JDX7ZtHTD7rwmdgzelr0ng5f2qHlyhjMwHtw0vcBDeX8dJDva2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7g7glPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E77606A761
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7g7glPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2401F008A1;
	Tue, 10 Nov 2026 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316328;
	bh=pE22Gztr5bQmWJ+g55NKq3r2d5hgLjACeuD5cUfGKUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7g7glPZyiQa0s+TVsNYCp4qRGsGb9paTJGtlcEoef6ZCErmZpX809/qcW4FV7MxH
	 KixpcJd9g01IVZHDSwl46uxMky1g7Kk8MpxbAr5MzJrkXS18uD1OHKsHdqKEBcR/oF
	 yHAOd4Fl/BLPVl8+3iJdWPWOH5EucGxxln8wpzt77onP+iEfcX+pAqfcxgfKub3QP7
	 keSuWg5GPKCkKYPzTtJXxJJS5QORRMUJUCbEGphAsMho3io6uKMS+kBYxvu6ZZPxz5
	 UZkye70nOTjYvsrkAfvgFnxqn1qcGOAScMUpQLSudWstyPKmajGM8I6Uk9Faw81Cdu
	 jQ6Er3CsGKeSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 08:12:06 -0500
Message-ID: <20261110131150.1673779-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060028-failed-5.15-56c1d32323e7@kernel.org>
References: <20261107060028-failed-5.15-56c1d32323e7@kernel.org>
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
[ sashal: adjusted context for the simpler tmp102 structure and tmp102_read() instead of tmp102_read_temp() ]
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

