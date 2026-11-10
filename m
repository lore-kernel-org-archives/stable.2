Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314045;
	b=h6bJIZ8x/sFomWiEvZ1fc7rhnq8EkTRYtd/o1/t2/VzzjT6FvzgljS3aRjRuZXqY7riR
	 M/qqiZtx1aHaQbtYm8A8G3H06shn51gjJBt/rhwH992SMHZ4ct+hDv40tPxWnl4QZ7uxi
	 +09ReRv86M31f2hDKQYep1r5lK7WuQ3zEri8z2SnqBHZtjCvEsUPL2oId3+k3f2zz0v8G
	 khj1GlWZ7poxZmhSeVslaOw1vjnrsy54S2612Z+Kw/pTCEb2a7J/jpKaOa6PO3FZ6k5IZ
	 aEpL9r1Qf3FgV4M+KC8RO4onmczSFQzUgNN1B73/xgf5K7Mn3oXcji2yPXGa0gzvxRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hQQt12HIKOvm35LUIZZkpU/hUhx2h13LoET6a38F53Y=;
	b=2CaRQgmiqOePqSPfn08vlS/WbiZdSk0N8boX8988UOXyCr0nslsKpf39dQiJwfPb87JL
	 wtbj1fvl3bxA4toxmvhfn2u6Mv/A0GFOlixPmnoNpNPCXFlOy+to99RB0gxVI2IzVIhum
	 keIed0jP3lcp8TJ9/BcTeNQa8pk/I5K5GfqqgUye8A7KCETOwK8XUBMPTEtrc7aq7eOpF
	 TiviF1NAMvJ2wD4pyJauWT1CehDenW+aUjliw/gt6ontCs7cGzGdD6txtNF0imUt8z8jE
	 vdsUtQY+eSJr/Q3i6MyGeVusk1Y8MAfhkKGsLcf5bOtoPvt399RbK+yq/iwIZ1JJyrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drww0I9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE99606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drww0I9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730161F008A1;
	Tue, 10 Nov 2026 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314045;
	bh=hQQt12HIKOvm35LUIZZkpU/hUhx2h13LoET6a38F53Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Drww0I9R82h7aOJv8R9Ra0zp7sP51Q4cFV7sJK8a2J5grWmZZSoxP/UkpNMMooESB
	 jWAwvPOHcmRlgHruK1Q27dF9kgWcfbk6myZzSGvVaUUVogkmE3I39eHjvQpnnXaLlj
	 jkUsK4VUxws1kLPtQM+fsMD1GF2THwuCp9VrN6S6Foo2tHNNAKq4H3m2FZo79t2CqV
	 GuOwILmeWzrUPfd9Liwm3n08itg/sHLuYouahNvNShVmfjG26eIMEpBqWIEPZ6R9GR
	 eSaXytrh30TRbW/4R3wC9EmvISYK4+4hlTyAOoEpx5rEJVUItMfMmsiyFYErJDyazK
	 5l2qFm23DAABw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Verdonck <tom.verdonck@inspiral.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Tue, 10 Nov 2026 07:34:03 -0500
Message-ID: <20261110123339.1219530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050724-failed-6.18-6b8b1d1d7bc7@kernel.org>
References: <20261107050724-failed-6.18-6b8b1d1d7bc7@kernel.org>
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
[ sashal: Adjusted struct tmp108 context to account for the missing params field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a971ff628435b..b298fae9296c6 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -74,7 +74,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	unsigned long ready_time;
+	u64 ready_time;
 };
 
 /* convert 12-bit TMP108 register value to milliCelsius */
@@ -125,7 +125,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp108->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n",
 				__func__);
 			return -EAGAIN;
@@ -362,7 +362,7 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -413,7 +413,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

