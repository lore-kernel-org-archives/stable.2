Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046673;
	b=38miCzGL+IsNR7VIf1ilvMqpWvwjmpWlky+nWCqGwPZn7S5lDQgxJRAy+1SGlC1taGH3
	 BEmOoO1nbvsIQqiNaY+9WODyI297K6JPwCeg6G+W6Jhf1C66G09bGz8gaNtKFK4z6dz4z
	 eFiOlxxEpB3htVLlpcfjrvzEdmx22q14QK4eW0u9ch3Gxo5qHy0A12ejLZvOlS/4aNeXr
	 jA0r2vRVs1LxZAvX45uf930q6DVyxBwz/d9QPV2GiqBX4uA3DByj6z/laS+1BOPkV6+rS
	 HH2ogGcgDHcfKBYA2cpgs5XzYXyGzbNGGKDqgRwIg8dpr6ton1hLSiLheMQy+gE5pfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=seizSwtuZ8e1af2gPI3Yc44LeWdzp4paMtQ8h6xOFaE=;
	b=A6pHo2pRWRLzfD2z9lKqH0pABdJtPvjx2AC5/g7xOjaYFHySzEP/DlbgAj2xEheJIUrM
	 Pr6AD/o0QRcNs+54t441r1iGb9SW3O4CKDXcVI6dY44LaqDTKkdqXB/M9awC58pwprGT2
	 xJLgRg6LCrW2bNKO+n05gkqsYIesCav6ymqG8YOFSvHrSGeM08rLBr/AFpVBdEHgRfHP9
	 rt4uQDyERdZ2UKnzQ3XIr0bj9HSSAx6Nf2ecICwlqtFxd7FVvJE5E482TBn6s9AvEYATr
	 wMXvWekLtnTf7EWzyjP4/fO4fZRUJukpOcbQkWY4U1hQi5bthvKxwPEoSp/PvLyVcOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvP6P+CL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E5606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvP6P+CL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0C21F008A6;
	Sat,  7 Nov 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046673;
	bh=seizSwtuZ8e1af2gPI3Yc44LeWdzp4paMtQ8h6xOFaE=;
	h=From:To:Cc:Subject:Date;
	b=kvP6P+CLkCjEZR0ZfGGwGIyW049DO2Wwpnbmk8g3KmIF4FvwR+dct4H7U+jUEEgg8
	 zkjNbFRLe9zGOUG6ZmslZmHIM4wseeKXqzxlqBp3og3031QZMc8T6AJzyoZ+SmW+vb
	 9xFw5lubsQ23cgX/KSho3Wj/xx90AFj6ESxA4T/uiU6HlpYUAC8mGm2gG15ntcpjjy
	 1oQzTPoovwQupiWEAcW9IntsrIy8Wso1NXZl5jjNRLVVessaKfZQIUhT9C/SWggd/b
	 NwWgzl1mOy8w7a5qrMjmEinQrq3C3ef2GgdcD4aZt7WGOj94Nsdchsiev+a7wqbPob
	 NRoS9jmE3mZJQ==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:51 -0500
Message-ID: <20261107051751-failed-6.12-6b8b1d1d7bc7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051751-failed-6.12-6b8b1d1d7bc7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a Mon Sep 17 00:00:00 2001
From: Tom Verdonck <tom.verdonck@inspiral.be>
Date: Fri, 25 Sep 2026 20:23:23 +0200
Subject: [PATCH] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready
 check

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
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 9fa31bd66ff69..91d20a1ce1120 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -78,7 +78,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	unsigned long ready_time;
+	u64 ready_time;
 	const struct tmp108_params *params;
 };
 
@@ -138,7 +138,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp108->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n",
 				__func__);
 			return -EAGAIN;
@@ -477,7 +477,7 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -528,7 +528,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0




