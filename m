Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049231;
	b=xzo3r9LQJq3wYfL59xxzhiPh/O3a22NeIu55MbunsmOW3RVNixl0KAGnJmPGgVklc5gn
	 BvFNccL90OM6WXABLC5sHm0OIhy/tWLIeZjh4JvI2qa/Zfc2ZQ9JzFtOvJzb1rhD2jnRC
	 8mb4T7DWOaSbwzo1j8/A4xRtnNzcGu+VCX8HiQNKuZOr2qsavUdRytw+KWJCTVyWXFyQW
	 DYMNaxr4DW1e6ccqB2+Iq1idaw2o0/ToRHS8ftZh350zbrNSVotVrmj7YHeoFkH8bMJJj
	 qSQ1YVEjlkk547CSQz0otPWPcjEAQnaMUVmFPFvDfpcjyNx9kR6+SEPmzJ+gsHGp2nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bOxQyBTaCvQwtTV0Ybq/0JC9X4tyNdOUXIR4wGES3v8=;
	b=NKtZtCaQDZRvdx2jPJmyOAF9AJ5KtkQbGJ8TXKlG2gyba6p91nRkcvEK9VxhpIq/Vqw7
	 fJlr0u2eNUYb4jgXrV32skUI3mC9mwFdwq9SCpJNdUAPpN6rE9EHLmUzsaAX6t4C7yHsy
	 yK9yG5Avx7UnKr0frNb/DGX2vLDMog2humyqccEKQgTqK14I1OGs8G77LJPP815tjgZMX
	 Mv4b38w8YBRfaBppCZLcv+Ba/Z3KC7qMZhdY2fe+4MqjZRlOg0PmmvHEwOy+T/WpGyAxd
	 cYwVN3ijvayG2q6GsDbgqgoJSctPmqv7PENtFZ0hbQIEMNq/bCqEl5jpi6kXwwO3x6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MU9Tozc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3780606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MU9Tozc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F051F0089F;
	Sat,  7 Nov 2026 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049230;
	bh=bOxQyBTaCvQwtTV0Ybq/0JC9X4tyNdOUXIR4wGES3v8=;
	h=From:To:Cc:Subject:Date;
	b=MU9Tozc80TytoEGo8XfccvXSr4/lpVIfutMMO4kJcO872BYsrzS10Cvy+C01YWV/6
	 CYY5jwK8dw6fVYst+xLa0yGdUa1GIYXsx1XPv/WW/lGfKkJNNpQ87nDM14CXHxyHMX
	 j1j/oT4D723UCxeGAXQVmEj8irhoZJbBty8cLZdJH7p+vAd0Sqn1V95D1rgXXaVuZe
	 jOU3uNgJD0sVsR0MKK7oyQ9ZyMW7LxVvRfHyfO4G/syLmR/yJJCJBXvnwO2Kbe4d8e
	 dQ/34r7F+J7k5oOJgSHwI9qouyeLkt2vU1K8WupqIajoAqdbYW1z8uDlSH2BDn1AZr
	 opZMUFLBXs0dQ==
From: Sasha Levin <sashal@kernel.org>
To: tom.verdonck@inspiral.be,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:28 -0500
Message-ID: <20261107060028-failed-5.15-56c1d32323e7@kernel.org>
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
git cherry-pick -x 56c1d32323e773b8b927316f8beeae9238576335
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060028-failed-5.15-56c1d32323e7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




