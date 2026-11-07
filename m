Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050236;
	b=rJsV8ydzP+vH1b39o3Ej65/ARRaZaWe1++34Cx3BY/HjyksbG02wU481r3MlwRocAEHD
	 q1tYkafbWeC4v08yqsN6RA6xsDywimXmdWOKzRZBaKpyeivcDv7BkBZN2uXgaYy3dVcOq
	 kvQwpauAUMazXqKw1T+d1oFFbVDCNNO8E3aWx6gGftulgAb2ag8Fd2eLJU5ENVDzLyNZj
	 UZ44AqUTzyRom5LqHiL3QVZq5c0kQ/IG0E9tzjtRnXz+7ezlxzTpTLKHTJEAJ4HG9Svfk
	 OcscYtzNOpaS1QLc8rKBA/NKkssvacgrpiotuKe01wjyElXDsGgFXwMt3FWSdm0Bl1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GeIudwWYIaTl7QNZ/Rz1cfQ7kdRZjqB/oeCq+vL7eqw=;
	b=saExT09+6u4mB2JSWlocrsOV47J9h7y3501+pF7kF+AwdFra6OPXABJ4aVy4e1Z4VDyP
	 woLL+5FYuF1kgYTQteddIGL1MpIFEOW+7R4aDrpaLrEBpeerrMMi/Qx0pIrSd0F7B8xHU
	 mBao5cAn2Shj1E65GAEAtqR5VYR4X60GJwB3k08XULFFq0pPj7JE9nszlsz0gqPZVwnv+
	 CGD8j3Q5iIW0jCPj1M/HfF4XtSwCOBeN1hDjFCiQsL8hV0UwZ7V4Qv4DSNV1Ilj+hrC2k
	 sU31RfWldJUKHLfynCd5nkfNBvm8+4la+rsBXT+ExMEVcjgDLGWgTBnXkPqMgbC0+/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyNYVsx6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFC606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyNYVsx6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D20D1F0089F;
	Sat,  7 Nov 2026 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050235;
	bh=GeIudwWYIaTl7QNZ/Rz1cfQ7kdRZjqB/oeCq+vL7eqw=;
	h=From:To:Cc:Subject:Date;
	b=kyNYVsx609fDhwOXUmGWzDZf2cpkpEln0RbYVm7dbA+aHt6rMZz1r2Mgwg0ySumEd
	 DMTyCSIFzOWvHu0sQmvd9OJHnqgx2UFgMCt8dE+rGS6pU7I6kWjHmuIc6EfB2NcmAV
	 OCo/j1Wcr8xGTizlfw4oU+XN9tahH+1wVQQgVluv2msplh/IRAeSexA0DdsUkNPr5x
	 k47KIt8xhj5eDAn8E6adgR6C5sJ7z9HmRPWWfRXe6v3jodbx6e7wtbSXeyAgvb9hpG
	 zDfoQku1CLxszL62nJWC5BjmPhI6PUS9HN2pn/MDBPlzE5qR32IvRkqQVjMqW7B2NU
	 jTEdc+nqf5uiA==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:14 -0500
Message-ID: <20261107061713-failed-5.10-6b8b1d1d7bc7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1d1d7bc7e579b53fc7c3293b787d68de702a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061713-failed-5.10-6b8b1d1d7bc7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




