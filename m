Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047424;
	b=5oZM1Ue+uTwGLpirqq2e4Uf1m/J1tWTt+pCS2s2LdS0j22JElMavn4P89DwyrBLKdrkb
	 6/61coqbMPtLAv5VcsirehnRDtrl/3VjFOm4rOjGEsGRH1vcbhYVQnh/WPVSRrIxKfS3R
	 i7VucssayIQ6WHp4viH/s4qYajUVJzyWoeIiDT9oj41bu/1at76Dsve1f6IECD+730AAf
	 fh/S5w2LtOv1eEBm9WsPc8CbpKMvJZBKuOfyKMpHUvLgaY3fUuEgPmzyddy2QeLb2JJN1
	 h7+qAeIez2ruEgb1SvwfUtDBYpHo7DRAPjc+hIrruhP1G0h9QSCxS4T7P5F7stBL8CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=43SZfXDD65hq+IQoLgt3VSFF1E5Ofhl8S4tIfTECbwY=;
	b=sbbxE6Svb9aFHdK1WLPsxFy9Kl/zKZ1nbjtUp2o9QxQTusk11I1MHUrr6h3OT6/AS9kU
	 u9ihKVoGQBxbtWlNOLXff9n/X6EuzQf+ctNw3r7x0GQ/4bTbGLyDbTQ3oNY9eCyeEWmfJ
	 nBU78jxufm0zZyHge8kE6enPoHbrmK7PcqdHGZDx+Pg3BXJe7l/0W1NLf888LA49eE3RD
	 kIQV942Nn7uJwJ2+YRUsJaC/fQYZCPdrYttulHrBNzbAWmWZRbmoxaio0erbwa6Zy4iBU
	 vOpCFWouI0pkgzb6u6nAdJFEp27fEiKEWBs02sZ8umZNGcqe/LD7P3oy1T0Zqy2bNJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7R+oemq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA35606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7R+oemq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3081F008A1;
	Sat,  7 Nov 2026 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047424;
	bh=43SZfXDD65hq+IQoLgt3VSFF1E5Ofhl8S4tIfTECbwY=;
	h=From:To:Cc:Subject:Date;
	b=d7R+oemq7rwVdskGk+DnRHXVEYhm6Txjl5pHTlUC8oYclKmu6RMt26fsBh2lzl6p7
	 +auK4mQbOOjz36w4TI6240MCfDxnNfnA9RV+i945ZmlU9fETTvpqRDdmO2S1t+l6hm
	 68jF2Di5c79YRVRDHE8b484IKfv+hHFpRJ48s5+4eVVqPxdNtP6iPExPvpVyuhMC6w
	 v/OD0AAbnLOwCNJ+EpD34GLTTFtRNL94hxL6DVXCjtQpcyvR9ZSsG9vKbB9vgOa+32
	 YwwRS/V0nW5+qzbbhsw+uUKKtyJSvSXmcwMrSGrCN0Y+cPnlJjxKb0MU0gvgEJNt0j
	 j9Nn0ykz9ZU0A==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:22 -0500
Message-ID: <20261107053022-failed-6.6-56c1d32323e7@kernel.org>
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
git cherry-pick -x 56c1d32323e773b8b927316f8beeae9238576335
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053022-failed-6.6-56c1d32323e7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 56c1d32323e773b8b927316f8beeae9238576335 Mon Sep 17 00:00:00 2001
From: Tom Verdonck <tom.verdonck@inspiral.be>
Date: Fri, 25 Sep 2026 20:23:22 +0200
Subject: [PATCH] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready
 check

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
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 50a8b050d8da1..8c8463ddb6c45 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -58,7 +58,7 @@ struct tmp102 {
 	const char *label;
 	struct regmap *regmap;
 	u16 config_orig;
-	unsigned long ready_time;
+	u64 ready_time;
 	u16 sample_time;
 };
 
@@ -106,7 +106,7 @@ static int tmp102_read_temp(struct device *dev, u32 attr, long *val)
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp102->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp102->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
 			return -EAGAIN;
 		}
@@ -354,7 +354,7 @@ static int tmp102_probe(struct i2c_client *client)
 	 * Mark that we are not ready with data until the first
 	 * conversion is complete
 	 */
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 tmp102,
@@ -387,7 +387,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0




