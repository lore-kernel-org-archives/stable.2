Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049227;
	b=yaopoH1OKUj8BT9f6RqTDmKqPypty0mNrLksz5B58QrUNunNU1k3YSIKcZg0vG4cTlML
	 MRcNMlvxtqv9WM+x7HuJFDcsnGlApusRQAST59jI2atrf1+AEjahRDtorAcppU2ednZQk
	 Kwy1HDe+1WIKtoRqP9KZG94s20othHFkFWKARaz9OO2ZEXiJjytR0L6HXxZbjwxcapAvL
	 /mvf+Bv54QQXV7/lIqCC9RInMoOib30f3VJj+cMQrxDhMixaU3Av2RHCTeF2VFurZT7hr
	 beqZqDuT8aBWHfbsjgji1yxyovd0mIUxyIfXmXT3QEG5Qp6qTUSx3mooIAmJeVs//UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UXMdBk0WoaJ0CDp9tl8bJFGHYaC1Z2epyqNvQxsfX+A=;
	b=qTY1IpC454ewaAvzr1d6BFOIPqlwCqLefCHTO9YWTTorULdFWbRGnTd6m60i7ZkpzN21
	 6BjsFATMf4MLCkC5SjEgzUJY1ZluzT7/08Xfm4o1iGagQWkdVH2dqtQAYkfXRWRkYneb4
	 FWA3rhy721XGeTlb2Q2yYoSumkfpGPW0zMGsdPzYdIP70/URJF+33lcabWZxvZpE3+bfl
	 1kpEu3rp5QFuNbR2rxTd3kwLiUNdNN/dHwHKbHmhUo7c8jq2FOzDa66iEgQJwOPJqrJvj
	 J5dEcvGefcrLCXRoW1NR8WTahXoZ7589OV2EjTMFH3o1IJNCgmwvuQufgcKKWGDo9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tm0YZbVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A6606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tm0YZbVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB71F0089F;
	Sat,  7 Nov 2026 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049227;
	bh=UXMdBk0WoaJ0CDp9tl8bJFGHYaC1Z2epyqNvQxsfX+A=;
	h=From:To:Cc:Subject:Date;
	b=Tm0YZbVtocEgOWQFLUmWLUG8JaZXXyzvCPYlCKrw+ruOkAm6hB0pzGJPRv9rKBnrr
	 Pk1JrmsvCZrgDNjFo0vRdCYbuyh/SalgMyNTJEPPCvD0mPP9eREoolOEpaBVuVA3sz
	 64hrtaHYLbjAYp96sUMUeYvDihjVQd0h2q1/wz08Tj7VSy9YT3iSKgOPDfCQjOBHjp
	 XGEehOC+hT+0eEjWk0Rc2Tv1PEImMzagAvHFMe9uYKLE1580TWgiWj3ASdwu2SbToo
	 etgXc/Q1zXWDXYiw73zZW5QS2qg9FwMtEWvkRWBXWbe0EmSU6w5NT2+zPDzte4xZIt
	 LINRjb1pj/spg==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:25 -0500
Message-ID: <20261107060025-failed-5.15-6b8b1d1d7bc7@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060025-failed-5.15-6b8b1d1d7bc7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




