Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047426;
	b=Kafq2TCTD3DPl/EKDR9NlNXBaYbJrfFveNYdKjfsmDgMFXx8BPmOY68foHmwwadwqZmp
	 BThdMz/6/1/d9MXTt2rHEmtxOpAGg05iM5gr2bfp2/El077lEAFtZMPZg9v8If7IyC60q
	 g84JzmSlBIBtOvydQsaZvxamUAqoiLGp/FySh6DF9m+jvFmONEMcx3XnVKnvc4GPgVlkG
	 fckYt/aYs1Iwa4FDLy5b0zd6E3r//1M7SCDI0xc4SMOSaTA2gy5SqO/eA1zr2O3eeitGp
	 tPKQgjQohT7ct81jk1eWxqnVhlVqWALfpWIleKsju/3A/8VvIA8nrOh2yvW75tR7sBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/bzuhQJhO6lCq9D/78/dl5LN74d1SFOKQifPiNja+As=;
	b=gHCxdYAGhrdUKTZ5bz+YW/WeG17t1TgkuzdpSRrpPSZkz8fHOD1W3gyzfzBpExetXInq
	 nxzJP0P1W6Ijy8hZ4G3H2NE/PsrX04d1oXdrA3t6egSSRrHg+673tczzVEeEOQaj8Ahsk
	 hExjqPHjiJTO7tteYHDULhs0+Ke36VVb9lKWN6gS8hKE5dA4UczkLeVBh8Lvu59WfPtTw
	 QEDhmomzO2eu8n2L9YS1ckCeZpJx8dxnyOum8O4vtzpPaH7XA16S4QBGu6J7E3LSmLEFf
	 wi5tJoK6uFkrp3J7ZxEijNVN4w5UPZCDjGytzIk3umXLpXHCyezEBpNId3K/G8i1FTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRzPsw2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75891606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRzPsw2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FB1F0089F;
	Sat,  7 Nov 2026 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047426;
	bh=/bzuhQJhO6lCq9D/78/dl5LN74d1SFOKQifPiNja+As=;
	h=From:To:Cc:Subject:Date;
	b=XRzPsw2vk/DJLD+lExyTG+oMv489nTPQlmGnvr5gUwG5G2nE4bXMz+FBqrVPlriYu
	 txacoGxuJNWgcX60WDtDMHTl+pRGTdfFDs2GAfy3naiEc82CHhP/oj9BDdho3OaJ9O
	 qn9OQK3i5f5QvnetMXFEga/vR6AsFJ5TIRt3aONpw1sjqPpJrTlo7r0SLHON7md03q
	 lV/1RGRUCX3rkok/WYN7EaBu3cKi8Z0wu7t4hAMsFkZi5wj0LEq6D9RFQDiHHC8SEG
	 37eSEJnQEG6Wm9K7HCTJUcj/FCvJJRiA6TSmXfh3tldeq+GvWs/ZuJ8m7j0kTcNKps
	 gyUfts6P6Ou7A==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:24 -0500
Message-ID: <20261107053024-failed-6.6-6b8b1d1d7bc7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053024-failed-6.6-6b8b1d1d7bc7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




