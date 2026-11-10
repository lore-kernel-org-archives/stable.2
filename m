Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315641;
	b=AqCHFSksmGO7vkQGM6qDh4K7lmHWtYv+m9zOW0ScacBwZ47CSIXH+z8c/GrdnNM83Den
	 XDX8nm+dHPYVRW1OCrXrhm9vzx6BAGAgFywiPTBH2LT6YQ131mA8aDjJM7SZXO98IxpuN
	 gJHQqmg+qqYRp8Z4wCsFyrUZyfb41SrT6l1CSvCeTg/kTaEOW45+8WdqAaGgLju7MpYVD
	 UTfwb4EpJdSoDNCcKNIgTD3G6HUKB5dnc9jYzZCnjGxA1trIf13LemaDa5O0k85iAD2rW
	 mOpRQ7V3X0CSS6POM9BN5P7kNqalUixMiPGJUhlN5sIwx22AzWBomQoK49kBUaOJIlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a9PZr7EZaFXF1KOq/7EO9VeWbpfMKdnq7VOY2Xr2+jk=;
	b=qs/xxi4Z/79U14OlOry3rA5xdEIMX1IXNKgZVxyF6WVi23qLuklxwaRttV6HMjyAWJJq
	 gnFhrkuqrbXL4GuGuGNWecT/uPfU1aX5NTPwVsgSw6FpKJ2P63dVwBOuDtd+qYi1wN/la
	 xx3GXLIUWRl4TS2rAqfS/R7MMiEBbazLC+BaosV7pIB7cwtiiVPdswWn+qY5Gn0R/lLsP
	 qjVMcU/QwwukmfzkbUxCBvr8cbnONagskElKt3G/KP1TahBce9NPQ3mY93dagt6NfmPqp
	 b5/xA5R33i37eplq4Lc4vFzR7U098fTsLLpsKh3WIL1/pHL9a4hpzL0G/9d9T9l/0IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ4WXpao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17D606ED44
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ4WXpao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE671F008AB;
	Tue, 10 Nov 2026 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315641;
	bh=a9PZr7EZaFXF1KOq/7EO9VeWbpfMKdnq7VOY2Xr2+jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJ4WXpaosHtblm/0PmNoUkAYzkXMnKKlWoHWyKXLjMJrrVThKENXVEybXF037/bHU
	 DBjEO8fLBIsiyxYoX+SJJh9CZtxgHBP7Ff3HwVUXpyWHbxqzf2fpb419AnrLSBtBXR
	 HF7dfoZjT9R7JCXV7pm7pjhordNARPAyrlrSCUHL54AyrP67uWvWWbO6ojXWQWp3Iu
	 4gcjIu86T6m3QD2+mFmSqSb6vcW/o/daxWWfpNdmp65qzSeOmpqxCC2vJeWKieN44M
	 qNHK/IPSh2b/C6+lmSIRtkqqIbfayTc6YpXkU7urEEBeob474vbmtQVth8MbWRizcx
	 jAyAbuZQbPOSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 08:00:37 -0500
Message-ID: <20261110125947.1497852-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125947.1497852-1-sashal@kernel.org>
References: <20261107051756-failed-6.12-56c1d32323e7@kernel.org>
 <20261110125947.1497852-1-sashal@kernel.org>
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
[ sashal: adjusted context because the conversion-ready check is in tmp102_read() rather than tmp102_read_temp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 8af44a33055f3..967d2e7e8ccf3 100644
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
@@ -278,7 +278,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0

